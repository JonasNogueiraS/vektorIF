import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/core/themes/size_extensions.dart';
import 'package:vektor_if/core/widgets/custom_back_button.dart';
import 'package:vektor_if/screens/map/models/map_marker.dart';


// --- 1. HEADER ---
class MapEditorHeader extends StatelessWidget {
  final VoidCallback onReset;

  const MapEditorHeader({super.key, required this.onReset});

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
          IconButton(
            onPressed: onReset,
            icon: const Icon(Icons.delete_forever_outlined, color: Colors.redAccent),
            tooltip: "Limpar Mapa",
          ),
        ],
      ),
    );
  }
}

// --- 2. BARRA DE FERRAMENTAS ---
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

// Sub-componente privado apenas para os botões da barra
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
                style: TextStyle(
                  color: activeColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}

// --- 3. PINO DO MAPA (VISUAL) ---
// Nota: Este widget deve ser usado dentro de um Stack
class MapMarkerPin extends StatelessWidget {
  final MapMarker marker;
  final bool isDeleteMode;
  final VoidCallback onTap;

  const MapMarkerPin({
    super.key,
    required this.marker,
    required this.isDeleteMode,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      // Ajuste de coordenadas para centralizar a ponta do pino
      left: marker.position.dx - 20,
      top: marker.position.dy - 40,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: [
                   BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 2)
                ]
              ),
              child: Text(
                marker.sectorName,
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
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