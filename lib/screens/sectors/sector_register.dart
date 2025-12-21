import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/core/themes/size_extensions.dart';
import 'package:vektor_if/core/widgets/background_image.dart';
import 'package:vektor_if/core/widgets/custom_back_button.dart';
import 'package:vektor_if/core/widgets/forms_widgets.dart';
import 'package:vektor_if/screens/sectors/controller/sector_register_controller.dart';
import 'package:vektor_if/screens/sectors/widgets/buttons_sectors.dart';


class SectorRegisterScreen extends StatefulWidget {
  const SectorRegisterScreen({super.key});

  @override
  State<SectorRegisterScreen> createState() => _SectorRegisterScreenState();
}

class _SectorRegisterScreenState extends State<SectorRegisterScreen> {
  final _controller = SectorRegisterController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomBackButtom(),
                      Text(
                        "Gestão de Setores",
                        style: Theme.of(
                          context,
                        ).textTheme.headlineSmall?.copyWith(fontSize: 20),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.menu, color: Color(0xff49454F)),
                      ),
                    ],
                  ),

                  SizedBox(height: context.percentHeight(0.03)),

                  CircularImagePicker(
                    label: "Adicione uma foto da instituição",
                    onTap: (){
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Abrir galeria")),
                      );
                    }),
                  
                  SizedBox(height: context.percentHeight(0.03)),
                  const FormLabel("Nome do Setor"),
                  GenericInputField(
                    controller: _controller.nameController,
                    hint: "Ex: Coordenação de TI",
                    outlined: false,
                  ),

                  SizedBox(height: context.percentHeight(0.02)),

                  ListenableBuilder(
                    listenable: _controller,
                    builder: (context, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const FormLabel("E-mail do Setor"),
                          GenericInputField(
                            controller: _controller.emailController,
                            hint: "setor@ifma.edu.br",
                            enabled: !_controller.noEmail,
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: _controller.noEmail,
                                activeColor: AppTheme.colorLogo,
                                onChanged: _controller.toggleNoEmail,
                              ),
                              const Text(
                                "Não possui e-mail",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),

                  SizedBox(height: context.percentHeight(0.01)),

                  ListenableBuilder(
                    listenable: _controller,
                    builder: (context, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const FormLabel("Telefone"),
                          GenericInputField(
                            controller: _controller.phoneController,
                            hint: "(99) 99999-9999",
                            keyboardType: TextInputType.phone,
                            enabled: !_controller.noPhone,
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: _controller.noPhone,
                                activeColor: AppTheme.colorLogo,
                                onChanged: _controller.toggleNoPhone,
                              ),
                              const Text(
                                "Não possui telefone",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),

                  SizedBox(height: context.percentHeight(0.02)),

                  const FormLabel("Descrição"),
                  GenericInputField(
                    controller: _controller.descriptionController,
                    hint: "Breve descrição das atividades...",
                    maxLines: 4,
                  ),

                  SizedBox(height: context.percentHeight(0.05)),

                  // Botões
                  ButtonsSectors(
                    onSave: _controller.saveSector),

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
