import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/screens/primary/widgets/header_log.dart';
import 'package:vektor_if/screens/primary/widgets/institution_cards.dart';
import 'package:vektor_if/models/data/insitution_repository.dart';

class SelectInstitutionScreen extends StatelessWidget {
  const SelectInstitutionScreen({super.key});

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
                      itemCount: mockInstitutions.length,
                      itemBuilder: (context, index) {
                        final item = mockInstitutions[index];

                        return InstitutionCards(
                          name: item.name,
                          address: item.address,
                          onTap: () {
                            Navigator.pushNamed(context, '/home-map');
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
