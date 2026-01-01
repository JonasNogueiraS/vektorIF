class SectorModel {
  final String? id;
  final String name;
  final String category;
  final String? description;
  final String? email;
  final String? phone;

  // Coordenadas (opcionais na criação)
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

  // Converte para Map (Salvar no Firebase)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'description': description,
      'email': email,
      'phone': phone,
      // Nota: mapX e mapY geralmente são salvos via editor de mapa,
      // mas se quiser salvar na criação, pode descomentar:
      // 'mapX': mapX,
      // 'mapY': mapY,
    };
  }

  // Cria a partir do Map (Ler do Firebase)
  factory SectorModel.fromMap(Map<String, dynamic> map, String id) {
    return SectorModel(
      id: id,
      name: map['name'] ?? '',
      category: map['category'] ?? 'Geral',
      description: map['description'],
      email: map['email'],
      phone: map['phone'],
      // Converte para double com segurança
      mapX: (map['mapX'] as num?)?.toDouble(),
      mapY: (map['mapY'] as num?)?.toDouble(),
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
