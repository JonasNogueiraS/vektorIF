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
      color: AppTheme.colorWhiteText, 
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        
        // ÍCONE DO SETOR (Roxo padrão)
        leading: CircleAvatar(
          backgroundColor: AppTheme.colorLogo.withValues(alpha: 0.1),
          radius: 24,
          child: const Icon(
            Icons.domain, // Ícone de Prédio/Setor
            color: AppTheme.colorLogo,
            size: 24,
          ),
        ),

        // Nome do Setor
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppTheme.colorBlackText,
          ),
          overflow: TextOverflow.ellipsis,
        ),

        //SUBTÍTULO
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (phone.isNotEmpty && phone != "Sem telefone")
              Text(
                phone,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                  fontSize: 13,
                ),
              ),
            if (description.isNotEmpty)
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),

        //AÇÕES
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