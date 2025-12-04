import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';

class ColaboratorsCards extends StatelessWidget {
  final String name;
  final String email;
  final String sector;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ColaboratorsCards({
    super.key,
    required this.name,
    required this.email,
    required this.sector,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.grey.shade300,
            child: const Icon(Icons.person, size: 30, color: Colors.white),
          ),
          const SizedBox(width: 12),
          
          // Infos
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xff49454F),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  email,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppTheme.colorLogo.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    sector,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.colorLogo,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Ações
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.edit_outlined, color: Colors.blueGrey),
                visualDensity: VisualDensity.compact,
                onPressed: onEdit,
              ),
              IconButton(
                icon: Icon(Icons.delete_outline, color: Colors.red.shade300),
                visualDensity: VisualDensity.compact,
                onPressed: onDelete,
              ),
            ],
          )
        ],
      ),
    );
  }
}