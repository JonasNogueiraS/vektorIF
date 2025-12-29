import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vektor_if/models/colaborators_model.dart';
import 'package:vektor_if/models/data/colaborators_repository.dart';
import 'package:vektor_if/models/data/sectors_repository.dart';
import 'package:vektor_if/models/sectors_model.dart';

class CollaboratorsController extends ChangeNotifier {
  final _repository = CollaboratorRepository();
  final _sectorsRepository = SectorsRepository();

  // --- ESTADO DO FORMULÁRIO ---
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  
  bool isBoss = false;
  SectorModel? selectedSector;
  
  // --- ESTADO DE CARREGAMENTO ---
  bool isSaving = false;
  bool isLoadingSectors = false;
  List<SectorModel> availableSectors = [];

  // --- STREAMS (Para a tela de Listagem) ---
  Stream<List<CollaboratorModel>> get collaboratorsStream {
    return _repository.getCollaboratorsStream();
  }

  // --- MÉTODOS DE AÇÃO ---

  // 1. Carregar Setores para o Dropdown
  Future<void> loadSectors() async {
    isLoadingSectors = true;
    notifyListeners();

    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        // Pega a lista atual do stream
        final sectors = await _sectorsRepository.getSectorsStream(userId).first;
        availableSectors = sectors;
      }
    } catch (e) {
      debugPrint("Erro ao carregar setores: $e");
    } finally {
      isLoadingSectors = false;
      notifyListeners();
    }
  }

  // 2. Definir se é Chefe
  void toggleBoss(bool? value) {
    isBoss = value ?? false;
    notifyListeners();
  }

  // 3. Selecionar Setor
  void setSector(SectorModel? sector) {
    selectedSector = sector;
    notifyListeners();
  }

  // 4. Salvar Colaborador
  Future<void> saveEmployee({required VoidCallback onSuccess, required Function(String) onError}) async {
    // Validação Básica
    if (nameController.text.isEmpty || selectedSector == null) {
      onError("Preencha nome e setor.");
      return;
    }

    isSaving = true;
    notifyListeners();

    try {
      final newCollaborator = CollaboratorModel(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        sectorId: selectedSector!.id!, // ID do setor selecionado
        sectorName: selectedSector!.name, // Nome para facilitar exibição
        isBoss: isBoss,
      );

      await _repository.addCollaborator(newCollaborator);
      
      // Limpa o formulário após sucesso
      _clearForm();
      onSuccess();

    } catch (e) {
      onError(e.toString());
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

  // 5. Excluir (Para a tela de listagem)
  Future<void> deleteCollaborator(String id) async {
    try {
      await _repository.deleteCollaborator(id);
    } catch (e) {
      debugPrint("Erro ao excluir: $e");
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