import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/core/themes/size_extensions.dart';
import 'package:vektor_if/core/widgets/background_image.dart';
import 'package:vektor_if/core/widgets/buttom_generic.dart';
import 'package:vektor_if/models/sectors_model.dart';
import 'package:vektor_if/models/data/sectors_repository.dart';
import 'package:vektor_if/screens/lists/widgets/search_colaborators.dart';
import 'widgets/sector_card.dart';

class ListDetailsSectors extends StatefulWidget {
  const ListDetailsSectors({super.key});

  @override
  State<ListDetailsSectors> createState() => _ListDetailsSectorsState();
}

class _ListDetailsSectorsState extends State<ListDetailsSectors> {
  final _repository = SectorsRepository(); // Instancia o Repo

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorBackground,
      body: Stack(
        children: [
          const BackgroundImage(),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.percentWidth(0.05),
                vertical: context.percentHeight(0.02),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),

                  _buildHeader(context),

                  SizedBox(height: context.percentHeight(0.03)),

                  SearchList(
                    onSearchChanged: (value) {
                      //Implementar filtro local
                    },
                    onFilterTap: () {},
                  ),

                  SizedBox(height: context.percentHeight(0.02)),

                  // LISTA DINÂMICA
                  Expanded(
                    child: StreamBuilder<List<SectorModel>>(
                      stream: _repository.getSectorsStream(),
                      builder: (context, snapshot) {
                        //Carregando
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text("Erro ao carregar dados."),
                          );
                        }
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text(
                              "Nenhum setor cadastrado.",
                              style: TextStyle(color: Colors.grey),
                            ),
                          );
                        }

                        final sectors = snapshot.data!;

                        return ListView.separated(
                          itemCount: sectors.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final sector = sectors[index];
                            return SectorCard(
                              name: sector.name,
                              phone: sector.phone ?? "Sem telefone",
                              description: sector.description,
                              onEdit: () {
                                // Navegar para edição
                              },
                              onDelete: () {
                                if (sector.id != null) {
                                  _repository.deleteSector(sector.id!);
                                }
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),

                  SizedBox(height: context.percentHeight(0.02)),

                  ButtomGeneric(
                    label: "Adicionar Setor",
                    backgroundColor: AppTheme.colorButtons,
                    onPressed: () {
                      Navigator.pushNamed(context, '/sectors-register');
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Setores",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
