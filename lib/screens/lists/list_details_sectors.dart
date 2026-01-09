import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/core/themes/size_extensions.dart';
import 'package:vektor_if/core/widgets/background_image.dart';
import 'package:vektor_if/core/widgets/buttom_generic.dart';
import 'package:vektor_if/core/widgets/confirmation_dialog.dart';
import 'package:vektor_if/core/widgets/custom_back_button.dart';
import 'package:vektor_if/providers/auth_provider.dart';
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

  @override
  void initState() {
    super.initState();
    // Inicia a escuta dos setores assim que a tela abre
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = context.read<AuthProvider>().user;
      if (user != null) {
        context.read<SectorProvider>().startListeningToSectors(user.uid);
      }
    });
  }

  // Função para deletar
  void _confirmDelete(String sectorId) {
    showDialog(
      context: context,
      builder: (context) => ConfirmationDialog(
        title: "Excluir Setor?",
        subtitle:
            "Essa ação não pode ser desfeita e todos os dados deste setor serão perdidos.",
        confirmLabel: "Excluir",
        isDestructive: true,
        onConfirm: () async {
          //ação de deletar.
          final user = context.read<AuthProvider>().user;
          if (user != null) {
            await context.read<SectorProvider>().deleteSector(
              user.uid,
              sectorId,
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Consumindo o Provider
    final sectorProvider = context.watch<SectorProvider>();
    final isLoading = sectorProvider.isLoading;

    // Lógica de Busca
    final filteredSectors = sectorProvider.sectors.where((sector) {
      final query = _searchQuery.toLowerCase();
      return sector.name.toLowerCase().contains(query);
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

                  // Header
                  _buildHeader(context),

                  SizedBox(height: context.percentHeight(0.03)),

                  // Barra de Pesquis
                  SearchList(
                    onSearchChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    onFilterTap: () {
                      // sem filtro
                    },
                  ),

                  SizedBox(height: context.percentHeight(0.02)),

                  // LISTA REATIVA
                  Expanded(
                    child: isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : filteredSectors.isEmpty
                        ? Center(
                            child: Text(
                              _searchQuery.isEmpty
                                  ? "Nenhum setor cadastrado."
                                  : "Nenhum setor encontrado.",
                              style: const TextStyle(color: Colors.grey),
                            ),
                          )
                        : Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
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
                              // Removemos NeverScrollableScrollPhysics para a lista rolar dentro do Expanded
                              itemCount: filteredSectors.length,
                              separatorBuilder: (_, __) => const Divider(
                                height: 1,
                                thickness: 0.5,
                                indent: 16,
                                endIndent: 16,
                                color: AppTheme.primaryBlue,
                              ),
                              itemBuilder: (context, index) {
                                final sector = filteredSectors[index];
                                return SectorCard(
                                  name: sector.name,
                                  phone: sector.phone ?? "Sem telefone",
                                  description: sector.description ?? "",
                                  onEdit: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/sectors-register',
                                      arguments: sector,
                                    );
                                  },
                                  onDelete: () {
                                    if (sector.id != null) {
                                      _confirmDelete(sector.id!);
                                    }
                                  },
                                );
                              },
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
        const SizedBox(width: 48),
      ],
    );
  }
}
