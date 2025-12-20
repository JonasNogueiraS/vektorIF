import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/core/themes/size_extensions.dart';
import 'package:vektor_if/core/widgets/background_image.dart';
import 'package:vektor_if/core/widgets/custom_back_button.dart';
import 'package:vektor_if/core/widgets/button_generic.dart';
import 'package:vektor_if/models/data/collaborators_repository.dart';
import 'package:vektor_if/screens/lists/widgets/collaborators_cards.dart';
import 'package:vektor_if/core/widgets/search_field.dart';


class ListDetailsCollaborators extends StatefulWidget {
  const ListDetailsCollaborators({super.key});

  @override
  State<ListDetailsCollaborators> createState() => _ListDetailsCollaboratorsState();
}

class _ListDetailsCollaboratorsState extends State<ListDetailsCollaborators> {


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

                  SearchField(
                    hintText: "Pesquisar colaborador...",
                    onSearchChanged: (value) {
                    },
                    onFilterTap: () {},
                  ),

                  SizedBox(height: context.percentHeight(0.02)),

                  Expanded(
                    child: ListView.separated(
                      itemCount: mockEmployees.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final employee = mockEmployees[index];
                        
                        return CollaboratorsCards(
                          name: employee.name,
                          email: employee.email,
                          sector: employee.sector,
                          onEdit: () {},
                          onDelete: () {},
                        );
                      },
                    ),
                  ),

                  SizedBox(height: context.percentHeight(0.02)),

                  ButtonGeneric(
                    label: "Adicionar Colaborador",
                    backgroundColor: AppTheme.colorButtons, 
                    onPressed: () {
                      Navigator.pushNamed(context, '/collaborators-register');
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
        const CustomBackButton(),
        Text(
          "Colaboradores",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontSize: 20,
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