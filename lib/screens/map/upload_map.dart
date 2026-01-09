import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/core/themes/size_extensions.dart';
import 'package:vektor_if/core/widgets/background_image.dart';
import 'package:vektor_if/core/widgets/buttom_generic.dart';
import 'package:vektor_if/core/widgets/custom_back_button.dart';
import 'package:vektor_if/core/widgets/success_feedback_dialog.dart';
import 'package:vektor_if/models/data/map_repository.dart';
import 'package:vektor_if/screens/map/widget/upload_section.dart';

//CONTROLLER LOCAL 
class UploadMapController extends ChangeNotifier {
  final _repository = MapRepository();
  final _picker = ImagePicker();

  File? selectedImage;
  bool isLoading = false;

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage = File(image.path);
      notifyListeners();
    }
  }

  // NOVO: Limpa a seleção
  void clearSelection() {
    selectedImage = null;
    notifyListeners();
  }

  Future<void> saveMap({required VoidCallback onSuccess, required Function(String) onError}) async {
    if (selectedImage == null) {
      onError("Por favor, selecione uma imagem primeiro.");
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      await _repository.uploadMapImage(selectedImage!);
      onSuccess();
    } catch (e) {
      onError(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

//TELA 
class UploadMapScreen extends StatefulWidget {
  const UploadMapScreen({super.key});

  @override
  State<UploadMapScreen> createState() => _UploadMapScreenState();
}

class _UploadMapScreenState extends State<UploadMapScreen> {
  final _controller = UploadMapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorBackground,
      body: Stack(
        children: [
          const BackgroundImage(),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.percentWidth(0.05),
                  vertical: context.percentHeight(0.02),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 10),
                    // HEADER
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomBackButtom(),
                        Text(
                          "Gestão de Mapas",
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff49454F),
                              ),
                        ),
                        const SizedBox(width: 48), 
                      ],
                    ),

                    SizedBox(height: context.percentHeight(0.08)),

                    // CARD PRINCIPAL
                    Container(
                      padding: const EdgeInsets.all(24.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            "Envie Imagem",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // seleção e preview
                          ListenableBuilder(
                            listenable: _controller,
                            builder: (context, _) {
                              // Nenhuma imagem selecionada
                              if (_controller.selectedImage == null) {
                                return Column(
                                  children: [
                                     const Text(
                                      "Escolha um arquivo para enviar",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 14, color: Colors.grey),
                                    ),
                                    const SizedBox(height: 20),
                                    UploadSection(
                                      onTap: () {
                                        _controller.pickImage();
                                      },
                                    ),
                                  ],
                                );
                              } 
                              
                              //Imagem selecionada
                              else {
                                return Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    // Miniatura
                                    Container(
                                      height: 250, // Altura fixa
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(color: AppTheme.colorLogo.withValues(alpha: 0.3)),
                                        image: DecorationImage(
                                          image: FileImage(_controller.selectedImage!),
                                          fit: BoxFit.cover, 
                                        )
                                      ),
                                    ),
                                    
                                    // Botão de Remover
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () => _controller.clearSelection(),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.red.withValues(alpha: 0.9),
                                          radius: 18,
                                          child: const Icon(Icons.close, color: Colors.white, size: 20),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                            }
                          ),

                          const SizedBox(height: 30),

                          // Botão Salvar
                          ListenableBuilder(
                            listenable: _controller,
                            builder: (context, _) {
                              return ButtomGeneric(
                                label: "Salvar e Continuar",
                                isLoading: _controller.isLoading,
                                // Só habilita o botão se tiver imagem
                                onPressed: _controller.selectedImage == null ? null : () {
                                  _controller.saveMap(
                                    onSuccess: () {
                                       showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) => const SuccessFeedbackDialog(
                                          title: "Mapa Enviado!",
                                          subtitle: "Vamos agora marcar os setores.",
                                        ),
                                      );
                                      
                                      Future.delayed(const Duration(seconds: 2), () {
                                        if (context.mounted) {
                                          Navigator.pop(context);
                                          Navigator.pushReplacementNamed(context, '/map-editor');
                                        }
                                      });
                                    },
                                    onError: (msg) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(msg), backgroundColor: Colors.red),
                                      );
                                    }
                                  );
                                },
                              );
                            }
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}