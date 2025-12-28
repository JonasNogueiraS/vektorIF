import 'package:flutter/material.dart';
import 'package:vektor_if/models/colaborators_model.dart';
import 'package:vektor_if/models/data/colaborators_repository.dart';
import 'package:vektor_if/models/sectors_model.dart';
import 'package:vektor_if/models/data/sectors_repository.dart';

class CollaboratorsController extends ChangeNotifier {
  final _repository = CollaboratorRepository();
  final _sectorsRepository = SectorsRepository(); // Repo de Setores

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  //Dropdown
  List<SectorModel> availableSectors = [];
  SectorModel? selectedSector; // Agora guardamos o objeto inteiro do setor
  bool isLoadingSectors = true;

  bool isBoss = false;
  bool isSaving = false;

  // Carrega os setores ao iniciar (initState da view)
  Future<void> loadSectors() async {
    isLoadingSectors = true;
    notifyListeners();

    try {
      // Pega o stream e transforma em future (primeira leva de dados)
      // ou apenas ouve. Para simplificar o dropdown, vamos pegar 'first'.
      final sectors = await _sectorsRepository.getSectorsStream().first;
      availableSectors = sectors;
    } catch (e) {
      print("Erro ao carregar setores: $e");
    } finally {
      isLoadingSectors = false;
      notifyListeners();
    }
  }

  void setSector(SectorModel? value) {
    selectedSector = value;
    notifyListeners();
  }

  void toggleBoss(bool? value) {
    isBoss = value ?? false;
    notifyListeners();
  }

  Future<void> saveEmployee({
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) async {
    //Validações
    if (nameController.text.isEmpty) {
      onError("Nome é obrigatório.");
      return;
    }
    if (selectedSector == null) {
      onError("Selecione um setor.");
      return;
    }

    isSaving = true;
    notifyListeners();

    try {
      //modelo com dados do setor selecionado
      final newColab = CollaboratorModel(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        sectorId: selectedSector!.id!, // id do setor
        sectorName: selectedSector!.name, // nome do setor
        isBoss: isBoss,
      );

      await _repository.addCollaborator(newColab);
      onSuccess();
    } catch (e) {
      onError("Erro ao salvar: $e");
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
    super.dispose();
  }
}
