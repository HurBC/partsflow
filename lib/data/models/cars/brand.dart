import 'package:partsflow/data/abstract_models/cars/brand.dart';

class BrandModel extends Brand {
  @override
  final int id;
  @override
  final String name;
  @override
  final String country;
  @override
  bool? isLightVehicle;
  @override
  String? createdAt;
  @override
  String? updatedAt;

  BrandModel({
    required this.id,
    required this.name,
    required this.country,
    required this.isLightVehicle,
    this.createdAt,
    this.updatedAt,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) => BrandModel(
    id: json["id"],
    name: json["name"],
    country: json["country"],
    isLightVehicle: json["is_light_vehicle"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );
}
