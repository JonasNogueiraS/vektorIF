import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/core/widgets/background_image.dart';
import 'package:vektor_if/core/widgets/buttom_generic.dart';
import 'package:vektor_if/core/widgets/custom_back_button.dart';
import 'package:vektor_if/core/widgets/forms_widgets.dart'; 
import 'package:vektor_if/core/widgets/success_feedback_dialog.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _institutionNameController = TextEditingController();
  final _addressController = TextEditingController();

  // Estados
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _institutionNameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    setState(() => _isLoading = false);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const SuccessFeedbackDialog(
        title: "Cadastro Realizado!",
        subtitle: "Você será redirecionado para o gerenciamento...",
      ),
    );

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    Navigator.of(context).pop();
    Navigator.pushNamedAndRemoveUntil(context, '/management', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorBackground,
      body: Stack(
        children: [
          const BackgroundImage(),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header (Botão Voltar e Título)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomBackButtom(),
                      const SizedBox(height: 20),
                      Text(
                        "Faça seu cadastro",
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Crie uma conta gratuitamente",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.colorGrayText,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Card do Formulário
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          10,
                        ),
                        topRight: Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, -5),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // DADOS DO USUÁRIO 
                          const FormLabel("Nome completo"),
                          GenericInputField(
                            controller: _nameController,
                            hint: "ex: Joao da Silva",
                            outlined: true, // Estilo Branco com Borda
                          ),

                          const FormLabel("Informe o e-mail"),
                          GenericInputField(
                            controller: _emailController,
                            hint: "emaildousuario@gmail.com",
                            keyboardType: TextInputType.emailAddress,
                            outlined: true,
                          ),

                          const FormLabel("Informe a senha"),
                          GenericInputField(
                            controller: _passwordController,
                            hint: "********",
                            outlined: true,
                            isPassword: true,
                            obscureText: _obscurePassword,
                            onToggleVisibility: () => setState(
                              () => _obscurePassword = !_obscurePassword,
                            ),
                          ),

                          const FormLabel("Confirme a senha"),
                          GenericInputField(
                            controller: _confirmPasswordController,
                            hint: "********",
                            outlined: true,
                            isPassword: true,
                            obscureText: _obscureConfirmPassword,
                            onToggleVisibility: () => setState(
                              () => _obscureConfirmPassword =
                                  !_obscureConfirmPassword,
                            ),
                          ),
                          const SizedBox(height: 30),
                          // DADOS DA INSTITUIÇÃO
                          CircularImagePicker(
                            label: "Adicione uma foto da instituição",
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Abrir galeria..."),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 16),

                          const FormLabel("Nome da Instituição"),
                          GenericInputField(
                            controller: _institutionNameController,
                            hint: "ex: Instituto Federal do Maranhão",
                            outlined: true,
                          ),

                          const FormLabel("Endereço"),
                          GenericInputField(
                            controller: _addressController,
                            hint: "ex: Av. Santos do Santos",
                            outlined: true,
                          ),
                          const SizedBox(height: 30),

                          // --- BOTÃO SALVAR ---
                          ButtomGeneric(
                            label: "Salvar",
                            onPressed: _handleRegister,
                            isLoading: _isLoading,
                          ),

                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
