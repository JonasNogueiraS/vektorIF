import 'package:flutter/material.dart';

class SectorModal extends StatelessWidget {
  final Function(String) onSectorSelected;

  final List<String> _sectors = const [
    "Secretaria",
    "Coordenação TI",
    "Biblioteca",
    "Lab. Informática 1",
    "Auditório",
    "Sala dos Professores",
  ];

  const SectorModal({super.key, required this.onSectorSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Selecione o Setor",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: _sectors.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (_, index) => ListTile(
                title: Text(_sectors[index]),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // Retorna o setor selecionado e fecha o modal
                  onSectorSelected(_sectors[index]);
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}