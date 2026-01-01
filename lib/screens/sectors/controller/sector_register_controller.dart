import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vektor_if/models/sectors_model.dart';
import 'package:vektor_if/providers/auth_provider.dart';
import 'package:vektor_if/providers/sector_provider.dart';

class SectorRegisterController extends ChangeNotifier {
  // Inputs
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final descriptionController = TextEditingController();

  // Estados de UI
  String? selectedCategory;
  final List<String> categories = [
    "Laboratório",
    "Administrativo",
    "Técnico",
    "Utilidades",
  ];

  bool noEmail = false;
  bool noPhone = false;
  bool isSaving = false;

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

  // Ação de Salvar
  Future<void> saveSector(
    BuildContext context, {
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) async {
    // 1. Validações Locais
    if (nameController.text.isEmpty) {
      onError("O nome do setor é obrigatório.");
      return;
    }
    if (selectedCategory == null) {
      onError("Selecione a categoria do setor.");
      return;
    }

    // 2. Preparação
    isSaving = true;
    notifyListeners();

    try {
      // Pega o UID do usuário logado através do AuthProvider
      final user = context.read<AuthProvider>().user;
      if (user == null) throw Exception("Usuário não identificado.");

      // Cria o modelo
      final newSector = SectorModel(
        name: nameController.text.trim(),
        category: selectedCategory!,
        email: noEmail ? null : emailController.text.trim(),
        phone: noPhone ? null : phoneController.text.trim(),
        description: descriptionController.text.trim(),
      );

      // 3. Chama o SectorProvider para salvar no banco
      await context.read<SectorProvider>().addSector(
        institutionId: user.uid,
        sector: newSector,
      );

      onSuccess();
    } catch (e) {
      onError(e.toString());
    } finally {
      isSaving = false;
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
