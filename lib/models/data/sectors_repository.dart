import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vektor_if/models/sectors_model.dart';

class SectorsRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _userId => _auth.currentUser?.uid;

  // Adicionar Setor (Dados Cadastrais)
  Future<void> addSector(SectorModel sector) async {
    if (_userId == null) throw Exception('Usuário não autenticado.');

    await _firestore
        .collection('institutions')
        .doc(_userId)
        .collection('sectors')
        .add(sector.toMap());
  }

  // Listar Setores
  Stream<List<SectorModel>> getSectorsStream() {
    if (_userId == null) return const Stream.empty();

    return _firestore
        .collection('institutions')
        .doc(_userId)
        .collection('sectors')
        .orderBy('name')
        .snapshots()
        .map((snapshot) {
      
      final List<SectorModel> visualSectors = [];

      for (var doc in snapshot.docs) {
        final data = doc.data();
        final baseSector = SectorModel.fromMap(data, doc.id);

        // Verifica se tem lista de coordenadas (Novo formato)
        if (data['coordinates'] != null && data['coordinates'] is List) {
          final List coords = data['coordinates'];
          for (var point in coords) {
            // Para cada ponto salvo, cria um "Pino" visual
            visualSectors.add(baseSector.copyWith(
              mapX: (point['x'] as num).toDouble(),
              mapY: (point['y'] as num).toDouble(),
            ));
          }
        } 
        // Verifica formato antigo (mapX/mapY soltos) para retrocompatibilidade
        else if (data['mapX'] != null && data['mapY'] != null) {
          visualSectors.add(baseSector); // Já pegou X e Y no fromMap
        } 
        // Se não tem coordenadas, retorna o setor "sem mapa" para aparecer na lista de seleção
        else {
          visualSectors.add(baseSector);
        }
      }
      return visualSectors;
    });
  }

  // Atualizar Lista de Coordenadas de um Setor
  // Recebe TODAS as posições desse setor de uma vez
  Future<void> saveSectorCoordinates(String sectorId, List<Map<String, double>> points) async {
    if (_userId == null) return;

    await _firestore
        .collection('institutions')
        .doc(_userId)
        .collection('sectors')
        .doc(sectorId)
        .update({
      'coordinates': points, // Salva a lista: [{'x':10, 'y':10}, {'x':20, 'y':20}]
      'mapX': FieldValue.delete(),
      'mapY': FieldValue.delete(),
    });
  }

  // Limpar todas as coordenadas de um setor
  Future<void> removeSectorCoordinates(String sectorId) async {
    if (_userId == null) return;
    
    await _firestore
        .collection('institutions')
        .doc(_userId)
        .collection('sectors')
        .doc(sectorId)
        .update({
      'coordinates': FieldValue.delete(),
      'mapX': FieldValue.delete(),
      'mapY': FieldValue.delete(),
    });
  }
  
  // Deletar Setor (Remove o cadastro completo)
  Future<void> deleteSector(String id) async {
    if (_userId == null) return;
    await _firestore
        .collection('institutions')
        .doc(_userId)
        .collection('sectors')
        .doc(id)
        .delete();
  }
}