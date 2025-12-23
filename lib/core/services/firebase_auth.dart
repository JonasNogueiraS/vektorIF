import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> registerUser({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      await userCredential.user?.updateDisplayName(name);
      
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

  // --- LOGIN
  Future<void> loginUser({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      // Tratamento de erros
      if (e.code == 'user-not-found') {
        throw Exception('Usuário não encontrado.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Senha incorreta.');
      } else if (e.code == 'invalid-credential') {
        throw Exception('E-mail ou senha inválidos.');
      } else if (e.code == 'invalid-email') {
        throw Exception('O formato do e-mail é inválido.');
      } else if (e.code == 'user-disabled') {
        throw Exception('Este usuário foi desativado.');
      }
      
      throw Exception(e.message ?? 'Erro ao realizar login.');
    } catch (e) {
      throw Exception('Erro desconhecido: $e');
    }
  }

  // LOGOUT 
  Future<void> signOut() async {
    await _auth.signOut();
  }
  
  User? get currentUser => _auth.currentUser;
}