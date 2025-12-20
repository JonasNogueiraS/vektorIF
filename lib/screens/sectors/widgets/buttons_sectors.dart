import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/core/themes/size_extensions.dart';
import 'package:vektor_if/core/widgets/button_generic.dart';

class ButtonsSectors extends StatelessWidget {
  final VoidCallback onSave;
  final VoidCallback? onCancel;

  const ButtonsSectors({
    super.key,
    required this.onSave,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Botão CANCELAR
        Expanded(
          child: ButtonGeneric(
            label: "Cancelar",
            onPressed: onCancel ?? () => Navigator.pop(context),
            backgroundColor: AppTheme.colorButtonCancel, 
            textColor: AppTheme.colorWhiteText,
          ),
        ),
        
        SizedBox(width: context.percentWidth(0.04)),
        
        // Botão SALVAR
        Expanded(
          child: ButtonGeneric(
            label: "Salvar",
            onPressed: onSave,
            backgroundColor: AppTheme.colorButtons, 
            textColor: AppTheme.colorWhiteText,
          ),
        ),
      ],
    );
  }
}