import 'package:flutter/material.dart';
import 'package:vektor_if/models/sectors_model.dart';
import 'package:vektor_if/screens/map/widget/map_editor_components.dart';

/// Componente que exibe mensagem quando não há mapa
class MapPlaceholder extends StatelessWidget {
  final String message;

  const MapPlaceholder({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.image_not_supported_outlined, size: 50, color: Colors.grey),
            const SizedBox(height: 10),
            Text(message, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

/// Componente inteligente que decide se desenha o pino usando Pixel ou Porcentagem
class ResponsivePin extends StatelessWidget {
  final SectorModel sector;
  final BoxConstraints constraints;
  final bool isDeleteMode;
  final VoidCallback onTap;

  const ResponsivePin({
    super.key,
    required this.sector,
    required this.constraints,
    required this.isDeleteMode,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double x = sector.mapX ?? 0;
    double y = sector.mapY ?? 0;

    // LÓGICA DE DETECÇÃO (Pixel vs Porcentagem)
    // Se for <= 1.0, assumimos que é porcentagem (ex: 0.5 = 50%)
    bool isPercentage = (x <= 1.0 && y <= 1.0 && (x > 0 || y > 0));

    if (isPercentage) {
      // Converte % para o tamanho atual da tela (Pixel Real)
      x = x * constraints.maxWidth;
      y = y * constraints.maxHeight;
    } 
    
    // Cria uma cópia temporária apenas para exibição visual
    final adjustedSector = sector.copyWith(mapX: x, mapY: y);

    return MapMarkerPin(
      sector: adjustedSector,
      isDeleteMode: isDeleteMode,
      onTap: onTap,
    );
  }
}