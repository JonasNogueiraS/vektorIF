import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/core/themes/size_extensions.dart';
import 'package:vektor_if/core/widgets/background_image.dart';
import 'package:vektor_if/core/widgets/buttom_generic.dart';
import 'package:vektor_if/core/widgets/custom_back_button.dart';
import 'package:vektor_if/models/data/sectors_repository.dart';
import 'package:vektor_if/screens/lists/widgets/search_colaborators.dart'; 
import 'widgets/sector_card.dart';

class ListDetailsSectors extends StatefulWidget {
  const ListDetailsSectors({super.key});

  @override
  State<ListDetailsSectors> createState() => _ListDetailsSectorsState();
}

class _ListDetailsSectorsState extends State<ListDetailsSectors> {

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
                  
                  // Header
                  _buildHeader(context),

                  SizedBox(height: context.percentHeight(0.03)),

                  SearchColaborators(
                    onSearchChanged: (value) {},
                    onFilterTap: () {},
                  ),

                  SizedBox(height: context.percentHeight(0.02)),

                  // Lista de Setores
                  Expanded(
                    child: ListView.separated(
                      itemCount: mockSectors.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final sector = mockSectors[index];
                        return SectorCard(
                          name: sector.name,
                          phone: sector.phone,
                          description: sector.description,
                          onEdit: () =>{},
                          onDelete: () => {},
                        );
                      },
                    ),
                  ),

                  SizedBox(height: context.percentHeight(0.02)),

                  // Botão Adicionar
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