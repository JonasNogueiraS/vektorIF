import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/core/themes/size_extensions.dart';
import 'package:vektor_if/core/widgets/background_image.dart';
import 'package:vektor_if/core/widgets/buttom_generic.dart';
import 'package:vektor_if/core/widgets/custom_back_button.dart';
import 'package:vektor_if/models/colaborators_model.dart';
import 'package:vektor_if/models/data/colaborators_repository.dart';
import 'package:vektor_if/screens/lists/widgets/colaborators_cards.dart';
import 'package:vektor_if/screens/lists/widgets/search_colaborators.dart';

class ListDetailsColaborators extends StatefulWidget {
  const ListDetailsColaborators({super.key});

  @override
  State<ListDetailsColaborators> createState() =>
      _ListDetailsColaboratorsState();
}

class _ListDetailsColaboratorsState extends State<ListDetailsColaborators> {
  final _repository = CollaboratorRepository();

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

                  //Expanded 
                  Expanded(
                    child: Align(
                      alignment: Alignment.topCenter, // Garante que começa do topo
                      child: SingleChildScrollView(
                        // Permite rolar se a lista crescer além do espaço
                        physics: const ClampingScrollPhysics(),
                        child: StreamBuilder<List<CollaboratorModel>>(
                          stream: _repository.getCollaboratorsStream(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            }

                            if (snapshot.hasError) {
                              return const Center(child: Text("Erro ao carregar."));
                            }

                            if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return const Center(
                                child: Text(
                                  "Nenhum colaborador cadastrado.",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              );
                            }

                            final employees = snapshot.data!;

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
                              // ListView agora se comporta como um bloco de conteúdo
                              child: ListView.separated(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true, //  Ocupa só o necessário
                                physics: const NeverScrollableScrollPhysics(), // Quem rola é o SingleChildScrollView pai
                                itemCount: employees.length,
                                separatorBuilder: (_, __) => const Divider(
                                  height: 2.5,
                                  thickness: 0.5,
                                  indent: 10,
                                  endIndent: 16,
                                  color:AppTheme.primaryBlue,
                                ),
                                itemBuilder: (context, index) {
                                  final employee = employees[index];

                                  return ColaboratorsCards(
                                    name: employee.name,
                                    email: employee.email,
                                    sector: employee.sectorName,
                                    isBoss: employee.isBoss,
                                    onEdit: () {},
                                    onDelete: () {
                                      if (employee.id != null) {
                                        _repository.deleteCollaborator(employee.id!);
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
        const CustomBackButtom(),
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