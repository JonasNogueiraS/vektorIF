import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';

class ColaboratorsCards extends StatelessWidget {
  final String name;
  final String email;
  final String sector;
  final bool isBoss;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ColaboratorsCards({
    super.key,
    required this.name,
    required this.email,
    required this.sector,
    this.isBoss = false,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.colorWhiteText, 
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        
        //AVATAR
        leading: CircleAvatar(
          backgroundColor: AppTheme.colorLogo.withValues(alpha: 0.1),
          radius: 24,
          child: const Icon(
            Icons.person, 
            color: AppTheme.colorLogo,
            size: 24,
          ),
        ),

        //TÍTULO 
        title: Row(
          children: [
            Flexible(
              child: Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppTheme.colorBlackText,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            
            // Badge de Chefe
            if (isBoss) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppTheme.colorLogo.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  "CHEFE",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.colorLogo,
                  ),
                ),
              )
            ]
          ],
        ),

        //SUBTÍTULO
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sector,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            Text(
              email,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),

        // 4. AÇÕES
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [   
            IconButton(
              icon: const Icon(Icons.edit, size: 20, color: Colors.blueGrey),
              onPressed: onEdit,
              tooltip: "Editar",
            ),        
            IconButton(
              icon: const Icon(Icons.delete_outline, size: 20, color: Colors.redAccent),
              onPressed: onDelete,
              tooltip: "Remover",
            ),
          ],
        ),
      ),
    );
  }
}