import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/core/widgets/background_image.dart';
import 'package:vektor_if/core/widgets/confirmation_dialog.dart';
import 'package:vektor_if/core/widgets/success_feedback_dialog.dart';
import 'package:vektor_if/screens/map/controller/map_editor_controller.dart';
import 'package:vektor_if/screens/map/modal/sector_modal.dart';
import 'package:vektor_if/screens/map/widget/interactve_area.dart';
import 'package:vektor_if/screens/map/widget/map_editor_components.dart';
import 'package:vektor_if/screens/map/widget/map_editor_footer.dart';

class MapEditor extends StatefulWidget {
  final String? imagePath;
  const MapEditor({super.key, this.imagePath});

  @override
  State<MapEditor> createState() => _MapEditorState();
}

class _MapEditorState extends State<MapEditor> {
  final _controller = MapEditorController();
  final _transformController = TransformationController();
  int _selectedToolIndex = 0; // 0: Marcar, 1: Apagar

  @override
  void initState() {
    super.initState();
    // Se veio imagem da tela anterior, usa ela. Senão carrega do banco.
    if (widget.imagePath != null) {
      _controller.backendMapUrl = widget.imagePath;
      _controller.loadInitialData(); // Carrega só os setores
    } else {
      _controller.loadInitialData(); // Carrega tudo
    }
  }
  
  void _showClearConfirmation() {
    if (_controller.mappedSectors.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Nada para limpar.")));
      return;
    }
    showDialog(
      context: context,
      builder: (ctx) => ConfirmationDialog(
        title: "Limpar Marcações?",
        subtitle: "Isso removerá todos os pinos da tela, mantendo o mapa.",
        confirmLabel: "Limpar",
        onConfirm: _controller.clearAllMarkers,
      ),
    );
  }

  void _showDeleteMapConfirmation() {
    showDialog(
      context: context,
      builder: (ctx) => ConfirmationDialog(
        title: "Excluir Mapa?",
        subtitle: "A imagem e as marcações serão apagadas permanentemente.",
        confirmLabel: "Excluir",
        isDestructive: true,
        onConfirm: _controller.removeMap,
      ),
    );
  }

  void _save() {
    _controller.saveMap(
      onSuccess: () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => const SuccessFeedbackDialog(
            title: "Mapeamento Salvo!",
            subtitle: "As posições foram atualizadas com sucesso.",
          ),
        );
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) Navigator.pop(context); // Fecha dialog
          if (mounted) Navigator.pop(context); // Sai da tela
        });
      },
      onError: (msg) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Erro: $msg"), backgroundColor: Colors.red));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorBackground,
      body: Stack(
        children: [
          const BackgroundImage(),
          SafeArea(
            child: ListenableBuilder(
              listenable: _controller,
              builder: (context, _) {
                if (_controller.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Column(
                  children: [
                    // Header
                    MapEditorHeader(
                      onClearAllPins: _showClearConfirmation,
                      onDeleteMap: _showDeleteMapConfirmation,
                    ),

                    const SizedBox(height: 10),

                    // Toolbar
                    Center(
                      child: MapToolsBar(
                        selectedIndex: _selectedToolIndex,
                        onToolSelected: (i) => setState(() => _selectedToolIndex = i),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Área Interativa
                    Expanded(
                      child: InteractiveArea(
                        transformationController: _transformController,
                        mappedSectors: _controller.mappedSectors,
                        isDeleteMode: _selectedToolIndex == 1,
                        mapUrl: _controller.backendMapUrl,
                        onRemoveMap: _showDeleteMapConfirmation,
                        
                        // Lógica de adicionar
                        onMapTap: (details) {
                          if (_selectedToolIndex == 1) return;
                          showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
                            builder: (_) => SectorModal(
                              onSectorSelected: (s) => _controller.addSector(details.localPosition, s),
                            ),
                          );
                        },
                        
                        // Lógica de remover pino
                        onSectorTap: (sector) {
                          if (_selectedToolIndex == 1) _controller.removeSector(sector);
                        },
                      ),
                    ),

                    // Footer Refatorado
                    MapEditorFooter(
                      isEnabled: _controller.mappedSectors.isNotEmpty,
                      onSave: _save,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}