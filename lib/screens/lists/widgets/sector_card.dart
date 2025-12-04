import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';

class SectorCard extends StatelessWidget {
  final String name;
  final String phone;
  final String description;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const SectorCard({
    super.key,
    required this.name,
    required this.phone,
    required this.description,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nome do Setor
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xff49454F),
                  ),
                ),
                const SizedBox(height: 4),
                
                // Telefone
                Text(
                  phone,
                  style: TextStyle(
                    fontSize: 12, 
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w500
                  ),
                ),
                const SizedBox(height: 8),
                
                // Descrição / Atribuições
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13, 
                    color: AppTheme.colorLogo, // Azul para destaque suave
                    height: 1.3
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Ações (Coluna lateral)
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.edit_outlined, size: 20, color: Colors.blueGrey),
                visualDensity: VisualDensity.compact,
                onPressed: onEdit,
              ),
              const SizedBox(height: 8),
              IconButton(
                icon: Icon(Icons.delete_outline, size: 20, color: Colors.red.shade300),
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