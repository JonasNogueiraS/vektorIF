import 'package:flutter/material.dart';
import '../../../../core/themes/app_theme.dart';

class FilterList extends StatelessWidget {
  final List<String> filters;
  final String selectedFilter;
  final Function(String) onFilterSelected;

  const FilterList({
    super.key,
    required this.filters,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: filters.map((filter) {
            final isSelected = selectedFilter == filter;
            return Padding(
              padding: const EdgeInsets.only(right: 6),
              child: ChoiceChip(
                label: Text(filter),
                selected: isSelected,
                onSelected: (bool selected) {
                  onFilterSelected(filter); // chama o pai
                },
                visualDensity: VisualDensity.compact,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                selectedColor: AppTheme.primaryBlue,
                backgroundColor: const Color(0xffD8E7FF),
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : const Color(0xff006FFD),
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width < 360 ? 10 : 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(
                    color: isSelected ? Colors.transparent : AppTheme.primaryBlue,
                  ),
                ),
                showCheckmark: false,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}