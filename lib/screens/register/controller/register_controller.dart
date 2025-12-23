import 'package:flutter/material.dart';

class RegisterController extends ChangeNotifier {
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

  Future<void> registerUser({required VoidCallback onSuccess}) async {
    isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 2));
      onSuccess();

    } catch (e) {
      
      debugPrint("Erro ao registrar: $e");
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
