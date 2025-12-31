class InstitutionModel {
  final String? id; // ID do documento no Firebase
  final String name;
  final String address;
  final String? photoUrl; // Para a foto

  const InstitutionModel({
    this.id,
    required this.name,
    required this.address,
    this.photoUrl,
  });

  // Converte do Firebase (Map) para o App (Objeto)
  factory InstitutionModel.fromMap(Map<String, dynamic> map, String docId) {
    return InstitutionModel(
      id: docId,
      name: map['institutionName'] ?? '', // usamos chaves que salvamos no registro
      address: map['institutionAddress'] ?? '',
      photoUrl: map['photoUrl'],
    );
  }

  // Converte do App (Objeto) para o Firebase (Map)
  Map<String, dynamic> toMap() {
    return {
      'institutionName': name,
      'institutionAddress': address,
      if (photoUrl != null) 'photoUrl': photoUrl,
    };
  }
}