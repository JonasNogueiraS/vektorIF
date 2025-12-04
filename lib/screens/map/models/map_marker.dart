import 'package:flutter/material.dart'; 

class MapMarker {
  final String id;
  final Offset position;
  final String sectorName;

  MapMarker({
    required this.id,
    required this.position,
    required this.sectorName,
  });
}