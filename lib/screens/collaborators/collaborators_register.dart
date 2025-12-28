import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/core/themes/size_extensions.dart';
import 'package:vektor_if/core/widgets/background_image.dart';
import 'package:vektor_if/core/widgets/forms_widgets.dart';
import 'package:vektor_if/core/widgets/success_feedback_dialog.dart';
import 'package:vektor_if/models/sectors_model.dart';
import 'package:vektor_if/screens/collaborators/controller/collaborators_controller.dart';
import 'package:vektor_if/screens/collaborators/widgets/buttons_collaborators.dart';

class CollaboratorsRegister extends StatefulWidget {
  const CollaboratorsRegister({super.key});

  @override
  State<CollaboratorsRegister> createState() => _CollaboratorsRegisterState();
}

class _CollaboratorsRegisterState extends State<CollaboratorsRegister> {
  final _controller = CollaboratorsController();

  @override
  void initState() {
    super.initState();
    // Busca os setores assim que a tela abre
    _controller.loadSectors();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSave() {
    _controller.saveEmployee(
      onSuccess: () {
        if (!mounted) return;
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const SuccessFeedbackDialog(
            title: "Sucesso!",
            subtitle: "Colaborador adicionado.",
          ),
        );
        Future.delayed(const Duration(milliseconds: 1500), () {
          if (mounted) {
            Navigator.pop(context); // Fecha Dialog
            Navigator.pop(context); // Fecha Tela
          }
        });
      },
      onError: (msg) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(msg), backgroundColor: Colors.red),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorBackground,
      body: Stack(
        children: [
          const BackgroundImage(),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: context.percentWidth(0.05),
                vertical: context.percentHeight(0.02),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),

                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Gestão de Colaborador",
                        style: Theme.of(
                          context,
                        ).textTheme.headlineSmall?.copyWith(fontSize: 20),
                      ),
                    ],
                  ),

                  SizedBox(height: context.percentHeight(0.03)),

                  CircularImagePicker(onTap: () {
                    
                  }, label: 'Envie uma foto do\n colaborador',),

                  SizedBox(height: context.percentHeight(0.03)),

                  const FormLabel("Nome completo"),
                  GenericInputField(
                    controller: _controller.nameController,
                    hint: "Ex: Jonas Sena",
                  ),

                  SizedBox(height: context.percentHeight(0.02)),

                  const FormLabel("Email"),
                  GenericInputField(
                    controller: _controller.emailController,
                    hint: "Ex: jonas@email.com",
                    keyboardType: TextInputType.emailAddress,
                  ),

                  SizedBox(height: context.percentHeight(0.02)),

                  const FormLabel("Telefone"),
                  GenericInputField(
                    controller: _controller.phoneController,
                    hint: "(99) 99999-9999",
                    keyboardType: TextInputType.phone,
                  ),

                  SizedBox(height: context.percentHeight(0.02)),

                  // DROPDOWN DE SETORES DINÂMICO
                  const FormLabel("Setor"),
                  ListenableBuilder(
                    listenable: _controller,
                    builder: (context, child) {
                      if (_controller.isLoadingSectors) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      // Se não houver setores cadastrados
                      if (_controller.availableSectors.isEmpty) {
                        return Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.red.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            "Nenhum setor cadastrado. Cadastre setores antes.",
                          ),
                        );
                      }

                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xffF2F2F2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<SectorModel>(
                            value: _controller.selectedSector,
                            hint: const Text("Selecione o setor..."),
                            isExpanded: true,
                            icon: const Icon(Icons.arrow_drop_down),
                            // Mapeia a lista de OBJETOS SectorModel
                            items: _controller.availableSectors.map((
                              SectorModel sector,
                            ) {
                              return DropdownMenuItem<SectorModel>(
                                value: sector,
                                child: Text(sector.name), // Mostra o nome
                              );
                            }).toList(),
                            onChanged: _controller.setSector,
                          ),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: context.percentHeight(0.02)),

                  // Checkbox Chefe
                  ListenableBuilder(
                    listenable: _controller,
                    builder: (context, child) {
                      return Row(
                        children: [
                          Checkbox(
                            value: _controller.isBoss,
                            activeColor: AppTheme.colorLogo,
                            onChanged: _controller.toggleBoss,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const Text(
                            "Chefe do setor",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  SizedBox(height: context.percentHeight(0.05)),
                  // Botões
                  ListenableBuilder(
                    listenable: _controller,
                    builder: (context, child) {
                      if (_controller.isSaving) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return ButtonsCollaborators(onSave: _handleSave);
                    },
                  ),

                  SizedBox(height: context.percentHeight(0.05)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
