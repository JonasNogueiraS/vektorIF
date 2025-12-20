import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';

class ButtonGeneric extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final bool isLoading; // mostra loading se precisar

  const ButtonGeneric({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor = AppTheme.colorButtons, 
    this.textColor = AppTheme.colorWhiteText, 
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Ocupa toda a largura disponível 
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed, // Desabilita se estiver carregando
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0, // remove a sombra para ficar mais flat
        ),
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: textColor,
                ),
              )
            : Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
      ),
    );
  }
}