import 'package:flutter/material.dart';
import 'package:vektor_if/models/sectors_model.dart';
import 'package:vektor_if/models/data/sectors_repository.dart';

class SectorModal extends StatelessWidget {
  // SectorModel
  final Function(SectorModel) onSectorSelected;
  // Instância do repositório
  final _repository = SectorsRepository();

  SectorModal({super.key, required this.onSectorSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Selecione o Setor",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          
          Flexible(
            child: StreamBuilder<List<SectorModel>>(
              stream: _repository.getSectorsStream(),
              builder: (context, snapshot) {
                // Carregando
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                //Erro ou Vazio
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text("Nenhum setor cadastrado."),
                    ),
                  );
                }

                final sectors = snapshot.data!;

                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: sectors.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (_, index) {
                    final sector = sectors[index];
                    
                    // Verifica se já foi mapeado (tem X e Y)
                    final isMapped = sector.mapX != null; 

                    return ListTile(
                      title: Text(sector.name),
                      // Mostra um aviso se já estiver no mapa
                      subtitle: isMapped 
                          ? const Text("Já posicionado no mapa", style: TextStyle(fontSize: 10, color: Colors.green)) 
                          : null,
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        // Retorna o OBJETO SectorModel inteiro
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