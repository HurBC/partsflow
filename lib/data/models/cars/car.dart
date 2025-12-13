import 'package:partsflow/data/abstract_models/cars/brand.dart';
import 'package:partsflow/data/abstract_models/cars/car.dart';
import 'package:partsflow/data/models/cars/brand.dart';

class SimpleCar {
  final int id;
  final String? name;

  SimpleCar({required this.id, required this.name});

  factory SimpleCar.fromJson(Map<String, dynamic> json) =>
      SimpleCar(id: json["id"] as int, name: json["name"] as String?);
}

class CarModel<BrandType> extends Car<BrandType> {
  @override
  final int id;
  @override
  final String model;
  @override
  final String? version;
  @override
  final String? displacement;
  @override
  final String? manufacturer;
  @override
  final String? firstMotorNumbers;
  @override
  final String? originCountry;
  @override
  final String? originalModel;
  @override
  final int year;
  @override
  final BrandType? brand;

  CarModel({
    required this.id,
    required this.model,
    this.version,
    this.displacement,
    this.manufacturer,
    this.firstMotorNumbers,
    this.originCountry,
    this.originalModel,
    required this.year,
    this.brand
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    final rawBrandData = json["brand"];

    BrandType? parsedBrand;

    if (BrandType == int) {
      if (BrandType is int) {
        parsedBrand = rawBrandData as BrandType;
      } else if (BrandType is Map) {
        parsedBrand = rawBrandData["id"] as BrandType;
      }
    } else if (BrandType == Brand) {
      parsedBrand = BrandModel.fromJson(rawBrandData) as BrandType;
    }


    return CarModel(
      id: json["id"],
      model: json["model"],
      version: json["version"],
      displacement: json["displacement"],
      manufacturer: json["manufacturer"],
      firstMotorNumbers: json["first_motor_numbers"],
      originCountry: json["origin_country"],
      originalModel: json["original_model"],
      year: json["year"],
      brand: parsedBrand
    );
  }
}
