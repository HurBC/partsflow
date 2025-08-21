class SimpleCar {
  final int id;
  final String? name;

  SimpleCar({required this.id, required this.name});

  factory SimpleCar.fromJson(Map<String, dynamic> json) =>
      SimpleCar(id: json["id"] as int, name: json["name"] as String?);
}
