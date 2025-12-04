import 'package:flutter/material.dart';
import 'package:vektor_if/screens/map/models/map_marker.dart';
import 'package:vektor_if/screens/map/widget/map_editor_components.dart';

class InteractiveArea extends StatelessWidget {
  final TransformationController transformationController;
  final List<MapMarker> markers;
  final bool isDeleteMode;
  final Function(TapUpDetails) onMapTap;
  final Function(MapMarker) onMarkerTap;

  const InteractiveArea({
    super.key,
    required this.transformationController,
    required this.markers,
    required this.isDeleteMode,
    required this.onMapTap,
    required this.onMarkerTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: InteractiveViewer(
            transformationController: transformationController,
            minScale: 0.5,
            maxScale: 4.0,
            child: GestureDetector(
              onTapUp: onMapTap,
              child: Stack(
                alignment: Alignment.center, 
                children: [
                  // Imagem Base
                  Image.asset(
                    'assets/images/map_image.png',
                    fit: BoxFit.contain,
                  ),

                  // Lista de Pinos
                  ...markers.map(
                    (marker) => MapMarkerPin(
                      marker: marker,
                      isDeleteMode: isDeleteMode,
                      onTap: () => onMarkerTap(marker),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}