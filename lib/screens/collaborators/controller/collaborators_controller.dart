import 'package:flutter/widgets.dart';

class CollaboratorsController extends ChangeNotifier {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  String? selectedSector;
  bool isBoss = false;

  final List<String> availableSectors = [
    'Coorenação de TI',
    'Recursos Humanos',
    'Secretaria Acadêmica',
    'Direção Geral',
  ];

  void setSector(String? value) {
    selectedSector = value;
    notifyListeners();
  }

  void toggleBoss(bool? value) {
    isBoss = value ?? false;
    notifyListeners();
  }

  void saveEmployee(){
    print("Salvar Colaborador: ${nameController.text}");
    print("Setor: $selectedSector");
    print("É chefe: $isBoss");
  }

  void dispose(){
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose(); //bom para limpar controllers
  }
}
