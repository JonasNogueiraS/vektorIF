import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vektor_if/models/colaborators_model.dart';
import 'package:vektor_if/models/sectors_model.dart';
import 'package:vektor_if/providers/auth_provider.dart';
import 'package:vektor_if/providers/collaborator_provider.dart';

class CollaboratorsController extends ChangeNotifier {
  // Inputs
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  // Estado
  bool isBoss = false;
  SectorModel? selectedSector;
  bool isSaving = false;

  String? _editingId;
  bool get isEditing => _editingId != null;

  void loadDataForEditing(CollaboratorModel colab, List<SectorModel> allSectors) {
    _editingId = colab.id;
    nameController.text = colab.name;
    emailController.text = colab.email;
    phoneController.text = colab.phone;
    isBoss = colab.isBoss;

    // Encontrar o setor correto na lista para o Dropdown funcionar
    try {
      selectedSector = allSectors.firstWhere((s) => s.id == colab.sectorId);
    } catch (e) {
      print("Setor do colaborador não encontrado na lista atual");
      selectedSector = null;
    }
    notifyListeners();
  }
  
  // Ações de UI
  void toggleBoss(bool? value) {
    isBoss = value ?? false;
    notifyListeners();
  }

  void setSector(SectorModel? sector) {
    selectedSector = sector;
    notifyListeners();
  }

  // Salvar
  Future<void> saveEmployee(
    BuildContext context, {
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) async {
    //Validação Local
    if (nameController.text.isEmpty) {
      onError("O nome é obrigatório.");
      return;
    }
    if (selectedSector == null) {
      onError("Selecione um setor.");
      return;
    }

    isSaving = true;
    notifyListeners();

    try {
      final user = context.read<AuthProvider>().user;
      if (user == null) throw Exception("Usuário não identificado");

      final newCollaborator = CollaboratorModel(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        sectorId: selectedSector!.id!, // ID garantido
        sectorName: selectedSector!.name,
        isBoss: isBoss,
      );

      // Chama o Provider para salvar
      await context.read<CollaboratorProvider>().addCollaborator(
        institutionId: user.uid,
        collaborator: newCollaborator,
      );

      _clearForm();
      onSuccess();
    } catch (e) {
      onError("Erro ao salvar: $e");
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

  void _clearForm() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    isBoss = false;
    selectedSector = null;
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
