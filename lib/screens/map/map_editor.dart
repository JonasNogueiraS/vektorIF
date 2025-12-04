import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/core/widgets/background_image.dart'; 
import 'package:vektor_if/screens/map/modal/sector_modal.dart';
import 'package:vektor_if/screens/map/models/map_marker.dart';
import 'package:vektor_if/screens/map/widget/interactve_area.dart';
import 'package:vektor_if/screens/map/widget/map_editor_components.dart';
import 'package:vektor_if/screens/map/widget/map_footer_buttom.dart';

class MapEditor extends StatefulWidget {
  final String? imagePath;
  const MapEditor({super.key, this.imagePath});

  @override
  State<MapEditor> createState() => _MapEditorState();
}

class _MapEditorState extends State<MapEditor> {
  final List<MapMarker> _markers = [];
  final TransformationController _transformController = TransformationController();
  int _selectedToolIndex = 0; // 0: Marcar, 1: Apagar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorBackground,
      body: Stack(
        children: [
          const BackgroundImage(), 
          SafeArea(
            child: Column(
              children: [
                // Header
                MapEditorHeader(onReset: () => setState(() => _markers.clear())),
                
                // Área Central
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      InteractiveArea(
                        transformationController: _transformController,
                        markers: _markers,
                        isDeleteMode: _selectedToolIndex == 1,
                        onMapTap: _handleMapTap,
                        onMarkerTap: _removeMarker,
                      ),

                      // Toolbar 
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: MapToolsBar(
                            selectedIndex: _selectedToolIndex,
                            onToolSelected: (index) =>
                                setState(() => _selectedToolIndex = index),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                MapFooterButtom(isEnabled: _markers.isNotEmpty, onSave: _saveMap),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Métodos de Lógica ---

  void _handleMapTap(TapUpDetails details) {
    if (_selectedToolIndex == 1) return; 

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => SectorModal(
        onSectorSelected: (sectorName) {
          _addMarker(details.localPosition, sectorName);
        },
      ),
    );
  }

  void _addMarker(Offset position, String sectorName) {
    setState(() {
      _markers.add(
        MapMarker(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          position: position,
          sectorName: sectorName,
        ),
      );
    });
  }

  void _removeMarker(MapMarker marker) {
    if (_selectedToolIndex == 1) {
      setState(() => _markers.remove(marker));
    }
  }

  void _saveMap() {
    Navigator.popAndPushNamed(context, '/management');
  }
}