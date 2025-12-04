import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/size_extensions.dart';

class BackgroundImage extends StatelessWidget {

  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {


    return SizedBox(
      height: context.height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 0,
            right: 0,
            width: context.width*0.45,
            height: context.height*0.5,
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
