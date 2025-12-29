import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:vektor_if/models/sectors_model.dart';
import 'package:vektor_if/screens/map/widget/map_widgets.dart'; 

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
  
  double? _imageAspectRatio;
  bool _isLoadingImage = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addListener(() {
        widget.transformationController.value = _animation!.value;
      });

    if (widget.mapUrl != null) {
      _loadImageDimensions(widget.mapUrl!);
    }
  }

  @override
  void didUpdateWidget(covariant InteractiveArea oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.mapUrl != oldWidget.mapUrl && widget.mapUrl != null) {
      _loadImageDimensions(widget.mapUrl!);
    }
  }

  // Carrega tamanho real da imagem para calcular AspectRatio
  Future<void> _loadImageDimensions(String url) async {
    setState(() => _isLoadingImage = true);
    try {
      final ImageStream stream = NetworkImage(url).resolve(ImageConfiguration.empty);
      final Completer<ui.Image> completer = Completer();
      
      late ImageStreamListener listener;
      listener = ImageStreamListener((ImageInfo frame, bool synchronousCall) {
        stream.removeListener(listener);
        completer.complete(frame.image);
      });
      
      stream.addListener(listener);
      final ui.Image image = await completer.future;
      
      if (mounted) {
        setState(() {
          _imageAspectRatio = image.width / image.height;
          _isLoadingImage = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoadingImage = false);
    }
  }

  // Lógica de Zoom no Duplo Clique
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
    //Placeholder (Sem Mapa)
    if (widget.mapUrl == null) {
      return const MapPlaceholder(message: "Nenhum mapa enviado");
    }

    //Loading Inicial
    if (_isLoadingImage || _imageAspectRatio == null) {
      return const Center(child: CircularProgressIndicator());
    }

    // 3. Área Interativa
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
            InteractiveViewer(
              transformationController: widget.transformationController,
              minScale: 1.0,
              maxScale: 5.0,
              panEnabled: true,
              boundaryMargin: EdgeInsets.zero,
              constrained: true,
              child: Center(
                // Mantém a proporção da imagem 
                child: AspectRatio(
                  aspectRatio: _imageAspectRatio!,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return GestureDetector(
                        onDoubleTapDown: (details) => _doubleTapDetails = details,
                        onDoubleTap: _handleDoubleTap,
                        onTapUp: (details) {
                          // Normaliza o clique (converte pixel para 0.0 - 1.0)
                          final normalizedX = details.localPosition.dx / constraints.maxWidth;
                          final normalizedY = details.localPosition.dy / constraints.maxHeight;
                          
                          final normalizedDetails = TapUpDetails(
                            kind: details.kind,
                            globalPosition: details.globalPosition,
                            localPosition: Offset(normalizedX, normalizedY),
                          );
                          
                          widget.onMapTap(normalizedDetails);
                        },
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              widget.mapUrl!,
                              fit: BoxFit.cover,
                              loadingBuilder: (ctx, child, progress) {
                                if (progress == null) return child;
                                return const Center(child: CircularProgressIndicator());
                              },
                              errorBuilder: (ctx, _, __) => const Center(child: Icon(Icons.broken_image)),
                            ),

                            ...widget.mappedSectors.map((sector) {
                              return ResponsivePin(
                                sector: sector,
                                constraints: constraints,
                                isDeleteMode: widget.isDeleteMode,
                                onTap: () => widget.onSectorTap(sector),
                              );
                            }),
                          ],
                        ),
                      );
                    }
                  ),
                ),
              ),
            ),
            
            // Botão de Remover
            if (widget.mapUrl != null && widget.onRemoveMap != null)
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

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}