import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/providers/auth_provider.dart';

class UserStatusBadge extends StatelessWidget {
  const UserStatusBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;
    final isManager = user != null;

    return Container(
      margin: const EdgeInsets.only(top: 10), // Margem do topo
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // Ocupa apenas o tamanho do texto
        children: [
          // Ícone Indicativo
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: isManager 
                  ? AppTheme.colorLogo.withValues(alpha: 0.1) // Roxo se Gerente
                  : Colors.blue.withValues(alpha: 0.1),       // Azul se Visitante
              shape: BoxShape.circle,
            ),
            child: Icon(
              isManager ? Icons.admin_panel_settings : Icons.person_outline,
              size: 16,
              color: isManager ? AppTheme.colorLogo : Colors.blue,
            ),
          ),
          
          const SizedBox(width: 12),

          // Texto
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Você está como:",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                isManager ? "GERENTE" : "VISITANTE",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isManager ? AppTheme.colorBlackText : Colors.blue.shade700,
                ),
              ),
            ],
          ),     
        ],
      ),
    );
  }
}