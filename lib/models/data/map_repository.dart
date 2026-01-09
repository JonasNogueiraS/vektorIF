import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MapRepository {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _userId => _auth.currentUser?.uid;

  //MÉTODOS DE LEITURA

  // 1. CORREÇÃO DO ERRO: Método que aceita ID externo (para visitantes)
  Future<String?> getMapUrl(String institutionId) async {
    try {
      final doc = await _firestore.collection('institutions').doc(institutionId).get();
      
      // Verifica se o documento existe e tem a URL da imagem
      if (doc.exists && doc.data() != null && doc.data()!.containsKey('mapImageUrl')) {
        return doc.data()!['mapImageUrl'] as String;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // 2. Método para o Editor (Usa o ID do usuário logado)
  Future<String?> getCurrentMapUrl() async {
    if (_userId == null) return null;
    return getMapUrl(_userId!); // Reutiliza a lógica acima
  }

  //MÉTODOS DE ESCRITA (Somente Logado)

  Future<void> uploadMapImage(File imageFile) async {
    if (_userId == null) return;

    try {
      // Salva no Storage
      final ref = _storage.ref().child('institutions/$_userId/map_image.jpg');
      await ref.putFile(imageFile);
      final url = await ref.getDownloadURL();

      // Salva link no Firestore
      await _firestore.collection('institutions').doc(_userId).update({
        'mapImageUrl': url,
      });
    } catch (e) {
      throw Exception('Erro ao fazer upload: $e');
    }
  }

  Future<void> deleteMapImage() async {
    if (_userId == null) return;

    try {
      // Remove link do Firestore
      await _firestore.collection('institutions').doc(_userId).update({
        'mapImageUrl': FieldValue.delete(),
      });

      // Tenta remover arquivo do Storage
      try {
        final ref = _storage.ref().child('institutions/$_userId/map_image.jpg');
        await ref.delete();
      } catch (_) {
        // Ignora se o arquivo já não existir
      }
    } catch (e) {
      throw Exception("Erro ao remover mapa: $e");
    }
  }
}