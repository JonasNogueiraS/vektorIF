import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/size_extensions.dart';

class ImageUploadArea extends StatelessWidget {
  const ImageUploadArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: context.percentHeight(0.18),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_a_photo_outlined, size: 40, color: Colors.grey[600]),
            const SizedBox(height: 8),
            Text(
              "Toque para adicionar uma foto",
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
