import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vektor_if/providers/auth_provider.dart';

class LoginController extends ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Visibilidade da Senha
  bool obscurePassword = true;

  // Alternar visibilidade
  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  //Login
  Future<void> login(BuildContext context) async {
    //Validação
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Preencha e-mail e senha."),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    //Provider
    //listen false porque só queremos disparar a ação, não ouvir mudanças
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    await authProvider.login(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    //Verifica o resultado no Provider
    if (context.mounted) {
      if (authProvider.errorMessage != null) {
        // caso de erro
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authProvider.errorMessage!),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        // Sucesso
        Navigator.pushNamedAndRemoveUntil(context, '/management', (route) => false);
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}