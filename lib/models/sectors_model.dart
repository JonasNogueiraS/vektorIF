class SectorModel {
  final String? id;
  final String name;
  final String category;
  final String? description;
  final String? email;
  final String? phone;
  
  //cada pino tem uma posição única
  final double? mapX;
  final double? mapY;

  SectorModel({
    this.id,
    required this.name,
    required this.category,
    this.description,
    this.email,
    this.phone,
    this.mapX,
    this.mapY,
  });

  // Converte para Map (Banco de Dados)
  // ATENÇÃO: Aqui não salvamos mapX/mapY soltos, quem salva a lista é o Repository
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'description': description,
      'email': email,
      'phone': phone,
      // mapX e mapY não entram aqui pois são salvos separadamente como lista
    };
  }

  // Cria a partir do Banco
  // O banco pode ter um campo 'coordinates' que é uma lista de Maps: [{'x':10, 'y':20}, ...]
  // Mas para facilitar, este método cria um modelo "base". 
  // A lógica de criar múltiplos modelos (um para cada ponto) ficará no Repository ou no Editor.
  factory SectorModel.fromMap(Map<String, dynamic> map, String id) {
    return SectorModel(
      id: id,
      name: map['name'] ?? '',
      category: map['category'] ?? '',
      description: map['description'],
      email: map['email'],
      phone: map['phone'],
      mapX: map['mapX'],
      mapY: map['mapY'],
    );
  }

  // Método auxiliar para criar cópia com novas coordenadas
  SectorModel copyWith({double? mapX, double? mapY}) {
    return SectorModel(
      id: id,
      name: name,
      category: category,
      description: description,
      email: email,
      phone: phone,
      mapX: mapX ?? this.mapX,
      mapY: mapY ?? this.mapY,
    );
  }
}