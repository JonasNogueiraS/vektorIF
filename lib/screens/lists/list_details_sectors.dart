import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/core/themes/size_extensions.dart';
import 'package:vektor_if/core/widgets/background_image.dart';
import 'package:vektor_if/core/widgets/buttom_generic.dart';
import 'package:vektor_if/core/widgets/confirmation_dialog.dart';
import 'package:vektor_if/core/widgets/custom_back_button.dart';
import 'package:vektor_if/providers/sector_provider.dart';
import 'package:vektor_if/screens/lists/widgets/search_functions.dart';
import 'package:vektor_if/screens/lists/widgets/sector_card.dart';

class ListDetailsSectors extends StatefulWidget {
  const ListDetailsSectors({super.key});

  @override
  State<ListDetailsSectors> createState() => _ListDetailsSectorsState();
}

class _ListDetailsSectorsState extends State<ListDetailsSectors> {
  String _searchQuery = "";
  bool _isDescending = false; 

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        context.read<SectorProvider>().startListeningToSectors(user.uid);
      }
    });
  }

  void _confirmDelete(String id) {
    showDialog(
      context: context,
      builder: (context) => ConfirmationDialog(
        title: "Excluir Setor?",
        subtitle:
            "Essa ação não pode ser desfeita e todos os dados deste setor serão perdidos.",
        confirmLabel: "Excluir",
        isDestructive: true,
        onConfirm: () async {
          final user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            await context.read<SectorProvider>().deleteSector(user.uid, id);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SectorProvider>();
    final isLoading = provider.isLoading;
    final rawList = provider.sectors;

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

                  Expanded(
                    child: Builder(
                      builder: (context) {
                        if (isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        var filteredList = rawList.where((sector) {
                          return sector.name.toLowerCase().contains(
                            _searchQuery.toLowerCase(),
                          );
                        }).toList();

                        filteredList.sort((a, b) {
                          int comparison = a.name.toLowerCase().compareTo(
                            b.name.toLowerCase(),
                          );
                          return _isDescending ? -comparison : comparison;
                        });

                        //SingleScrollView + ShrinkWrap
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
                            child: ListView.separated(
                              shrinkWrap: true, // Ocupa apenas o necessário
                              physics:
                                  const NeverScrollableScrollPhysics(), // Scroll controlado pelo pai
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
                                final sector = filteredList[index];

                                return SectorCard(
                                  name: sector.name,
                                  phone: sector.phone ?? "",
                                  description: sector.description ?? "",
                                  onEdit: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/sectors-register',
                                      arguments: sector,
                                    );
                                  },
                                  onDelete: () => _confirmDelete(sector.id!),
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
                    label: "Adicionar Setor",
                    backgroundColor: AppTheme.colorButtons,
                    onPressed: () {
                      Navigator.pushNamed(context, '/sectors-register');
                    },
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
          "Setores",
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
