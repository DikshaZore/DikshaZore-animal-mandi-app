class Animal {
  final String id;
  final String type;
  final String breed;
  final int age;
  final String gender;
  final double price;
  final bool negotiable;
  final String description;
  final List<String> imageUrls;
  final String city;
  final String state;
  final double? latitude;
  final double? longitude;
  final String sellerId;
  final String sellerName;
  final double? sellerRating;
  final bool vaccinated;
  final bool vetChecked;
  final bool featured;
  final bool sold;
  final DateTime createdAt;

  Animal({
    required this.id,
    required this.type,
    required this.breed,
    required this.age,
    required this.gender,
    required this.price,
    required this.negotiable,
    required this.description,
    required this.imageUrls,
    required this.city,
    required this.state,
    this.latitude,
    this.longitude,
    required this.sellerId,
    required this.sellerName,
    this.sellerRating,
    required this.vaccinated,
    required this.vetChecked,
    this.featured = false,
    this.sold = false,
    required this.createdAt,
  });

  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
      id: json['id'] ?? '',
      type: json['type'] ?? '',
      breed: json['breed'] ?? '',
      age: json['age'] ?? 0,
      gender: json['gender'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      negotiable: json['negotiable'] ?? false,
      description: json['description'] ?? '',
      imageUrls: List<String>.from(json['imageUrls'] ?? []),
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      sellerId: json['sellerId'] ?? '',
      sellerName: json['sellerName'] ?? '',
      sellerRating: (json['sellerRating'] as num?)?.toDouble(),
      vaccinated: json['vaccinated'] ?? false,
      vetChecked: json['vetChecked'] ?? false,
      featured: json['featured'] ?? false,
      sold: json['sold'] ?? false,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }
}