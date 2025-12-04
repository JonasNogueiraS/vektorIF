import 'package:flutter/material.dart';
import 'package:vektor_if/core/widgets/buttom_generic.dart';

class MapFooterButtom extends StatelessWidget {
  final VoidCallback? onSave;
  final bool isEnabled;

  const MapFooterButtom({
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
      child: ButtomGeneric(
        label: "Finalizar Mapeamento",
        onPressed: isEnabled ? onSave : null,
      ),
    );
  }
}