class SectorModel {
  final String? id;
  final String name;
  final String category; 
  final String? email;
  final String? phone;
  final String description;

  const SectorModel({
    this.id,
    required this.name,
    required this.category, 
    this.email,
    this.phone,
    required this.description,
  });

  factory SectorModel.fromMap(Map<String, dynamic> map, String docId) {
    return SectorModel(
      id: docId,
      name: map['name'] ?? '',
      category: map['category'] ?? 'Administrativo', 
      email: map['email'],
      phone: map['phone'],
      description: map['description'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category, 
      'email': email,
      'phone': phone,
      'description': description,
    };
  }
}