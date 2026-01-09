import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vektor_if/models/colaborators_model.dart';

class CollaboratorProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<CollaboratorModel> _collaborators = [];
  bool _isLoading = false;

  List<CollaboratorModel> get collaborators => _collaborators;
  bool get isLoading => _isLoading;

  // AÇÕES 

  // 1. Listar (Escuta em Tempo Real)
  void startListeningToCollaborators(String institutionId) {
    _setLoading(true);
    
    _firestore
        .collection('institutions')
        .doc(institutionId)
        .collection('collaborators')
        .orderBy('name')
        .snapshots()
        .listen((snapshot) {
      
      _collaborators = snapshot.docs.map((doc) {
        return CollaboratorModel.fromMap(doc.data(), doc.id);
      }).toList();

      _setLoading(false);
    }, onError: (e) {
      print("Erro ao carregar colaboradores: $e");
      _setLoading(false);
    });
  }

  // 2. Adicionar Colaborador (Com regra de Chefe)
  Future<void> addCollaborator({
    required String institutionId,
    required CollaboratorModel collaborator,
  }) async {
    _setLoading(true);
    try {
      final collectionRef = _firestore
          .collection('institutions')
          .doc(institutionId)
          .collection('collaborators');

      // Se for chefe, verifica se já existe um no setor e rebaixa
      if (collaborator.isBoss) {
        await _demoteCurrentBoss(collectionRef, collaborator.sectorId);
      }

      await collectionRef.add(collaborator.toMap());
      
    } catch (e) {
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  // Lógica de Rebaixar Chefe (Privada)
  Future<void> _demoteCurrentBoss(CollectionReference collection, String sectorId) async {
    final querySnapshot = await collection
        .where('sectorId', isEqualTo: sectorId)
        .where('isBoss', isEqualTo: true)
        .get();

    for (var doc in querySnapshot.docs) {
      await doc.reference.update({'isBoss': false});
    }
  }

  Future<void> updateCollaborator({
    required String institutionId,
    required CollaboratorModel collaborator,
  }) async {
    _setLoading(true);
    try {
      if (collaborator.id == null) throw Exception("ID inválido");

      final collectionRef = _firestore
          .collection('institutions')
          .doc(institutionId)
          .collection('collaborators');

      // Se virou chefe, rebaixa o anterior
      if (collaborator.isBoss) {
        await _demoteCurrentBoss(collectionRef, collaborator.sectorId);
      }

      await collectionRef
          .doc(collaborator.id)
          .update(collaborator.toMap());

    } catch (e) {
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  // Deletar
  Future<void> deleteCollaborator(String institutionId, String collaboratorId) async {
    try {
      await _firestore
          .collection('institutions')
          .doc(institutionId)
          .collection('collaborators')
          .doc(collaboratorId)
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