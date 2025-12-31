import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/core/themes/size_extensions.dart';
import 'package:vektor_if/core/widgets/background_image.dart';
import 'package:vektor_if/core/widgets/buttom_generic.dart';
import 'package:vektor_if/core/widgets/forms_widgets.dart';
import 'package:vektor_if/providers/auth_provider.dart';
// Importe o seu controller
import 'package:vektor_if/screens/loginscreen/controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Instancia o Controller
  final _controller = LoginController();

  @override
  void dispose() {
    _controller.dispose(); //limpar a memória
    super.dispose();
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
                // ListenableBuilder reconstrói a tela se o controller notificar
                child: ListenableBuilder(
                  listenable: _controller,
                  builder: (context, child) {
                    return Column(
                      children: [
                        // HEADER 
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
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Seu guia institucional",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: AppTheme.colorBlackText
                                                .withValues(alpha: 0.6),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        //INPUTS 
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(height: 16),

                                const FormLabel("E-mail"),
                                GenericInputField(
                                  controller: _controller
                                      .emailController, // Controller gerencia
                                  hint: "seuemail@algumacoisa.com",
                                  keyboardType: TextInputType.emailAddress,
                                  outlined: true,
                                ),

                                const SizedBox(height: 14),

                                const FormLabel("Senha"),
                                GenericInputField(
                                  controller: _controller
                                      .passwordController, // Controller gerencia
                                  hint: "******",
                                  isPassword: true,
                                  outlined: true,
                                  obscureText: _controller
                                      .obscurePassword, // Estado do Controller
                                  onToggleVisibility: _controller
                                      .togglePasswordVisibility, // Ação do Controller
                                ),

                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Esqueceu sua senha?",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: AppTheme.colorBlackText,
                                          ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 16),

                                // BOTÃO CONECTADO
                                // O isLoading vem do Provider, pois é um estado global de rede
                                Consumer<AuthProvider>(
                                  builder: (context, authProvider, _) {
                                    return ButtomGeneric(
                                      label: "ENTRAR",
                                      onPressed: () =>
                                          _controller.login(context),
                                      isLoading: authProvider.isLoading,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),

                        //RODAPÉ
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
