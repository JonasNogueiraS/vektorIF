// ignore: file_names
import 'package:flutter/material.dart';
import 'package:vektor_if/core/services/firebase_auth.dart';

class LoginController extends ChangeNotifier {
  final AuthService _authService = AuthService();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;
  bool obscurePassword = true;

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  Future<void> login({
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) async {

    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      onError("Preencha e-mail e senha.");
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      await _authService.loginUser(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      
      onSuccess(); 

    } catch (e) {
      // Formata a mensagem de erro
      onError(e.toString().replaceAll("Exception: ", ""));
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}