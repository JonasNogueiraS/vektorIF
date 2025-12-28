import 'package:flutter/material.dart';
import 'package:vektor_if/models/sectors_model.dart';
import 'package:vektor_if/screens/map/widget/map_editor_components.dart';

class InteractiveArea extends StatefulWidget {
  final TransformationController transformationController;
  final List<SectorModel> mappedSectors;
  final bool isDeleteMode;
  final Function(TapUpDetails) onMapTap;
  final Function(SectorModel) onSectorTap;
  final String? mapUrl;
  final VoidCallback? onRemoveMap;

  const InteractiveArea({
    super.key,
    required this.transformationController,
    required this.mappedSectors,
    required this.isDeleteMode,
    required this.onMapTap,
    required this.onSectorTap,
    this.mapUrl,
    this.onRemoveMap,
  });

  @override
  State<InteractiveArea> createState() => _InteractiveAreaState();
}

class _InteractiveAreaState extends State<InteractiveArea> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  Animation<Matrix4>? _animation;
  TapDownDetails? _doubleTapDetails;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addListener(() {
        widget.transformationController.value = _animation!.value;
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleDoubleTap() {
    final Matrix4 currentMatrix = widget.transformationController.value;
    final double currentScale = currentMatrix.getMaxScaleOnAxis();

    Matrix4 targetMatrix;

    if (currentScale > 1.2) {
      targetMatrix = Matrix4.identity();
    } else {
      final double targetScale = 3.0;
      final Offset tapPosition = _doubleTapDetails!.localPosition;

      final double x = -tapPosition.dx * (targetScale - 1);
      final double y = -tapPosition.dy * (targetScale - 1);
      
      targetMatrix = Matrix4.identity()
        ..setTranslationRaw(x, y, 0)
        ..scaleByDouble(targetScale, targetScale, 1.0, 1.0);
    }

    _animation = Matrix4Tween(
      begin: currentMatrix,
      end: targetMatrix,
    ).animate(CurveTween(curve: Curves.easeOut).animate(_animationController));

    _animationController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    // 1. Decidimos O QUE mostrar antes de montar a árvore
    Widget content;

    if (widget.mapUrl != null) {
      // --- CENÁRIO A: TEM MAPA (Interativo) ---
      content = InteractiveViewer(
        transformationController: widget.transformationController,
        minScale: 1.0,
        maxScale: 5.0,
        panEnabled: true,
        boundaryMargin: EdgeInsets.zero,
        constrained: true,
        child: GestureDetector(
          onDoubleTapDown: (details) => _doubleTapDetails = details,
          onDoubleTap: _handleDoubleTap,
          onTapUp: widget.onMapTap, // Só permite adicionar pino AQUI
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: [
              // Imagem do Mapa
              Image.network(
                widget.mapUrl!,
                fit: BoxFit.contain,
                loadingBuilder: (ctx, child, progress) {
                  if (progress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (ctx, _, __) => const Center(child: Icon(Icons.broken_image)),
              ),

              // Pinos (Só aparecem se tiver mapa)
              ...widget.mappedSectors.map(
                (sector) => MapMarkerPin(
                  sector: sector,
                  isDeleteMode: widget.isDeleteMode,
                  onTap: () => widget.onSectorTap(sector),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      // --- CENÁRIO B: NÃO TEM MAPA (Estático) ---
      // Aqui removemos InteractiveViewer e GestureDetector
      content = const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image_not_supported_outlined, size: 50, color: Colors.grey),
            SizedBox(height: 10),
            Text("Nenhum mapa enviado", style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    //Estrutura do Container
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      width: double.infinity,
      height: double.infinity,
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
        child: Stack(
          children: [
            // O conteúdo (Interativo ou Estático) ocupa tudo
            Positioned.fill(child: content),
            
            // Botão de Remover 
            if (widget.mapUrl != null)
              Positioned(
                top: 10,
                right: 10,
                child: Material(
                  color: Colors.white.withValues(alpha: 0.9),
                  shape: const CircleBorder(),
                  elevation: 4,
                  child: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    tooltip: "Remover mapa",
                    onPressed: widget.onRemoveMap,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}