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
          CustomHeader(showBackButton: false),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 92),
                Text(
                  "ENTRE E ESCOLHA UMA INSTITUIÇÃO",
                  style: Theme.of(
                    context,
                  ).textTheme.displayLarge?.copyWith(fontSize: 24),
                ),
                const SizedBox(height: 32),

                SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/select-instituition');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.colorButtons,
                      foregroundColor: AppTheme.colorWhiteText,
                      elevation: 2.5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      "ENTRAR",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppTheme.colorWhiteText,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 80),

                const Divider(color: AppTheme.colorGrayText),

                const SizedBox(height: 80),

                Center(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: AppTheme.colorGrayText,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      children: [
                        const TextSpan(text: "Cadastre sua instituição "),
                        TextSpan(
                          text: "aqui",
                          style: TextStyle(
                            color: AppTheme.colorLogo,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
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
