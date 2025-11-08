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
  final String model;
  final String? version;
  final String? displacement;
  final String? manufacturer;
  final String? firstMotorNumbers;
  final String? originCountry;
  final String? originalModel;
  final int year;

  CarRespository({
    required this.id,
    required this.model,
    this.version,
    this.displacement,
    this.manufacturer,
    this.firstMotorNumbers,
    this.originCountry,
    this.originalModel,
    required this.year,
  });

  factory CarRespository.fromJson(Map<String, dynamic> json) {

    return CarRespository(
      id: json["id"],
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

class CarWithoutBrandRespository extends CarRespository {
  final int? brand;

  CarWithoutBrandRespository({
    required this.brand,
    required super.id,
    required super.model,
    super.version,
    super.displacement,
    super.manufacturer,
    super.firstMotorNumbers,
    super.originCountry,
    super.originalModel,
    required super.year,
  });

  factory CarWithoutBrandRespository.fromJson(Map<String, dynamic> json) {
    CarRespository baseCar = CarRespository.fromJson(json);

    return CarWithoutBrandRespository(
      id: baseCar.id,
      brand: json["brand"],
      model: baseCar.model,
      version: baseCar.version,
      displacement: baseCar.displacement,
      manufacturer: baseCar.manufacturer,
      firstMotorNumbers: baseCar.firstMotorNumbers,
      originCountry: baseCar.originCountry,
      originalModel: baseCar.originalModel,
      year: baseCar.year,
    );
  }
}

class CarWithBrandRespository extends CarRespository {
  final Brand brand;

  CarWithBrandRespository({
    required this.brand,
    required super.id,
    required super.model,
    super.version,
    super.displacement,
    super.manufacturer,
    super.firstMotorNumbers,
    super.originCountry,
    super.originalModel,
    required super.year,
  });

  factory CarWithBrandRespository.fromJson(Map<String, dynamic> json) {
    var brand = Brand.fromJson(json["brand"]);

    json.remove("brand");

    CarRespository baseCar = CarRespository.fromJson(json);

    return CarWithBrandRespository(
      id: baseCar.id,
      brand: brand,
      model: baseCar.model,
      version: baseCar.version,
      displacement: baseCar.displacement,
      manufacturer: baseCar.manufacturer,
      firstMotorNumbers: baseCar.firstMotorNumbers,
      originCountry: baseCar.originCountry,
      originalModel: baseCar.originalModel,
      year: baseCar.year,
    );
  }
}
