import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';

//LABEL PADRÃO
class FormLabel extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry? padding;

  const FormLabel(
    this.text, {
    super.key,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Padding
      padding: padding ?? const EdgeInsets.only(bottom: 8.0, left: 4, top: 10),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: Colors.black87,
        ),
      ),
    );
  }
}

//INPUT FIELD GENÉRICO 
class GenericInputField extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final int maxLines;
  final bool enabled;
  final TextInputType keyboardType;
  
  // Parâmetros para Senha
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? onToggleVisibility;

  // Parâmetros de Estilo
  final bool outlined; 

  const GenericInputField({
    super.key,
    required this.controller,
    this.hint,
    this.maxLines = 1,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.obscureText = false,
    this.onToggleVisibility,
    this.outlined = false, // Se true, fica branco com borda. Se false, fundo cinza.
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // Lógica de estilo baseada na flag 'outlined'
        color: outlined ? Colors.white : (enabled ? const Color(0xffF5F5F5) : Colors.grey[100]),
        borderRadius: BorderRadius.circular(12),
        border: outlined ? Border.all(color: Colors.grey.shade300) : null,
      ),
      child: TextField(
        controller: controller,
        enabled: enabled,
        maxLines: maxLines,
        keyboardType: keyboardType,
        obscureText: isPassword ? obscureText : false,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          // Ícone de olho apenas se for senha
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: onToggleVisibility,
                )
              : null,
        ),
      ),
    );
  }
}


// UPLOAD DE IMAGEM CIRCULAR
class CircularImagePicker extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const CircularImagePicker({
    super.key, 
    required this.label, 
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD), // Azul claro
              shape: BoxShape.circle, 
              border: Border.all(color: AppTheme.primaryBlue, width: 1),
            ),
            child: const Icon(Icons.camera_alt, color: Colors.black87, size: 30),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                height: 1.2
              ),
            ),
          ),
        ],
      ),
    );
  }
}