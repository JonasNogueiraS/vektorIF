import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vektor_if/models/sectors_model.dart';
import 'package:vektor_if/models/data/sectors_repository.dart';

class SectorModal extends StatelessWidget {
  final Function(SectorModel) onSectorSelected;
  final _repository = SectorsRepository();

  SectorModal({super.key, required this.onSectorSelected});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Indicador visual de "arrastar"
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          Text(
            "Selecione o Setor",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          
          Flexible(
            child: userId == null 
            ? const Center(child: Text("Erro: Usuário não logado"))
            : StreamBuilder<List<SectorModel>>(
              stream: _repository.getSectorsStream(userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text("Nenhum setor cadastrado."),
                    ),
                  );
                }

                final allSectors = snapshot.data!;
                // Se o setor aparecer 5 vezes (5 pinos), pegamos apenas o primeiro para exibir na lista.
                final uniqueSectorsMap = {
                  for (var sector in allSectors) sector.id: sector
                };
                final uniqueSectorsList = uniqueSectorsMap.values.toList();
                // -------------------------------------

                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: uniqueSectorsList.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (_, index) {
                    final sector = uniqueSectorsList[index];
                    // Contagem de quantas vezes esse setor já foi marcado (Opcional, mas útil)
                    final count = allSectors.where((s) => s.id == sector.id && s.mapX != null).length;

                    return ListTile(
                      title: Text(sector.name),
                      subtitle: count > 0 
                          ? Text("$count marcação(ões) no mapa", style: const TextStyle(fontSize: 12, color: Colors.green)) 
                          : const Text("Toque para adicionar", style: TextStyle(fontSize: 12, color: Colors.grey)),
                      trailing: const Icon(Icons.add_location_alt_outlined, color: Colors.blue),
                      onTap: () {
                        onSectorSelected(sector);
                        Navigator.pop(context);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}