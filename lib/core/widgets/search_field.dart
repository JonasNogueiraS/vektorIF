import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';

class SearchField extends StatelessWidget {
  final Function(String) onSearchChanged;
  final VoidCallback onFilterTap;
  final String hintText;

  const SearchField({
    super.key,
    required this.onSearchChanged,
    required this.onFilterTap,
    this.hintText = "Pesquisar...",
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              onChanged: onSearchChanged,
              decoration: InputDecoration(
                hintText: hintText,
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.colorLogo,
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onPressed: onFilterTap,
          ),
        ),
      ],
    );
  }
}
