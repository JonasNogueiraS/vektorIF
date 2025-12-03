import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  final double height;

  const BackgroundImage({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 0,
            right: 0,
            width: screenWidth * 0.4,
            height: height * 1.5,
            child: Image.asset(
              "assets/images/bg_curve_direita.png",
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
