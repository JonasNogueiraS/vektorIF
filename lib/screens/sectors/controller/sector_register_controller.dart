import 'package:flutter/material.dart';
import 'package:vektor_if/models/sectors_model.dart';
import 'package:vektor_if/models/data/sectors_repository.dart';

class SectorRegisterController extends ChangeNotifier {
  final _repository = SectorsRepository();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final descriptionController = TextEditingController();

  //
  String? selectedCategory;
  final List<String> categories = [
    "Laboratório",
    "Administrativo",
    "Técnico",
    "Utilidades"
  ];

  bool noEmail = false;
  bool noPhone = false;
  bool isLoading = false;

  // SETTER DA CATEGORIA 
  void setCategory(String? value) {
    selectedCategory = value;
    notifyListeners();
  }

  void toggleNoEmail(bool? value) {
    noEmail = value ?? false;
    if (noEmail) emailController.clear();
    notifyListeners();
  }

  void toggleNoPhone(bool? value) {
    noPhone = value ?? false;
    if (noPhone) phoneController.clear();
    notifyListeners();
  }

  Future<void> saveSector({
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) async {
    // Validação
    if (nameController.text.isEmpty) {
      onError("O nome do setor é obrigatório.");
      return;
    }
    // Validação da Categoria
    if (selectedCategory == null) {
      onError("Selecione a categoria do setor.");
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      final newSector = SectorModel(
        name: nameController.text.trim(),
        category: selectedCategory!, 
        email: noEmail ? null : emailController.text.trim(),
        phone: noPhone ? null : phoneController.text.trim(),
        description: descriptionController.text.trim(),
      );

      await _repository.addSector(newSector);
      
      onSuccess();
      
    } catch (e) {
      onError("Erro ao salvar: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}