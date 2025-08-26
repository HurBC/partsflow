import 'package:partsflow/data/models/cars/brand.dart';

class SimpleCar {
  final int id;
  final String? name;

  SimpleCar({required this.id, required this.name});

  factory SimpleCar.fromJson(Map<String, dynamic> json) =>
      SimpleCar(id: json["id"] as int, name: json["name"] as String?);
}

class CarRespository {
  final int id;
  final Brand brand;
  final String model;
  final String? version;
  final String displacement;
  final String? manufacturer;
  final String? firstMotorNumbers;
  final String? originCountry;
  final String? originalModel;
  final int year;

  CarRespository({
    required this.id,
    required this.brand,
    required this.model,
    this.version,
    required this.displacement,
    this.manufacturer,
    this.firstMotorNumbers,
    this.originCountry,
    this.originalModel,
    required this.year,
  });

  factory CarRespository.fromJson(Map<String, dynamic> json) {
    var brand = Brand.fromJson(json["brand"]);

    return CarRespository(
      id: json["id"],
      brand: brand,
      model: json["model"],
      version: json["version"],
      displacement: json["displacement"],
      manufacturer: json["manufacturer"],
      firstMotorNumbers: json["firstMotorNumbers"],
      originCountry: json["originCountry"],
      originalModel: json["originalModel"],
      year: json["year"],
    );
  }
}
