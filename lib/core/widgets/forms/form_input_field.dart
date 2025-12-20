import 'package:flutter/material.dart';

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
