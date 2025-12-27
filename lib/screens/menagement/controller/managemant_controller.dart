import 'package:flutter/material.dart';
import 'package:vektor_if/models/data/insitution_repository.dart';
import 'package:vektor_if/models/institution_model.dart';

class ManagementController extends ChangeNotifier {
  final InstitutionRepository _repository = InstitutionRepository();
  
  // Controllers de Texto para os campos da tela
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  
  bool isLoading = true; // Começa carregando
  String? errorMessage;

  // Carrega os dados assim que a tela abre
  Future<void> loadInstitutionData() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final institution = await _repository.getMyInstitution();
      
      if (institution != null) {
        nameController.text = institution.name;
        addressController.text = institution.address;
      } else {
        errorMessage = "Dados da instituição não encontrados.";
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Salva as alterações
  Future<void> saveChanges({
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) async {
    if (nameController.text.isEmpty || addressController.text.isEmpty) {
      onError("Preencha todos os campos.");
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      final updatedModel = InstitutionModel(
        name: nameController.text.trim(),
        address: addressController.text.trim(),
      );

      await _repository.updateInstitution(updatedModel);
      onSuccess();
    } catch (e) {
      onError("Erro ao atualizar: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}