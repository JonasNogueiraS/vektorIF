import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vektor_if/models/sectors_model.dart';

class SectorsRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _userId => _auth.currentUser?.uid;

  // Adicionar
  Future<void> addSector(SectorModel sector) async {
    if (_userId == null) throw Exception('Usuário não autenticado.');

    await _firestore
        .collection('institutions')
        .doc(_userId)
        .collection('sectors')
        .add(sector.toMap());
  }

  // Listar (Stream)
  Stream<List<SectorModel>> getSectorsStream() {
    if (_userId == null) return const Stream.empty();

    return _firestore
        .collection('institutions')
        .doc(_userId)
        .collection('sectors')
        .orderBy('name')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return SectorModel.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

  // Deletar
  Future<void> deleteSector(String sectorId) async {
    if (_userId == null) return;

    await _firestore
        .collection('institutions')
        .doc(_userId)
        .collection('sectors')
        .doc(sectorId)
        .delete();
  }
}