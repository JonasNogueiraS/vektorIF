class CollaboratorModel {
  final String? id;
  final String name;
  final String email;
  final String phone;
  final String sectorId; // Vínculo com o setor
  final String sectorName; // Para facilitar a exibição nas listas
  final bool isBoss;
  final String? photoUrl; // Futuro

  CollaboratorModel({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.sectorId,
    required this.sectorName,
    required this.isBoss,
    this.photoUrl,
  });

  // Converte do Firebase
  factory CollaboratorModel.fromMap(Map<String, dynamic> map, String docId) {
    return CollaboratorModel(
      id: docId,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      sectorId: map['sectorId'] ?? '',
      sectorName: map['sectorName'] ?? '',
      isBoss: map['isBoss'] ?? false,
      photoUrl: map['photoUrl'],
    );
  }

  // Converte para o Firebase
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'sectorId': sectorId,
      'sectorName': sectorName,
      'isBoss': isBoss,
      if (photoUrl != null) 'photoUrl': photoUrl,
    };
  }
}