import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/core/themes/size_extensions.dart';
import 'package:vektor_if/core/widgets/background_image.dart';
import 'package:vektor_if/core/widgets/buttom_generic.dart';
import 'package:vektor_if/core/widgets/confirmation_dialog.dart';
import 'package:vektor_if/core/widgets/custom_back_button.dart';
import 'package:vektor_if/providers/collaborator_provider.dart';
import 'package:vektor_if/screens/lists/widgets/colaborators_cards.dart';
import 'package:vektor_if/screens/lists/widgets/search_functions.dart'; 

class ListDetailsColaborators extends StatefulWidget {
  const ListDetailsColaborators({super.key});

  @override
  State<ListDetailsColaborators> createState() => _ListDetailsColaboratorsState();
}

class _ListDetailsColaboratorsState extends State<ListDetailsColaborators> {
  String _searchQuery = "";
  bool _isDescending = false; 

  @override
  void initState() {
    super.initState();
    // Inicia a escuta no Provider assim que a tela abre
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        context.read<CollaboratorProvider>().startListeningToCollaborators(user.uid);
      }
    });
  }

  void _confirmDelete(String id) {
    showDialog(
      context: context,
      builder: (context) => ConfirmationDialog(
        title: "Remover Colaborador?",
        subtitle: "Tem certeza que deseja remover este colaborador?",
        confirmLabel: "Remover",
        isDestructive: true,
        onConfirm: () async {
          final user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            await context.read<CollaboratorProvider>().deleteCollaborator(user.uid, id);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CollaboratorProvider>();
    final isLoading = provider.isLoading;
    final readList = provider.collaborators;

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
                    onSearchChanged: (val) {
                      setState(() => _searchQuery = val);
                    },
                    onFilterTap: () {
                      setState(() {
                        _isDescending = !_isDescending;
                        
                      });
                    },
                  ),

                  SizedBox(height: context.percentHeight(0.02)),

                  // 
                  Expanded( 
                    child: Builder(
                      builder: (context) {
                        if (isLoading) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        //Busca
                        var filteredList = readList.where((colab) {
                          return colab.name.toLowerCase().contains(_searchQuery.toLowerCase());
                        }).toList();
                        // Ordenação
                        filteredList.sort((a, b) {
                          int comparison = a.name.toLowerCase().compareTo(b.name.toLowerCase());
                          return _isDescending ? -comparison : comparison; 
                        });

                        //Container Branco Responsivo
                        return SingleChildScrollView(
                          child: Container(
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
                            // shrinkWrap: true faz a ListView ocupar só o tamanho dos filhos
                            // physics: NeverScrollableScrollPhysics pois o SingleChildScrollView de fora rola
                            child: ListView.separated(
                              shrinkWrap: true, 
                              physics: const NeverScrollableScrollPhysics(),
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
                                      arguments: colab
                                    );
                                  },
                                  onDelete: () => _confirmDelete(colab.id!),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: context.percentHeight(0.02)),

                  ButtomGeneric(
                    label: "Adicionar Colaborador",
                    backgroundColor: AppTheme.colorButtons,
                    onPressed: () => Navigator.pushNamed(
                        context, '/collaborators-register'),
                  ),
                  
                  const SizedBox(height: 20),
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