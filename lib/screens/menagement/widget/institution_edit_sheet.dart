import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/core/widgets/buttom_generic.dart';
import 'package:vektor_if/core/widgets/forms_widgets.dart';
import 'package:vektor_if/core/widgets/success_feedback_dialog.dart';
import 'package:vektor_if/screens/menagement/controller/managemant_controller.dart';

class InstitutionEditSheet extends StatelessWidget {
  final ManagementController controller;

  const InstitutionEditSheet({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    // Captura a altura do teclado
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      width: double.infinity, // Garante largura total
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        // Sombra opcional para dar mais destaque ao "card" subindo
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      // 1. SafeArea garante que não colamos na barra de sistema do Android/iOS
      child: SafeArea(
        child: Padding(
          // 2. Adicionamos o espaço do teclado aqui
          padding: EdgeInsets.only(bottom: keyboardSpace),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Ocupa apenas o necessário
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Indicador visual de "puxar"
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),

                const Text(
                  "Editar Informações",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.colorBlackText,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                const FormLabel("Nome da Instituição"),
                GenericInputField(
                  controller: controller.nameController,
                  hint: "Ex: IFMA Campus Caxias",
                  outlined: true,
                ),

                const SizedBox(height: 16),

                const FormLabel("Endereço"),
                GenericInputField(
                  controller: controller.addressController,
                  hint: "Ex: MA-034, Povoado Descanso",
                  outlined: true,
                ),

                // Mensagem de Erro
                ListenableBuilder(
                  listenable: controller,
                  builder: (context, _) {
                    if (controller.errorMessage != null) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Text(
                          controller.errorMessage!,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      );
                    }
                    return const SizedBox(height: 24);
                  },
                ),

                // Botão Salvar
                ListenableBuilder(
                  listenable: controller,
                  builder: (context, _) {
                    return ButtomGeneric(
                      label: "Salvar Alterações",
                      isLoading: controller.isLoading,
                      backgroundColor: AppTheme.colorButtons,
                      onPressed: () {
                        controller.saveChanges(
                          onSuccess: () {
                            Navigator.pop(context); // Fecha o BottomSheet
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) =>
                                  const SuccessFeedbackDialog(
                                title: "Dados Atualizados!",
                                subtitle:
                                    "As informações foram salvas com sucesso.",
                              ),
                            );
                            Future.delayed(const Duration(seconds: 2), () {
                              if (context.mounted)
                                Navigator.pop(context); // Fecha Dialog
                            });
                          },
                          onError: (msg) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(msg),
                                  backgroundColor: Colors.red),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}