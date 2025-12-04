import 'package:flutter/material.dart';

class SectorRegisterController extends ChangeNotifier {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final descriptionController = TextEditingController();

  bool noEmail = false;
  bool noPhone = false;

  void toggleNoEmail(bool? value) {
    noEmail = value ?? false;

    if (noEmail) {
      emailController.clear();
    }

    notifyListeners();
  }

  void toggleNoPhone(bool? value) {
    noPhone = value ?? false;

    if (noPhone) {
      phoneController.clear();
    }

    notifyListeners();
  }

  void saveSector() {
    final data = {
      "name": nameController.text,
      "email": noEmail ? null : emailController.text,
      "phone": noPhone ? null : phoneController.text,
      "description": descriptionController.text,
    };
    print("Dados enviados: $data");
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
