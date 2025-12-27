import 'package:flutter/material.dart';
import 'package:vektor_if/core/services/firebase_auth.dart';

class RegisterController extends ChangeNotifier {
  final AuthService _authService = AuthService();

  // Inputs
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final institutionNameController = TextEditingController(); 
  final addressController = TextEditingController(); 

  bool isLoading = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword = !obscureConfirmPassword;
    notifyListeners();
  }

  Future<void> registerUser({
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) async {
    // Senhas
    if (passwordController.text != confirmPasswordController.text) {
      onError("As senhas não coincidem.");
      return;
    }

    //  Campos Vazios
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        institutionNameController.text.isEmpty ||
        addressController.text.isEmpty) {
      onError("Preencha todos os campos obrigatórios.");
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      // passando TUDO
      await _authService.registerUser(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        name: nameController.text.trim(),
        institutionName: institutionNameController.text.trim(),
        institutionAddress: addressController.text.trim(),
      );

      onSuccess();
    } catch (e) {
      onError(e.toString().replaceAll("Exception: ", ""));
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    institutionNameController.dispose();
    addressController.dispose();
    super.dispose();
  }
}
