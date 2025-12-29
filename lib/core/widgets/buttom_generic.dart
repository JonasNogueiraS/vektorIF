import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';

class ButtomGeneric extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final bool isLoading;
  final bool isOutlined; 

  const ButtomGeneric({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor = AppTheme.colorButtons, 
    this.textColor = AppTheme.colorWhiteText, 
    this.isLoading = false,
    this.isOutlined = false, // Padrão
  });

  @override
  Widget build(BuildContext context) {
    
    final effectiveTextColor = isOutlined ? backgroundColor : textColor;

    return SizedBox(
      width: double.infinity,
      height: 50, 
      child: isOutlined
          // -Outlined
          ? OutlinedButton(
              onPressed: isLoading ? null : onPressed,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: backgroundColor, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),  
                ),
              ),
              child: _buildContent(effectiveTextColor),
            )
          // --- ESTILO PREENCHIDO (Elevated) ---
          : ElevatedButton(
              onPressed: isLoading ? null : onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), 
                ),
              ),
              child: _buildContent(effectiveTextColor),
            ),
    );
  }

  
  Widget _buildContent(Color color) {
    if (isLoading) {
      return SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: color,
        ),
      );
    }
    return Text(
      label.toUpperCase(), // O seu exemplo usava caixa alta
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: 14,
        letterSpacing: 0.5, // Espaçamento igual ao do seu exemplo
      ),
    );
  }
}