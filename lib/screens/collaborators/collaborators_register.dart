import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/core/themes/size_extensions.dart';
import 'package:vektor_if/core/widgets/background_image.dart';
import 'package:vektor_if/core/widgets/custom_back_button.dart';
import 'package:vektor_if/screens/collaborators/controller/collaborators_controller.dart';
import 'package:vektor_if/screens/collaborators/widgets/buttons_collaborators.dart';
import 'package:vektor_if/core/widgets/forms/form_input_field.dart';
import 'package:vektor_if/core/widgets/forms/form_label.dart';
import 'package:vektor_if/core/widgets/forms/image_upload_area.dart';

class CollaboratorsRegister extends StatefulWidget {
  const CollaboratorsRegister({super.key});

  @override
  State<CollaboratorsRegister> createState() => _CollaboratorsRegisterState();
}

class _CollaboratorsRegisterState extends State<CollaboratorsRegister> {
  final _controller = CollaboratorsController();

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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomBackButton(),
                      Text(
                        "Gestão de Colaborador",
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

                  const ImageUploadArea(),

                  SizedBox(height: context.percentHeight(0.03)),

                  const FormLabel("Nome completo"),
                  FormInputField(
                    controller: _controller.nameController,
                    hint: "Ex: Jonas Sena",
                  ),

                  SizedBox(height: context.percentHeight(0.02)),

                  const FormLabel("Email"),
                  FormInputField(
                    controller: _controller.emailController,
                    hint: "Ex: jonas@email.com",
                    keyboardType: TextInputType.emailAddress,
                  ),

                  SizedBox(height: context.percentHeight(0.02)),

                  const FormLabel("Telefone"),
                  FormInputField(
                    controller: _controller.phoneController,
                    hint: "(99) 99999-9999",
                    keyboardType: TextInputType.phone,
                  ),

                  SizedBox(height: context.percentHeight(0.02)),
                  //dropdown
                  const FormLabel("Setor"),
                  ListenableBuilder(
                    listenable: _controller,
                    builder: (context, child) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Color(0xffF2F2F2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _controller.selectedSector,
                            hint: const Text("Selecione o setor..."),
                            isExpanded: true,
                            icon: const Icon(Icons.arrow_drop_down),
                            items: _controller.availableSectors.map((
                              String sector,
                            ) {
                              return DropdownMenuItem<String>(
                                value: sector,
                                child: Text(sector),
                              );
                            }).toList(),
                            onChanged: _controller.setSector,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: context.percentHeight(0.02)),

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

                  ButtonsCollaborators(onSave: _controller.saveEmployee),

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
