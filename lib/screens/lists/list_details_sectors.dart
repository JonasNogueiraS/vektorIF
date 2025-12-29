import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/core/themes/size_extensions.dart';
import 'package:vektor_if/core/widgets/background_image.dart';
import 'package:vektor_if/core/widgets/buttom_generic.dart';
import 'package:vektor_if/core/widgets/custom_back_button.dart';
import 'package:vektor_if/models/sectors_model.dart';
import 'package:vektor_if/models/data/sectors_repository.dart';
import 'package:vektor_if/screens/lists/widgets/search_colaborators.dart';
import 'package:vektor_if/screens/lists/widgets/sector_card.dart'; 

class ListDetailsSectors extends StatefulWidget {
  const ListDetailsSectors({super.key});

  @override
  State<ListDetailsSectors> createState() => _ListDetailsSectorsState();
}

class _ListDetailsSectorsState extends State<ListDetailsSectors> {
  final _repository = SectorsRepository();

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
                    onSearchChanged: (value) {},
                    onFilterTap: () {},
                  ),

                  SizedBox(height: context.percentHeight(0.02)),

                  //LISTA
                  Expanded(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: SingleChildScrollView(
                        physics: const ClampingScrollPhysics(), 
                        child: StreamBuilder<List<SectorModel>>(
                          stream: _repository.getSectorsStream(FirebaseAuth.instance.currentUser!.uid),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
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

                            final allSectors = snapshot.data!;
                           //elimina duplicatas automaticamente.
                            final uniqueSectorsMap = {
                              for (var sector in allSectors) sector.id: sector
                            };
                            // Converte de volta para lista para usar no ListView
                            final uniqueList = uniqueSectorsMap.values.toList();

                            return Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ListView.separated(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: uniqueList.length, //lista filtrada
                                separatorBuilder: (_, __) => const Divider(
                                  height: 2.5,
                                  thickness: 0.5,
                                  indent: 10, 
                                  endIndent: 16,
                                  color: AppTheme.primaryBlue,
                                ),
                                itemBuilder: (context, index) {
                                  final sector = uniqueList[index]; //item filtrado
                                  return SectorCard(
                                    name: sector.name,
                                    phone: sector.phone ?? "",
                                    description: (sector.description ?? "Sem descrição"),
                                    onEdit: () {
                                      // Futuro
                                    },
                                    onDelete: () {
                                      if (sector.id != null) {
                                        _repository.deleteSector(sector.id!);
                                      }
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CustomBackButtom(),
        Text(
          "Setores",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu, color: Color(0xff49454F)),
        ),
      ],
    );
  }
}