import 'package:flutter/material.dart';

class ManagementOptionsList extends StatelessWidget {

  final VoidCallback onSectorsTap;
  final VoidCallback onColabTap;
  final VoidCallback onMapTap;

  const ManagementOptionsList({
    super.key,
    required this.onSectorsTap,
    required this.onColabTap,
    required this.onMapTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildListItem(
            title: "Gestão De Setores",
            subtitle: "Consulte, adicione e remova setores",
            icon: Icons.domain,
            onTap: onSectorsTap,
          ),
          _buildDivider(),
          _buildListItem(
            title: "Gestão De Pessoa",
            subtitle: "Consulte, cadastre ou remova colaboradores",
            icon: Icons.people_alt_outlined,
            onTap: onColabTap,
          ),
          _buildDivider(),
          _buildListItem(
            title: "Gestão De Mapa",
            subtitle: "Upload e ajuste de planta baixa",
            icon: Icons.map_outlined,
            onTap: onMapTap,
          ),
        ],
      ),
    );
  }

  Widget _buildListItem({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.blue),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.grey.shade100,
      indent: 70, // Alinhamento
    );
  }
}