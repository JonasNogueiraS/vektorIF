import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';

// Classe Modelo
class MenuOption {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;

  MenuOption({
    required this.label,
    required this.icon,
    required this.onTap,
    this.color,
  });
}

// Widget do Botão
class SettingsMenuButton extends StatelessWidget {
  final Color iconColor;
  final List<MenuOption> options;

  const SettingsMenuButton({
    super.key,
    this.iconColor = AppTheme.colorBlackText,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuOption>(
      icon: Icon(Icons.more_vert, color: iconColor, size: 28), 
      
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      tooltip: "Mais opções",
      onSelected: (MenuOption option) {
        option.onTap();
      },
      itemBuilder: (BuildContext context) {
        return options.map((option) {
          return PopupMenuItem<MenuOption>(
            value: option,
            child: Row(
              children: [
                Icon(
                  option.icon, 
                  size: 20, 
                  color: option.color ?? Colors.grey
                ),
                const SizedBox(width: 12),
                Text(
                  option.label,
                  style: TextStyle(
                    color: option.color ?? AppTheme.colorBlackText,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ],
            ),
          );
        }).toList();
      },
    );
  }
}