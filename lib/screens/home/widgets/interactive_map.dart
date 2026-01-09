import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'package:vektor_if/core/themes/app_theme.dart'; 
import 'package:vektor_if/models/sectors_model.dart';
import 'package:vektor_if/providers/collaborator_provider.dart'; 
import 'package:vektor_if/screens/map/widget/interactve_area.dart';

class InteractiveMap extends StatefulWidget {
  final double height;
  final String? mapUrl;
  final List<SectorModel> sectors;

  const InteractiveMap({
    super.key,
    required this.height,
    this.mapUrl,
    this.sectors = const [],
  });

  @override
  State<InteractiveMap> createState() => _InteractiveMapState();
}

class _InteractiveMapState extends State<InteractiveMap> {
  final TransformationController _transformController =
      TransformationController();

  void _showSectorDetails(SectorModel sector) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Permite que o modal cresça se tiver muita gente
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        //Busca e Filtra os Colaboradores do Setor
        final allCollaborators = context.read<CollaboratorProvider>().collaborators;
        final sectorCollaborators = allCollaborators
            .where((c) => c.sectorId == sector.id)
            .toList();

        sectorCollaborators.sort((a, b) {
          if (a.isBoss && !b.isBoss) return -1;
          if (!a.isBoss && b.isBoss) return 1;
          return a.name.compareTo(b.name);
        });

        return DraggableScrollableSheet(
          initialChildSize: 0.5, // Começa na metade da tela
          minChildSize: 0.3,
          maxChildSize: 0.85,
          expand: false,
          builder: (_, scrollController) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: ListView(
                controller: scrollController,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Text(
                    sector.name,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  if (sector.description != null &&
                      sector.description!.isNotEmpty)
                    Text(sector.description!,
                        style: const TextStyle(color: Colors.grey)),
                  
                  const SizedBox(height: 20),
                  
                  // Informações de Contato do Setor
                  _InfoRow(icon: Icons.category, text: sector.category),
                  if (sector.email != null)
                    _InfoRow(icon: Icons.email, text: sector.email!),
                  if (sector.phone != null)
                    _InfoRow(icon: Icons.phone, text: sector.phone!),

                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 10),

                  // Lista de colaboradores
                  Text(
                    "Colaboradores (${sectorCollaborators.length})",
                    style: const TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.bold,
                      color: AppTheme.colorBlackText
                    ),
                  ),
                  const SizedBox(height: 10),

                  if (sectorCollaborators.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        "Nenhum colaborador vinculado a este setor.",
                        style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
                      ),
                    )
                  else
                    ...sectorCollaborators.map((colab) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          backgroundColor: colab.isBoss 
                              ? AppTheme.colorLogo.withValues(alpha: 0.2) 
                              : AppTheme.colorButtons.withValues(alpha: 0.1),
                          child: Icon(
                            colab.isBoss ? Icons.star : Icons.person,
                            color: colab.isBoss ? AppTheme.colorLogo : AppTheme.primaryBlue,
                            size: 20,
                          ),
                        ),
                        title: Row(
                          children: [
                            Flexible(
                                child: Text(colab.name,
                                    style: const TextStyle(fontWeight: FontWeight.w600))),
                            if (colab.isBoss) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryColor,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text("CHEFE",
                                    style: TextStyle(fontSize: 9, color: Colors.white, fontWeight: FontWeight.bold)),
                              )
                            ]
                          ],
                        ),
                        subtitle: colab.email.isNotEmpty 
                            ? Text(colab.email, style: TextStyle(fontSize: 12, color: Colors.grey[600]))
                            : null,
                      );
                    }),
                    
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
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
          Icon(icon, size: 20, color: AppTheme.primaryBlue), 
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}