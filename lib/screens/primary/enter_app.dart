import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/screens/primary/widgets/header_log.dart';

class EnterApp extends StatelessWidget {
  const EnterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorBackground,
      body: Column(
        children: [
          // Header Fixo
          const CustomHeader(),
          // Ocupa o espaço restante da tela
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(flex: 2), // Empurra para baixo (peso 2)

                  Text(
                    "ENTRE E ESCOLHA UMA INSTITUIÇÃO",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const Spacer(
                    flex: 1,
                  ), // Espaço flexível entre título e botões
                  // Botão Azul
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/select-instituition'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.colorButtons,
                        foregroundColor: AppTheme.colorWhiteText,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "VER INSTITUIÇÕES",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  const Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "ou",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Botão Outline
                  SizedBox(
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () => Navigator.pushNamed(context, '/login'),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: AppTheme.colorButtons,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        "ENTRAR GERENCIAMENTO",
                        style: TextStyle(
                          color: AppTheme.colorButtons,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),

                  const Spacer(flex: 3), // Empurra muito para cima (peso 3)

                  const Divider(color: AppTheme.colorGrayText),

                  const SizedBox(
                    height: 20,
                  ), // Espaço pequeno fixo antes do link
                ],
              ),
            ),
          ),

          // Rodapé protegido contra a barra de navegação
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: AppTheme.colorGrayText,
                    fontSize: 14,
                  ),
                  children: [
                    const TextSpan(text: "Cadastre sua instituição "),
                    TextSpan(
                      text: "aqui",
                      style: const TextStyle(
                        color: AppTheme.colorLogo,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () =>
                            Navigator.pushNamed(context, '/register'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
