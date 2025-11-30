import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/core/widgets/custom_header.dart';

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
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: const [
                        InstitutionCard(
                          name: "Instituto Federal Do Maranhão",
                          address: "Endereço",
                        ),
                        InstitutionCard(
                          name: "Shopping Caxias",
                          address: "Endereço",
                        ),
                        InstitutionCard(name: "Embrapa", address: "Endereço"),
                        InstitutionCard(name: "LabTeste", address: "Endereço"),
                      ],
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

class InstitutionCard extends StatelessWidget {
  final String name;
  final String address;

  const InstitutionCard({super.key, required this.name, required this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0x1B000000),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFFE8F0FE), // Azul bem clarinho
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Text(address),
        trailing: const Icon(Icons.arrow_forward, color: Colors.black54),
        onTap: () {
          // Futuro: Navegar para o mapa dessa instituição
          print("Clicou em $name");
        },
      ),
    );
  }
}
