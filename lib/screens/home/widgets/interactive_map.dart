import 'package:flutter/material.dart';

class InteractiveMap extends StatelessWidget {
  final double height;

  const InteractiveMap({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: InteractiveViewer(
            minScale: 0.1,
            maxScale: 5.0,
            // boundaryMargin: const EdgeInsets.all(double.infinity),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  "assets/images/map_image.png",
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}