import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MapRepository {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _userId => _auth.currentUser?.uid;

  // Envia a imagem para o Storage e salva a URL no Firestore
  Future<String> uploadMapImage(File imageFile) async {
    if (_userId == null) throw Exception("Usuário não logado");

    try {
      // Cria referência: institutions/{uid}/map_image.jpg
      final ref = _storage.ref().child('institutions/$_userId/map_image.jpg');

      // Upload
      await ref.putFile(imageFile);

      // Pega URL
      final imageUrl = await ref.getDownloadURL();

      // Atualiza documento da instituição
      await _firestore.collection('institutions').doc(_userId).update({
        'mapImageUrl': imageUrl,
      });

      return imageUrl;
    } catch (e) {
      throw Exception("Erro ao enviar imagem: $e");
    }
  }

  // Busca a URL atual do mapa
  Future<String?> getCurrentMapUrl() async {
    if (_userId == null) return null;
    try {
      final doc = await _firestore
          .collection('institutions')
          .doc(_userId)
          .get();
      if (doc.exists && doc.data() != null) {
        return doc.data()!['mapImageUrl'] as String?;
      }
    } catch (e) {
      print("Erro ao buscar mapa: $e");
    }
    return null;
  }

  Future<void> deleteMapImage() async {
    if (_userId == null) return;

    try {
      // 1. Remove do Firestore (limpa o campo mapImageUrl)
      await _firestore.collection('institutions').doc(_userId).update({
        'mapImageUrl': FieldValue.delete(), // Remove o campo do documento
      });

      // 2. Opcional: Remover o arquivo físico do Storage para economizar espaço
      // (Pode falhar se o arquivo não existir, então usamos try/catch silencioso ou verificamos)
      try {
        final ref = _storage.ref().child('institutions/$_userId/map_image.jpg');
        await ref.delete();
      } catch (_) {
        // Ignora erro se o arquivo já não existia no storage
      }
    } catch (e) {
      throw Exception("Erro ao remover mapa: $e");
    }
  }
}
