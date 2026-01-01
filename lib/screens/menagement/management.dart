import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/core/widgets/background_image.dart';
import 'package:vektor_if/core/widgets/buttom_generic.dart';
import 'package:vektor_if/core/widgets/forms_widgets.dart';
import 'package:vektor_if/core/widgets/menu_buttons.dart';
import 'package:vektor_if/core/widgets/success_feedback_dialog.dart';
import 'package:vektor_if/providers/auth_provider.dart'; 
import 'package:vektor_if/screens/menagement/controller/managemant_controller.dart';
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

  @override
  Widget build(BuildContext context) {
    //dados do Usuário via Provider
    final authProvider = context.watch<AuthProvider>();
    final user = authProvider.user;

    return Scaffold(
      backgroundColor: AppTheme.colorBackground,
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, child) {
          final institutionName = _controller.nameController.text.isNotEmpty
              ? _controller.nameController.text
              : "Carregando instituição...";

          return Stack(
            children: [
              const BackgroundImage(),
              SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),

                      //NOVO HEADER
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Bem-vindo, ${user?.displayName?.split(' ')[0]}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.colorBlackText,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                // Nome da Instituição
                                Text(
                                  "Gerencie: $institutionName",
                                  style: Theme.of(context).textTheme.bodyMedium
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
                          ),
                          // Menu de Opções
                          SettingsMenuButton(
                            options: [
                              MenuOption(
                                label: "Tela de visitante",
                                icon: Icons.map_outlined,
                                onTap: () {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/home-map', // Rota de visitante
                                    (route) => false,
                                  );
                                },
                              ),
                              MenuOption(
                                label: "Sair da Conta",
                                icon: Icons.logout,
                                color: Colors.redAccent,
                                onTap: () async {
                                  // Logout via Provider
                                  await context.read<AuthProvider>().logout();
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

                      const SizedBox(height: 30),
                      // Opções de Gerenciamento
                      ManagementOptionsList(
                        onSectorsTap: () =>
                            Navigator.pushNamed(context, '/sectors-list'),
                        onColabTap: () =>
                            Navigator.pushNamed(context, '/collaborators-list'),
                        onMapTap: () => Navigator.pushNamed(
                          context,
                          '/map-register',
                        ),
                      ),

                      const SizedBox(height: 40),

                      const Text(
                        "Informações da Instituição",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.colorBlackText,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // FORMULÁRIO
                      if (_controller.isLoading &&
                          _controller.nameController.text.isEmpty)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: CircularProgressIndicator(),
                          ),
                        )
                      else
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const FormLabel("Nome da Instituição"),
                            GenericInputField(
                              controller: _controller.nameController,
                              hint: "Ex: IFMA Campus Caxias",
                              outlined: false,
                            ),

                            const SizedBox(height: 16),

                            const FormLabel("Endereço"),
                            GenericInputField(
                              controller: _controller.addressController,
                              hint: "Ex: MA-034, Povoado Descanso",
                              outlined: false,
                            ),
                          ],
                        ),

                      // Mensagem de Erro
                      if (_controller.errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            _controller.errorMessage!,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ),

                      const SizedBox(height: 24),
                      ButtomGeneric(
                        label: "Salvar Alterações",
                        isLoading: _controller.isLoading,
                        onPressed: () {
                          _controller.saveChanges(
                            onSuccess: () {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => const SuccessFeedbackDialog(
                                  title: "Dados Atualizados!",
                                  subtitle:
                                      "As informações foram salvas com sucesso.",
                                ),
                              );
                              Future.delayed(const Duration(seconds: 2), () {
                                if (context.mounted) Navigator.pop(context);
                              });
                            },
                            onError: (msg) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(msg),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
