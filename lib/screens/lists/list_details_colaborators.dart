import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/core/themes/size_extensions.dart';
import 'package:vektor_if/core/widgets/background_image.dart';
import 'package:vektor_if/core/widgets/buttom_generic.dart';
import 'package:vektor_if/core/widgets/confirmation_dialog.dart';
import 'package:vektor_if/core/widgets/custom_back_button.dart';
import 'package:vektor_if/providers/auth_provider.dart';
import 'package:vektor_if/providers/collaborator_provider.dart';
import 'package:vektor_if/screens/lists/widgets/colaborators_cards.dart';
import 'package:vektor_if/screens/lists/widgets/search_functions.dart';

class ListDetailsColaborators extends StatefulWidget {
  const ListDetailsColaborators({super.key});

  @override
  State<ListDetailsColaborators> createState() =>
      _ListDetailsColaboratorsState();
}

class _ListDetailsColaboratorsState extends State<ListDetailsColaborators> {
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = context.read<AuthProvider>().user;
      if (user != null) {
        context.read<CollaboratorProvider>().startListeningToCollaborators(
          user.uid,
        );
      }
    });
  }

  void _confirmDelete(String id) {
    showDialog(
      context: context,
      builder: (context) => ConfirmationDialog(
        title: "Remover Colaborador?",
        subtitle: "Tem certeza que deseja remover este colaborador da lista?",
        confirmLabel: "Remover",
        isDestructive: true,
        onConfirm: () async {
          final user = context.read<AuthProvider>().user;
          if (user != null) {
            await context.read<CollaboratorProvider>().deleteCollaborator(
              user.uid,
              id,
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CollaboratorProvider>();
    final isLoading = provider.isLoading;

    final filteredList = provider.collaborators.where((colab) {
      return colab.name.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

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
                    onSearchChanged: (val) =>
                        setState(() => _searchQuery = val),
                    onFilterTap: () {},
                  ),

                  SizedBox(height: context.percentHeight(0.02)),

                  // LISTA
                  Expanded(
                    child: isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : filteredList.isEmpty
                        ? const Center(
                            child: Text("Nenhum colaborador encontrado."),
                          )
                        : Container(
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
                              itemCount: filteredList.length,
                              separatorBuilder: (_, __) => const Divider(
                                height: 1,
                                thickness: 0.5,
                                indent: 16,
                                endIndent: 16,
                                color: AppTheme.primaryBlue,
                              ),
                              itemBuilder: (context, index) {
                                final colab = filteredList[index];

                                return ColaboratorsCards(
                                  name: colab.name,
                                  email: colab.email,
                                  sector: colab.sectorName,
                                  isBoss: colab.isBoss,
                                  onEdit: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/collaborators-register',
                                      arguments: colab,
                                    );
                                  },
                                  onDelete: () => _confirmDelete(colab.id!),
                                );
                              },
                            ),
                          ),
                  ),

                  SizedBox(height: context.percentHeight(0.02)),

                  ButtomGeneric(
                    label: "Adicionar Colaborador",
                    backgroundColor: AppTheme.colorButtons,
                    onPressed: () =>
                        Navigator.pushNamed(context, '/collaborators-register'),
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
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 48),
      ],
    );
  }
}
