import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/core/widgets/background_image.dart';
import 'package:vektor_if/core/widgets/buttom_generic.dart';
import 'package:vektor_if/core/widgets/custom_back_button.dart';
import 'package:vektor_if/core/widgets/forms_widgets.dart';
import 'package:vektor_if/providers/auth_provider.dart'; 
import 'package:vektor_if/screens/register/controller/register_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Instanciamos o Controller
  final _controller = RegisterController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                //HEADER
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

                //FORMULÁRIO
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
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
                      // Escuta mudanças de UI do Controller (senhas, textos)
                      child: ListenableBuilder(
                        listenable: _controller,
                        builder: (context, child) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // DADOS DO USUÁRIO
                              const FormLabel("Nome completo"),
                              GenericInputField(
                                controller: _controller.nameController,
                                hint: "ex: Joao da Silva",
                                outlined: true,
                              ),

                              const FormLabel("Informe o e-mail"),
                              GenericInputField(
                                controller: _controller.emailController,
                                hint: "emaildousuario@gmail.com",
                                keyboardType: TextInputType.emailAddress,
                                outlined: true,
                              ),

                              const FormLabel("Informe a senha"),
                              GenericInputField(
                                controller: _controller.passwordController,
                                hint: "********",
                                outlined: true,
                                isPassword: true,
                                obscureText: _controller.obscurePassword,
                                onToggleVisibility: _controller.togglePasswordVisibility,
                              ),

                              const FormLabel("Confirme a senha"),
                              GenericInputField(
                                controller: _controller.confirmPasswordController,
                                hint: "********",
                                outlined: true,
                                isPassword: true,
                                obscureText: _controller.obscureConfirmPassword,
                                onToggleVisibility: _controller.toggleConfirmPasswordVisibility,
                              ),

                              const SizedBox(height: 30),

                              // DADOS DA INSTITUIÇÃO
                              CircularImagePicker(
                                label: "Adicione uma foto da instituição",
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Funcionalidade futura (Upload de Imagem)")),
                                  );
                                },
                              ),

                              const SizedBox(height: 16),

                              const FormLabel("Nome da Instituição"),
                              GenericInputField(
                                controller: _controller.institutionNameController,
                                hint: "ex: Instituto Federal do Maranhão",
                                outlined: true,
                              ),

                              const FormLabel("Endereço"),
                              GenericInputField(
                                controller: _controller.addressController,
                                hint: "ex: Av. Santos do Santos",
                                outlined: true,
                              ),

                              const SizedBox(height: 30),

                              // BOTÃO SALVAR
                              Consumer<AuthProvider>(
                                builder: (context, authProvider, _) {
                                  return ButtomGeneric(
                                    label: "Salvar",
                                    // Ação vai para o Controller
                                    onPressed: () => _controller.registerUser(context),
                                    // Estado de Loading vem do Provider Global
                                    isLoading: authProvider.isLoading, 
                                  );
                                },
                              ),
                              const SizedBox(height: 20),
                            ],
                          );
                        },
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