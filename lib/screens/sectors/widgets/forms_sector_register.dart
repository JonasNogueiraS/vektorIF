import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/size_extensions.dart';


class FormLabel extends StatelessWidget {
  final String text;

  const FormLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}

class FormInputField extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final int maxLines;
  final bool enabled;
  final TextInputType keyboardType;

  const FormInputField({
    super.key,
    required this.controller,
    this.hint,
    this.maxLines = 1,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: enabled ? const Color(0xffF5F5F5) : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        enabled: enabled,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}

class ImageUploadArea extends StatelessWidget {
  const ImageUploadArea({super.key});

  @override
  Widget build(BuildContext context) {
    // Usando sua extension de tamanho
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