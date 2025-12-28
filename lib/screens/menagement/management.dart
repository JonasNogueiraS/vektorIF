import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/core/widgets/background_image.dart';
import 'package:vektor_if/core/widgets/buttom_generic.dart';
import 'package:vektor_if/core/widgets/forms_widgets.dart';
import 'package:vektor_if/core/widgets/menu_buttons.dart';
import 'package:vektor_if/core/widgets/success_feedback_dialog.dart';
import 'package:vektor_if/screens/menagement/controller/managemant_controller.dart';
import 'package:vektor_if/screens/menagement/widget/institution_cards.dart';
import 'package:vektor_if/screens/menagement/widget/list_managements.dart';

class ManagementScreen extends StatefulWidget {
  const ManagementScreen({super.key});

  @override
  State<ManagementScreen> createState() => _ManagementScreenState();
}

class _ManagementScreenState extends State<ManagementScreen> {
  // Instancia o Controller
  final _controller = ManagementController();

  @override
  void initState() {
    super.initState();
    // Carrega os dados assim que a tela abre
    _controller.loadInstitutionData();
  }

  @override
  void dispose() {
    _controller.dispose(); // Limpa a memória
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorBackground,
      //escuta o controller para atualizar a tela (Loading, Erros, Dados)
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, child) {
          // Se estiver carregando os dados iniciais, mostra loading
          if (_controller.isLoading &&
              _controller.nameController.text.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return Stack(
            children: [
              const BackgroundImage(),
              SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),

                      // HEADER
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Gerenciamento",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          SettingsMenuButton(
                            options: [
                              MenuOption(
                                label: "Voltar ao Mapa",
                                icon: Icons.map,
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
                                  await FirebaseAuth.instance.signOut();
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
                      const SizedBox(height: 10),

                      // CARD DA INSTITUIÇÃO
                      InstitutionCard(
                        name: _controller.nameController.text.isNotEmpty
                            ? _controller.nameController.text
                            : "Carregando...",
                        address: _controller.addressController.text.isNotEmpty
                            ? _controller.addressController.text
                            : "...",
                      ),

                      const SizedBox(height: 30),

                      //NAVEGAÇÃO
                      ManagementOptionsList(
                        onSectorsTap: () {
                          Navigator.pushNamed(context, '/sectors-list');
                        },
                        onColabTap: () {
                          Navigator.pushNamed(context, '/collaborators-list');
                        },
                        onMapTap: () {
                          Navigator.pushNamed(context, '/map-register');
                        },
                      ),

                      const SizedBox(height: 30),

                      Text(
                        "Informações da Instituição",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.colorBlackText,
                        ),
                      ),
                      const SizedBox(height: 16),

                      //FORMULÁRIO DE EDIÇÃO 
                      const FormLabel("Nome"),
                      GenericInputField(
                        controller: _controller.nameController,
                        hint: "Nome da Instituição",
                        outlined: false,
                      ),

                      const SizedBox(height: 16),

                      const FormLabel("Endereço"),
                      GenericInputField(
                        controller: _controller.addressController,
                        hint: "Endereço da Instituição",
                        outlined: false,
                      ),

                      // Exibe mensagem de erro 
                      if (_controller.errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            _controller.errorMessage!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),

                      const SizedBox(height: 10),

                      //BOTÃO SALVAR
                      ButtomGeneric(
                        label: "Salvar Alterações",
                        isLoading:
                            _controller.isLoading, // Mostra spinner no botão
                        onPressed: () {
                          _controller.saveChanges(
                            onSuccess: () {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) =>
                                    const SuccessFeedbackDialog(
                                      title: "Sucesso!",
                                      subtitle:
                                          "Dados da instituição atualizados.",
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
