import 'package:flutter/material.dart';

class UploadSection extends StatelessWidget {
  final VoidCallback onTap;

  const UploadSection({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFECF5FF), // Fundo azul claro
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF5046FA), width: 0.5), // Borda azul
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.cloud_upload_outlined,
                size: 32,
                color: Color(0xFF5046FA),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Carregue imagem do mapa',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF101011),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'JPEG ou PNG',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF7D7D7D), fontSize: 14),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: const Color(0xFFD5D3E0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 5),
                  )
                ],
              ),
              child: const Text(
                'Selecione Imagem',
                style: TextStyle(
                  color: Color(0xFF5046FA),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}