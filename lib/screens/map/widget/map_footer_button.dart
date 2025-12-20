import 'package:flutter/material.dart';
import 'package:vektor_if/core/widgets/button_generic.dart';

class MapFooterButton extends StatelessWidget {
  final VoidCallback? onSave;
  final bool isEnabled;

  const MapFooterButton({
    super.key,
    required this.onSave,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: ButtonGeneric(
        label: "Finalizar Mapeamento",
        onPressed: isEnabled ? onSave : null,
      ),
    );
  }
}