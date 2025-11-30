import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';

class InstitutionCards extends StatelessWidget {
  final String name;
  final String address;
  final VoidCallback onTap;

  const InstitutionCards({
    super.key,
    required this.name,
    required this.address,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppTheme.colorWhiteText,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Color(0x1B000000),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFFE8F0FE),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.business, color: AppTheme.primaryBlue),
        ),
        title: Text(
          name,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        subtitle: Text(
          address,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppTheme.colorGrayText),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: AppTheme.colorGrayText,
        ),
        onTap: onTap,
      ),
    );
  }
}
