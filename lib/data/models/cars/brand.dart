class Brand {
  final int id;
  final String name;
  final String country;
  final String? createdAt;
  final String? updatedAt;

  Brand({
    required this.id,
    required this.name,
    required this.country,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    id: json["id"],
    name: json["name"],
    country: json["country"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
  );
}
