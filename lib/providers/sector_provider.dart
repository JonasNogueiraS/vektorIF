import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vektor_if/models/sectors_model.dart';

class SectorProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Lista local para exibição
  List<SectorModel> _sectors = [];
  bool _isLoading = false;

  List<SectorModel> get sectors => _sectors;
  bool get isLoading => _isLoading;


  //Listagem
  void startListeningToSectors(String institutionId) {
    _setLoading(true);
    
    _firestore
        .collection('institutions')
        .doc(institutionId)
        .collection('sectors')
        .orderBy('name')
        .snapshots()
        .listen((snapshot) {
      
      _sectors = snapshot.docs.map((doc) {
        return SectorModel.fromMap(doc.data(), doc.id);
      }).toList();

      _setLoading(false);
    }, onError: (e) {
      print("Erro ao carregar setores: $e");
      _setLoading(false);
    });
  }

  //Adicionar Setor
  Future<void> addSector({
    required String institutionId,
    required SectorModel sector,
  }) async {
    _setLoading(true);
    try {
      await _firestore
          .collection('institutions')
          .doc(institutionId)
          .collection('sectors')
          .add(sector.toMap());
      
    } catch (e) {
      rethrow; // Joga o erro para a tela tratar
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateSector({
    required String institutionId,
    required SectorModel sector,
  }) async {
    _setLoading(true);
    try {
      if (sector.id == null) throw Exception("ID do setor inválido para edição");

      await _firestore
          .collection('institutions')
          .doc(institutionId)
          .collection('sectors')
          .doc(sector.id)
          .update(sector.toMap());
          
    } catch (e) {
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  //Deletar Setor
  Future<void> deleteSector(String institutionId, String sectorId) async {
    try {
      await _firestore
          .collection('institutions')
          .doc(institutionId)
          .collection('sectors')
          .doc(sectorId)
          .delete();
    } catch (e) {
      rethrow;
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}