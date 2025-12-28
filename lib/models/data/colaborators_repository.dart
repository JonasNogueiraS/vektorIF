import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vektor_if/models/colaborators_model.dart';

class CollaboratorRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _userId => _auth.currentUser?.uid;

  // Referência para a coleção 
  CollectionReference get _collaboratorsCollection {
    if (_userId == null) throw Exception('Usuário não autenticado.');
    return _firestore
        .collection('institutions')
        .doc(_userId)
        .collection('collaborators');
  }

  //REGRA DE CHEFE ÚNICO
  Future<void> addCollaborator(CollaboratorModel collaborator) async {
    //rebaixar chefe atual 
    if (collaborator.isBoss) {
      await _demoteCurrentBoss(collaborator.sectorId);
    }

    //novo colaborador
    await _collaboratorsCollection.add(collaborator.toMap());
  }

  //MÉTODO PRIVADO PARA REMOVER A CHEFIA
  Future<void> _demoteCurrentBoss(String sectorId) async {
    // Busca: Colaboradores DO MESMO SETOR que SÃO CHEFES
    final querySnapshot = await _collaboratorsCollection
        .where('sectorId', isEqualTo: sectorId)
        .where('isBoss', isEqualTo: true)
        .get();

    // Se encontrou alguém (usamos loop para verificar)
    for (var doc in querySnapshot.docs) {
      // Atualiza o documento definindo isBoss como false
      await doc.reference.update({'isBoss': false});
    }
  }

  // Listar Colaboradores-Stream
  Stream<List<CollaboratorModel>> getCollaboratorsStream() {
    if (_userId == null) return const Stream.empty();

    return _collaboratorsCollection
        .orderBy('name')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return CollaboratorModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  // Deletar
  Future<void> deleteCollaborator(String id) async {
    await _collaboratorsCollection.doc(id).delete();
  }
}