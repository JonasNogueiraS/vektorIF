import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/core/themes/size_extensions.dart';
import 'package:vektor_if/core/widgets/background_image.dart';
import 'package:vektor_if/core/widgets/forms_widgets.dart';
import 'package:vektor_if/core/widgets/success_feedback_dialog.dart';
import 'package:vektor_if/screens/sectors/controller/sector_register_controller.dart';
import 'package:vektor_if/screens/sectors/widgets/buttons_sectors.dart';
import 'package:vektor_if/screens/sectors/widgets/sector_form_components.dart';

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

  void _handleSave() {
    _controller.saveSector(
      onSuccess: () {
        if (!mounted) return;

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const SuccessFeedbackDialog(
            title: "Sucesso!",
            subtitle: "O setor foi cadastrado corretamente.",
          ),
        );
        
        Future.delayed(const Duration(milliseconds: 1500), () {
          if (mounted) {
            Navigator.pop(context); 
            Navigator.pop(context); 
          }
        });
      },
      onError: (msg) {
        if (!mounted) return; 
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(msg),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
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
                        "Gestão de Setores",
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 20),
                      ),
                    ],
                  ),

                  SizedBox(height: context.percentHeight(0.03)),

                  CircularImagePicker(
                    label: "Adicione uma foto da instituição",
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Em breve!")),
                      );
                    },
                  ),

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
                        children: [
                          //Email
                          ToggleableContactInput(
                            label: "E-mail do Setor",
                            hint: "setor@ifma.edu.br",
                            controller: _controller.emailController,
                            isDisabled: _controller.noEmail,
                            checkboxLabel: "Não possui e-mail",
                            onToggle: _controller.toggleNoEmail,
                          ),

                          SizedBox(height: context.percentHeight(0.01)),

                          //Campo Telefone
                          ToggleableContactInput(
                            label: "Telefone",
                            hint: "(99) 99999-9999",
                            controller: _controller.phoneController,
                            isDisabled: _controller.noPhone,
                            checkboxLabel: "Não possui telefone",
                            onToggle: _controller.toggleNoPhone,
                            keyboardType: TextInputType.phone,
                          ),
                          
                          SizedBox(height: context.percentHeight(0.02)),

                          //Dropdown 
                          SectorCategoryDropdown(
                            selectedCategory: _controller.selectedCategory,
                            categories: _controller.categories,
                            onChanged: _controller.setCategory,
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

                  ListenableBuilder(
                    listenable: _controller,
                    builder: (context, child) {
                      if (_controller.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return ButtonsSectors(onSave: _handleSave);
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