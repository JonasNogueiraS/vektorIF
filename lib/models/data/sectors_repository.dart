import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vektor_if/models/sectors_model.dart';

class SectorsRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _userId => _auth.currentUser?.uid;

  // Adicionar Setor (Usa _userId pois só o dono pode criar)
  Future<void> addSector(SectorModel sector) async {
    if (_userId == null) throw Exception('Usuário não autenticado.');

    await _firestore
        .collection('institutions')
        .doc(_userId)
        .collection('sectors')
        .add(sector.toMap());
  }

  // Listar Setores (ATUALIZADO: Recebe ID para permitir visitantes)
  Stream<List<SectorModel>> getSectorsStream(String institutionId) {
    return _firestore
        .collection('institutions')
        .doc(institutionId) // <--- Agora usa o ID recebido
        .collection('sectors')
        .orderBy('name')
        .snapshots()
        .map((snapshot) {
      
      final List<SectorModel> visualSectors = [];

      for (var doc in snapshot.docs) {
        final data = doc.data();
        final baseSector = SectorModel.fromMap(data, doc.id);

        // Lógica para processar múltiplos pontos do mesmo setor
        if (data['coordinates'] != null && data['coordinates'] is List) {
          final List coords = data['coordinates'];
          for (var point in coords) {
            visualSectors.add(baseSector.copyWith(
              mapX: (point['x'] as num).toDouble(),
              mapY: (point['y'] as num).toDouble(),
            ));
          }
        } 
        // Retrocompatibilidade (formato antigo)
        else if (data['mapX'] != null && data['mapY'] != null) {
          visualSectors.add(baseSector);
        } else {
          visualSectors.add(baseSector);
        }
      }
      return visualSectors;
    });
  }

  // Métodos de Escrita (Mantêm o uso de _userId para segurança)

  Future<void> updateSectorCoordinates(String sectorId, double x, double y) async {
    if (_userId == null) return;
    await _firestore.collection('institutions').doc(_userId).collection('sectors').doc(sectorId).update({
      'mapX': x,
      'mapY': y,
    });
  }

  Future<void> saveSectorCoordinates(String sectorId, List<Map<String, double>> points) async {
    if (_userId == null) return;
    await _firestore.collection('institutions').doc(_userId).collection('sectors').doc(sectorId).update({
      'coordinates': points,
      'mapX': FieldValue.delete(),
      'mapY': FieldValue.delete(),
    });
  }

  Future<void> removeSectorCoordinates(String sectorId) async {
    if (_userId == null) return;
    await _firestore.collection('institutions').doc(_userId).collection('sectors').doc(sectorId).update({
      'coordinates': FieldValue.delete(),
      'mapX': FieldValue.delete(),
      'mapY': FieldValue.delete(),
    });
  }

  Future<void> deleteSector(String id) async {
    if (_userId == null) return;
    await _firestore.collection('institutions').doc(_userId).collection('sectors').doc(id).delete();
  }
}