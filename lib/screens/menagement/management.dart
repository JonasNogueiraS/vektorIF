import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/core/themes/size_extensions.dart';
import 'package:vektor_if/core/widgets/background_image.dart';
import 'package:vektor_if/core/widgets/buttom_generic.dart';
import 'package:vektor_if/core/widgets/menu_buttons.dart';
import 'package:vektor_if/providers/auth_provider.dart';
import 'package:vektor_if/screens/menagement/controller/managemant_controller.dart';
import 'package:vektor_if/screens/menagement/widget/institution_edit_sheet.dart';
import 'package:vektor_if/screens/menagement/widget/list_managements.dart';

class ManagementScreen extends StatefulWidget {
  const ManagementScreen({super.key});

  @override
  State<ManagementScreen> createState() => _ManagementScreenState();
}

class _ManagementScreenState extends State<ManagementScreen> {
  final _controller = ManagementController();

  @override
  void initState() {
    super.initState();
    _controller.loadInstitutionData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openEditSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => InstitutionEditSheet(controller: _controller),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final user = authProvider.user;

    return Scaffold(
      backgroundColor: AppTheme.colorBackground,
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, child) {
          final institutionName = _controller.nameController.text.isNotEmpty
              ? _controller.nameController.text
              : "Carregando...";

          return Stack(
            children: [
              const BackgroundImage(),
              SafeArea(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: IntrinsicHeight(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SettingsMenuButton(
                                      options: [
                                        MenuOption(
                                          label: "Tela de visitante",
                                          icon: Icons.map_outlined,
                                          onTap: () {
                                            Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              '/home-map',
                                              (route) => false,
                                            );
                                          },
                                        ),
                                        MenuOption(
                                          label: "Sair da Conta",
                                          icon: Icons.logout,
                                          color: Colors.redAccent,
                                          onTap: () async {
                                            await context
                                                .read<AuthProvider>()
                                                .logout();
                                            if (context.mounted) {
                                              Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                '/',
                                                (route) => false,
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),


                                SizedBox(height: context.percentHeight(0.05)),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Bem-vindo, ${user?.displayName?.split(' ')[0] ?? 'Gerente'}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: AppTheme.colorBlackText,
                                          ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Gerencie: $institutionName",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: AppTheme.colorLogo,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),

                                
                                SizedBox(height: context.percentHeight(0.10)),

                              
                                ManagementOptionsList(
                                  onSectorsTap: () => Navigator.pushNamed(
                                    context,
                                    '/sectors-list',
                                  ),
                                  onColabTap: () => Navigator.pushNamed(
                                    context,
                                    '/collaborators-list',
                                  ),
                                  onMapTap: () => Navigator.pushNamed(
                                    context,
                                    '/map-register',
                                  ),
                                ),

                                const Spacer(),

                                const Text(
                                  "Configurações",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.colorBlackText,
                                  ),
                                ),
                                const SizedBox(height: 16),

                                ButtomGeneric(
                                  label: "Editar Informações",
                                  backgroundColor: Colors.white,
                                  textColor: AppTheme.colorButtons,
                                  onPressed: _openEditSheet,
                                ),

                                SizedBox(height: context.percentHeight(0.05)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}