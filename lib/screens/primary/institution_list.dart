import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/models/institution_model.dart';
import 'package:vektor_if/models/data/insitution_repository.dart';
import 'package:vektor_if/screens/primary/widgets/institution_cards.dart';
import 'package:vektor_if/screens/primary/widgets/header_log.dart';

class SelectInstitutionScreen extends StatefulWidget {
  const SelectInstitutionScreen({super.key});

  @override
  State<SelectInstitutionScreen> createState() =>
      _SelectInstitutionScreenState();
}

class _SelectInstitutionScreenState extends State<SelectInstitutionScreen> {
  final _repository = InstitutionRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorBackground,
      body: Column(
        children: [
          const CustomHeader(showBackButton: true),
          
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

                  //LISTA DINÂMICA
                  Expanded(
                    child: StreamBuilder<List<InstitutionModel>>(
                      stream: _repository.getAllInstitutions(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text(
                              "Nenhuma instituição encontrada.",
                              style: TextStyle(color: Colors.grey),
                            ),
                          );
                        }

                        final institutions = snapshot.data!;

                        return ListView.separated(
                          padding: EdgeInsets.zero,
                          itemCount: institutions.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final item = institutions[index];

                            return GestureDetector(
                              onTap: () {
                                // AQUI É A MUDANÇA: Passamos os argumentos
                                Navigator.pushNamed(
                                  context,
                                  '/home-map',
                                  arguments: {
                                    'institutionId':
                                        item.id, // O ID para buscar os dados
                                    'institutionName': item
                                        .name, // O Nome para mostrar no Header
                                  },
                                );
                              },
                              child: InstitutionCard(
                                name: item.name,
                                address: item.address,
                                imagePath: item.photoUrl,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  SafeArea(
                    top: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              color: AppTheme.colorGrayText,
                              fontSize: 14,
                            ),
                            children: [
                              const TextSpan(text: "Cadastre sua instituição "),
                              TextSpan(
                                text: "aqui",
                                style: const TextStyle(
                                  color: AppTheme.colorLogo,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () =>
                                      Navigator.pushNamed(context, '/register'),
                              ),
                            ],
                          ),
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
