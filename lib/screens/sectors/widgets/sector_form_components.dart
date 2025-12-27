import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/core/widgets/forms_widgets.dart';

// Inputs que podem ser desativados
class ToggleableContactInput extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool isDisabled;
  final Function(bool?) onToggle;
  final String checkboxLabel;
  final TextInputType keyboardType;

  const ToggleableContactInput({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.isDisabled,
    required this.onToggle,
    required this.checkboxLabel,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormLabel(label),
        GenericInputField(
          controller: controller,
          hint: hint,
          enabled: !isDisabled,
          keyboardType: keyboardType,
        ),
        Row(
          children: [
            Checkbox(
              value: isDisabled,
              activeColor: AppTheme.colorLogo,
              onChanged: onToggle,
            ),
            Text(
              checkboxLabel,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }
}

//Dropdown de Categoria
class SectorCategoryDropdown extends StatelessWidget {
  final String? selectedCategory;
  final List<String> categories;
  final Function(String?) onChanged;

  const SectorCategoryDropdown({
    super.key,
    required this.selectedCategory,
    required this.categories,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormLabel("Categoria"),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xffF2F2F2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedCategory,
              hint: const Text(
                "Selecione o tipo...",
                style: TextStyle(color: Color(0xff49454F), fontSize: 14),
              ),
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down),
              items: categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}