import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Login e Instituição
  Future<void> registerUser({
    required String email,
    required String password,
    required String name,
    required String institutionName,
    required String institutionAddress,
  }) async {
    try {
      // 1. Cria o usuário
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      if (user != null) {
        // Atualiza o nome do perfil no Auth
        await user.updateDisplayName(name);

        // Salva os dados no Firestore
        await _firestore.collection('institutions').doc(user.uid).set({
          'managerName': name,
          'managerEmail': email,
          'institutionName': institutionName,
          'institutionAddress': institutionAddress,
          'uid': user.uid,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('A senha fornecida é muito fraca.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('Já existe uma conta com este e-mail.');
      }
      throw Exception(e.message ?? 'Erro ao cadastrar.');
    } catch (e) {
      throw Exception('Erro desconhecido: $e');
    }
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('Usuário não encontrado.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Senha incorreta.');
      } else if (e.code == 'invalid-credential') {
        throw Exception('E-mail ou senha inválidos.');
      }
      throw Exception(e.message ?? 'Erro ao realizar login.');
    }
  }

  // LOGOUT
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
