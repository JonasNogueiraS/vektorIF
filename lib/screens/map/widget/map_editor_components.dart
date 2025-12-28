import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/core/themes/size_extensions.dart';
import 'package:vektor_if/core/widgets/custom_back_button.dart';
import 'package:vektor_if/models/sectors_model.dart';
import 'package:vektor_if/core/widgets/menu_buttons.dart'; 

//  HEADER 
class MapEditorHeader extends StatelessWidget {
  final VoidCallback onClearAllPins; // Callback para limpar apenas os pinos
  final VoidCallback onDeleteMap;    // Callback para apagar o mapa inteiro

  const MapEditorHeader({
    super.key, 
    required this.onClearAllPins,
    required this.onDeleteMap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.percentWidth(0.05),
        vertical: context.percentHeight(0.02),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CustomBackButtom(),
          
          Text(
            "Mapear Setores",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff49454F),
                ),
          ),

          SettingsMenuButton(
            options: [
              MenuOption(
                label: 'Limpar Marcações',
                icon: Icons.cleaning_services_outlined,
                color: AppTheme.primaryColor,
                onTap: onClearAllPins,
              ),
              MenuOption(
                label: 'Excluir Mapa',
                icon: Icons.delete_forever_outlined,
                color: Colors.redAccent,
                onTap: onDeleteMap,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
//  BARRA DE FERRAMENTAS 
class MapToolsBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onToolSelected;

  const MapToolsBar({
    super.key,
    required this.selectedIndex,
    required this.onToolSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
        mainAxisSize: MainAxisSize.min,
        children: [
          _ToolButton(
            isActive: selectedIndex == 0,
            icon: Icons.add_location_alt_outlined,
            label: "Marcar",
            activeColor: AppTheme.primaryColor,
            onTap: () => onToolSelected(0),
          ),
          const SizedBox(width: 10),
          Container(width: 1, height: 20, color: Colors.grey.shade300),
          const SizedBox(width: 10),
          _ToolButton(
            isActive: selectedIndex == 1,
            icon: Icons.delete_outline,
            label: "Apagar",
            activeColor: Colors.redAccent,
            onTap: () => onToolSelected(1),
          ),
        ],
      ),
    );
  }
}

class _ToolButton extends StatelessWidget {
  final bool isActive;
  final IconData icon;
  final String label;
  final Color activeColor;
  final VoidCallback onTap;

  const _ToolButton({
    required this.isActive,
    required this.icon,
    required this.label,
    required this.activeColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? activeColor.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, color: isActive ? activeColor : Colors.grey, size: 24),
            if (isActive) ...[
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(color: activeColor, fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
// PINO DO MAPA
class MapMarkerPin extends StatelessWidget {
  final SectorModel sector;
  final bool isDeleteMode;
  final VoidCallback onTap;

  const MapMarkerPin({
    super.key,
    required this.sector,
    required this.isDeleteMode,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (sector.mapX == null || sector.mapY == null) return const SizedBox();

    return Positioned(
      left: sector.mapX! - 30, 
      top: sector.mapY! - 60,  
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: isDeleteMode ? Colors.red.shade200 : Colors.grey.shade300),
                boxShadow: [
                   BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 2)
                ]
              ),
              child: Text(
                sector.name,
                style: TextStyle(
                  fontSize: 10, 
                  fontWeight: FontWeight.bold,
                  color: isDeleteMode ? Colors.red : Colors.black87
                ),
              ),
            ),
            Icon(
              Icons.location_on,
              size: 40,
              color: isDeleteMode ? Colors.red : AppTheme.primaryBlue,
            ),
          ],
        ),
      ),
    );
  }
}