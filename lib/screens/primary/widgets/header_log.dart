import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/core/widgets/custom_back_button.dart';

class CustomHeader extends StatelessWidget {
  final bool showBackButton;

  const CustomHeader({super.key, this.showBackButton = false});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.center,
      children: [
        PhysicalShape(
          clipper: HeaderClipper(),
          color: AppTheme.primaryBlue,
          elevation: 2.0,
          shadowColor: Colors.black,
          child: SizedBox(height: size.height * 0.40, width: double.infinity),
        ),

        if (showBackButton)
          Positioned(
            top: 50,
            left: 24,
            child: CustomBackButton(),
          ),
        Positioned(
          top: size.height * 0.15,
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
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF001822),
                      ),
                      children: [
                        const TextSpan(text: 'VEKTOR'),
                        TextSpan(
                          text: 'IF',
                          style: TextStyle(color: const Color(0xFFF2F2F2)),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),
                  Text(
                    "Seu guia institucional",
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
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
