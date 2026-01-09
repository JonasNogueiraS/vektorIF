import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; 
import 'package:vektor_if/models/data/map_repository.dart';
import 'package:vektor_if/models/data/sectors_repository.dart';
import 'package:vektor_if/models/sectors_model.dart';

class MapEditorController extends ChangeNotifier {
  final _mapRepo = MapRepository();
  final _sectorsRepo = SectorsRepository();

  List<SectorModel> mappedSectors = [];
  String? backendMapUrl;
  bool isLoading = true;

  Future<void> loadInitialData() async {
    isLoading = true;
    notifyListeners();
    try {
      backendMapUrl = await _mapRepo.getCurrentMapUrl();
      //Pega o ID do usuário logado
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        //Passa o ID para o método
        final allSectors = await _sectorsRepo.getSectorsStream(userId).first;
        
        mappedSectors = allSectors
            .where((s) => s.mapX != null && s.mapY != null)
            .toList();
      }
          
    } catch (e) {
      debugPrint("Erro ao carregar: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  
  void addSector(Offset position, SectorModel originalSector) {
    final newPin = originalSector.copyWith(
      mapX: position.dx,
      mapY: position.dy,
    );
    mappedSectors.add(newPin);
    notifyListeners();
  }

  void removeSector(SectorModel sector) {
    mappedSectors.remove(sector);
    notifyListeners();
  }

  Future<void> clearAllMarkers() async {
    isLoading = true;
    notifyListeners();
    try {
      final uniqueIds = mappedSectors.map((s) => s.id!).toSet();
      await Future.wait(
        uniqueIds.map((id) => _sectorsRepo.removeSectorCoordinates(id))
      );
      mappedSectors.clear();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> removeMap() async {
    isLoading = true;
    notifyListeners();
    try {
      await _mapRepo.deleteMapImage();
      if (mappedSectors.isNotEmpty) {
        final uniqueIds = mappedSectors.map((s) => s.id!).toSet();
        await Future.wait(
          uniqueIds.map((id) => _sectorsRepo.removeSectorCoordinates(id))
        );
      }
      mappedSectors.clear();
      backendMapUrl = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveMap({required VoidCallback onSuccess, required Function(String) onError}) async {
    isLoading = true;
    notifyListeners();
    try {
      final Map<String, List<Map<String, double>>> groupedCoords = {};

      for (var sector in mappedSectors) {
        if (sector.id == null || sector.mapX == null || sector.mapY == null) continue;

        if (!groupedCoords.containsKey(sector.id!)) {
          groupedCoords[sector.id!] = [];
        }
        
        groupedCoords[sector.id!]!.add({
          'x': sector.mapX!,
          'y': sector.mapY!,
        });
      }

      for (var entry in groupedCoords.entries) {
        await _sectorsRepo.saveSectorCoordinates(entry.key, entry.value);
      }
      
      onSuccess();
    } catch (e) {
      onError(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}