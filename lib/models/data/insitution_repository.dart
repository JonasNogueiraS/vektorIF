import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vektor_if/models/institution_model.dart';

class InstitutionRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Busca a instituição do Gerente Logado (Já existia)
  Future<InstitutionModel?> getMyInstitution() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    try {
      final doc = await _firestore.collection('institutions').doc(user.uid).get();
      if (doc.exists && doc.data() != null) {
        return InstitutionModel.fromMap(doc.data()!, doc.id);
      }
    } catch (e) {
      throw Exception('Erro ao buscar instituição: $e');
    }
    return null;
  }

  // Atualiza instituição (Já existia)
  Future<void> updateInstitution(InstitutionModel institution) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('Usuário não logado');

    try {
      await _firestore
          .collection('institutions')
          .doc(user.uid)
          .update(institution.toMap());
    } catch (e) {
      throw Exception('Erro ao atualizar instituição: $e');
    }
  }

  // Lista TODAS as instituições
  Stream<List<InstitutionModel>> getAllInstitutions() {
    return _firestore.collection('institutions').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return InstitutionModel.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }
}