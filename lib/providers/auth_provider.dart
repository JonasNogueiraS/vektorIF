import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vektor_if/core/services/firebase_auth.dart';

class AuthProvider extends ChangeNotifier {
  //Instância do Serviço 
  final AuthService _authService = AuthService();

  //Variáveis de Estado
  User? _user;
  bool _isLoading = false;
  String? _errorMessage;

  //Getters: Para a tela ler as variáveis, mas não alterá-las diretamente
  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuth => _user != null; // Atalho para verificar login
  //CONSTRUTOR: Vigia o Firebase Auth em tempo real
  AuthProvider() {
    // Sempre que alguém logar ou deslogar,
    // o Firebase avisa aqui e nós atualizamos o app.
    FirebaseAuth.instance.authStateChanges().listen((User? newUser) {
      _user = newUser;
      notifyListeners();
    });
  }
  //AÇÕES (entre a Tela e o Serviço) 
  Future<void> login(String email, String password) async {
    _setLoading(true);
    _errorMessage = null; // Limpa erros antigos

    try {
      // Chama arquivo firebase_auth.dart existente
      await _authService.loginUser(email: email, password: password);
      
      // NOTA: Não precisamos definir _user aqui manualmente. 
      // O listener no construtor vai detectar o login automaticamente. 
    } catch (e) {
      // Captura o erro do serviço e formata para a tela
      _errorMessage = e.toString().replaceAll("Exception: ", "");
    } finally {
      _setLoading(false);
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required String name,
    required String institutionName,
    required String institutionAddress,
  }) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      // Repassa os dados criar a conta e salvar no Firestore
      await _authService.registerUser(
        email: email,
        password: password,
        name: name,
        institutionName: institutionName,
        institutionAddress: institutionAddress,
      );
    } catch (e) {
      _errorMessage = e.toString().replaceAll("Exception: ", "");
    } finally {
      _setLoading(false);
    }
  }
  Future<void> logout() async {
    await _authService.signOut();
  }
  // AUXILIARES
  // evitar repetir código de loading
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners(); //diz ao Flutter para redesenhar a tela
  } 
  // Limpa a mensagem de erro
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}