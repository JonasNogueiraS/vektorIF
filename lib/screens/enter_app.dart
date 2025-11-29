import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';

class EnterApp extends StatelessWidget {
  const EnterApp({super.key});

  @override
  Widget build(BuildContext context) {
    final tamanho = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppTheme.colorBackground,
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              // 1. O Fundo Azul com Sombra
              PhysicalShape(
                clipper: HeaderClipper(),
                color: AppTheme.primaryBlue,
                elevation: 2.0,
                shadowColor: Colors.black,
                child: SizedBox(
                  height: tamanho.height * 0.40,
                  width: double.infinity,
                ),
              ),

              Positioned(
                top: tamanho.height * 0.15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Imagem do Logo
                    Image.asset(
                      "assets/images/img_Logo.png",
                      width: 61,
                      height: 79,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 16),

                    // Coluna de Textos
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.displaySmall
                                ?.copyWith(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF001822),
                                ),
                            children: [
                              const TextSpan(text: 'VEKTOR'),
                              TextSpan(
                                text: 'IF',
                                style: TextStyle(
                                  color: const Color(0xFFF2F2F2),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 8),
                        Text(
                          "Seu guia institucional",
                          style: Theme.of(context).textTheme.displaySmall
                              ?.copyWith(
                                fontSize: 16,
                                color: const Color(0xFF001822),
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

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
                      print("Entrar");
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
                            )
                          )
                        ]
                    ),
                  ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 50,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
