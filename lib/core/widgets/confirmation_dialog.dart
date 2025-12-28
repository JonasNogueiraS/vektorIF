import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final String confirmLabel;
  final VoidCallback onConfirm;
  final bool isDestructive; // Se true, o botão fica vermelho (Ex: Excluir)

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onConfirm,
    this.confirmLabel = "Confirmar",
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Ícone de Alerta
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDestructive 
                    ? Colors.red.withValues(alpha: 0.1) 
                    : AppTheme.primaryColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isDestructive ? Icons.warning_amber_rounded : Icons.info_outline,
                color: isDestructive ? Colors.red : AppTheme.primaryColor,
                size: 32,
              ),
            ),
            const SizedBox(height: 16),
            
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff49454F)),
            ),
            const SizedBox(height: 8),
            
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 24),

            // Botões
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancelar", style: TextStyle(color: Colors.grey)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDestructive ? Colors.red : AppTheme.primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.pop(context); // Fecha o dialog
                      onConfirm(); // Executa a ação
                    },
                    child: Text(confirmLabel),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}