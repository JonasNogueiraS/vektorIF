import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/core/themes/size_extensions.dart';
import 'package:vektor_if/core/widgets/background_image.dart';
import 'package:vektor_if/core/widgets/buttom_generic.dart';
import 'package:vektor_if/core/widgets/forms_widgets.dart';
import 'package:vektor_if/screens/loginscreen/controller/loginController.dart'; 

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  final _controller = LoginController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //conectado ao Firebase
  void _handleLogin() {
    _controller.login(
      onSuccess: () {
        if (!mounted) return;
        // Redireciona para o gerenciamento removendo a tela de login da pilha
        Navigator.pushNamedAndRemoveUntil(context, '/management', (route) => false);
      },
      onError: (message) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorBackground,
      resizeToAvoidBottomInset: true,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: ListenableBuilder( // Ouve as mudanças do Controller
                  listenable: _controller,
                  builder: (context, child) {
                    return Column(
                      children: [
                        // 1. HEADER (Mantido Igual)
                        SizedBox(
                          height: context.percentHeight(0.38),
                          child: Stack(
                            children: [
                              const BackgroundImage(),
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      size: 60,
                                      color: AppTheme.colorLogo,
                                    ),
                                    const SizedBox(height: 8),
                                    RichText(
                                      text: TextSpan(
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall
                                            ?.copyWith(
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold,
                                              color: AppTheme.colorBlackText,
                                            ),
                                        children: const [
                                          TextSpan(text: "VEKTOR"),
                                          TextSpan(
                                            text: "IF",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Seu guia institucional",
                                      style: Theme.of(context).textTheme.bodyMedium
                                          ?.copyWith(
                                            color: AppTheme.colorBlackText.withValues(alpha: 0.6),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Inputs Conectados ao Controller
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: context.percentWidth(0.06),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const SizedBox(height: 16),
                                Text(
                                  "FAÇA LOGIN",
                                  style: Theme.of(context).textTheme.headlineMedium
                                      ?.copyWith(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(height: 16),

                                const FormLabel("E-mail"),
                                GenericInputField(
                                  controller: _controller.emailController, // Controller
                                  hint: "seuemail@algumacoisa.com",
                                  keyboardType: TextInputType.emailAddress,
                                  outlined: true,
                                ),

                                const SizedBox(height: 14),

                                const FormLabel("Senha"),
                                GenericInputField(
                                  controller: _controller.passwordController, // Controller
                                  hint: "******",
                                  isPassword: true,
                                  outlined: true,
                                  obscureText: _controller.obscurePassword, // Estado
                                  onToggleVisibility: _controller.togglePasswordVisibility, // Ação
                                ),

                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      // Implementar recuperação de senha futuramente!!!
                                    },
                                    child: Text(
                                      "Esqueceu sua senha?",
                                      style: Theme.of(context).textTheme.labelSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: AppTheme.colorBlackText,
                                          ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 16),

                                ButtomGeneric(
                                  label: "ENTRAR",
                                  onPressed: _handleLogin, // login real
                                  isLoading: _controller.isLoading, //Loading real
                                ),
                              ],
                            ),
                          ),
                        ),

                        // 3. RODAPÉ (Mantido Igual)
                        SafeArea(
                          top: false,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20, top: 10),
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                  children: [
                                    const TextSpan(text: "Novo usuário? "),
                                    TextSpan(
                                      text: "Faça seu cadastro",
                                      style: const TextStyle(
                                        color: AppTheme.colorLogo,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () => Navigator.pushNamed(
                                          context,
                                          '/register',
                                        ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}