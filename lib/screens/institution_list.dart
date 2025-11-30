import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/core/widgets/custom_header.dart';
import 'package:vektor_if/core/widgets/institution_cards.dart';
class SelectInstitutionScreen extends StatelessWidget {
  const SelectInstitutionScreen({super.key});

  final List<Map<String, String>> institutions = const [
    {"name": "Instituto Federal Do Maranhão", "address": "Av. Amazonas, Centro"},
    {"name": "Shopping Caxias", "address": "Rodovia BR-316"},
    {"name": "Embrapa", "address": "Zona Rural"},
    {"name": "LabTeste", "address": "Rua das Flores, 123"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomHeader(showBackButton: true),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 24),
                  Text(
                    "SELECIONE UMA INSTITUIÇÃO",
                    style: Theme.of(
                      context,
                    ).textTheme.headlineSmall?.copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: 5),

                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: institutions.length,
                      itemBuilder: (context, index) {
                        final item = institutions[index];

                        return InstitutionCards(
                          name: item["name"]!,
                          address: item["address"]!,
                          onTap: () {
                            print("Selecionou: ${item['name']}");
                          },
                        );
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            color: AppTheme.colorGrayText,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          children: [
                            const TextSpan(text: "Cadastre sua instituição "),
                            TextSpan(
                              text: "aqui",
                              style: TextStyle(
                                color: AppTheme.colorLogo,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
