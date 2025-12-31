import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vektor_if/core/widgets/success_feedback_dialog.dart'; 
import 'package:vektor_if/providers/auth_provider.dart';

class RegisterController extends ChangeNotifier {
  // Inputs
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final institutionNameController = TextEditingController(); 
  final addressController = TextEditingController(); 
  //visibilidade de senha
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

  Future<void> registerUser(BuildContext context) async {
    // Validação de UI 
    if (passwordController.text != confirmPasswordController.text) {
      _showSnackBar(context, "As senhas não coincidem.", Colors.orange);
      return;
    }

    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        institutionNameController.text.isEmpty ||
        addressController.text.isEmpty) {
      _showSnackBar(context, "Preencha todos os campos obrigatórios.", Colors.orange);
      return;
    }

    //Chama o Provider 
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    await authProvider.register(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      name: nameController.text.trim(),
      institutionName: institutionNameController.text.trim(),
      institutionAddress: addressController.text.trim(),
    );

    if (!context.mounted) return;

    //Verifica Resultado
    if (authProvider.errorMessage != null) {
      // Erro do Firebase
      _showSnackBar(context, authProvider.errorMessage!, Colors.red);
    } else {
      // Sucesso! Mostra o Dialog de Feedback
      _showSuccessDialog(context);
    }
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const SuccessFeedbackDialog(
        title: "Cadastro Realizado!",
        subtitle: "Você será redirecionado para o gerenciamento...",
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (context.mounted) {
        // Remove dialog
        Navigator.of(context).pop(); 
        // Vai para Management
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/management',
          (route) => false,
        );
      }
    });
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