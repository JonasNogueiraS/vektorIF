import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';

class SettingsMenuButton extends StatelessWidget {
  final Color iconColor;

  const SettingsMenuButton({
    super.key,
    this.iconColor = AppTheme.colorBlackText, 
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.settings_outlined, color: iconColor),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      onSelected: (String value) {
        if (value == 'management') {
          Navigator.pushNamed(context, '/management');
        } else if (value == 'institutions') {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/select-instituition',
            (route) => false,
          );
        } else if (value == 'logout') {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/',
            (route) => false,
          );
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'management',
          child: Row(
            children: [
              Icon(Icons.admin_panel_settings_outlined, size: 20, color: Colors.grey),
              SizedBox(width: 12),
              Text('Gerenciamento'),
            ],
          ),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem<String>(
          value: 'institutions',
          child: Row(
            children: [
              Icon(Icons.swap_horiz, size: 20, color: Colors.grey),
              SizedBox(width: 12),
              Text('Trocar Instituição'),
            ],
          ),
        ),
        
        const PopupMenuDivider(),
        const PopupMenuItem<String>(
          value: 'logout',
          child: Row(
            children: [
              Icon(Icons.logout, size: 20, color: Colors.redAccent),
              SizedBox(width: 12),
              Text(
                'Sair do App',
                style: TextStyle(color: Colors.redAccent),
              ),
            ],
          ),
        ),
      ],
    );
  }
}