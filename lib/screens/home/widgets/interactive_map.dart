import 'package:flutter/material.dart';
import 'package:vektor_if/models/sectors_model.dart';
import 'package:vektor_if/screens/map/widget/interactve_area.dart';

class InteractiveMap extends StatefulWidget {
  final double height;
  // NOVOS PARÂMETROS
  final String? mapUrl;
  final List<SectorModel> sectors;

  const InteractiveMap({
    super.key,
    required this.height,
    // Garante que são obrigatórios ou opcionais conforme lógica
    this.mapUrl,
    this.sectors = const [],
  });

  @override
  State<InteractiveMap> createState() => _InteractiveMapState();
}

class _InteractiveMapState extends State<InteractiveMap> {
  final TransformationController _transformController = TransformationController();

  void _showSectorDetails(SectorModel sector) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                sector.name,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              if (sector.description != null && sector.description!.isNotEmpty)
                Text(sector.description!, style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 20),
              _InfoRow(icon: Icons.category, text: sector.category),
              if (sector.email != null) 
                _InfoRow(icon: Icons.email, text: sector.email!),
              if (sector.phone != null) 
                _InfoRow(icon: Icons.phone, text: sector.phone!),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: InteractiveArea(
        transformationController: _transformController,
        // PASSA OS DADOS RECEBIDOS DO PAI
        mappedSectors: widget.sectors, 
        mapUrl: widget.mapUrl,
        isDeleteMode: false,
        onMapTap: (_) {}, 
        onSectorTap: _showSectorDetails,
        onRemoveMap: null,
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.blueAccent),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}