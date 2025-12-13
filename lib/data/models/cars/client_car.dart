import 'package:partsflow/data/abstract_models/cars/car.dart';
import 'package:partsflow/data/abstract_models/cars/client_car.dart';
import 'package:partsflow/data/models/cars/brand.dart';
import 'package:partsflow/data/models/cars/car.dart';

class ClientCarModel extends ClientCar<int> {
  @override
  final int id;
  @override
  final String? plate;
  @override
  final String? vin;
  @override
  final String? motorNumber;
  @override
  final String country;
  @override
  final int? car;
  @override
  final String? name;
  @override
  final String? fullName;
  @override
  final String createdAt;
  @override
  final String updatedAt;

  ClientCarModel({
    required this.id,
    this.plate,
    this.vin,
    this.motorNumber,
    required this.country,
    this.car,
    this.name,
    this.fullName,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  String toString() {
    return 'ClientCarModel(id: $id, plate: $plate, vin: $vin, motorNumber: $motorNumber, country: $country, car: $car, name: $name, fullName: $fullName, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory ClientCarModel.fromJson(Map<String, dynamic> data) {
    return ClientCarModel(
      id: data['id'] as int,
      plate: data['plate'] as String?,
      vin: data['vin'] as String?,
      motorNumber: data['motor_number'] as String?,
      country: data['country'],
      car: data['car'] as int?,
      name: data['name'] as String?,
      fullName: data['full_name'] as String?,
      createdAt: data['created_at'] as String,
      updatedAt: data['updated_at'] as String,
    );
  }
}

class ClientCarSimpleCar extends ClientCarModel {
  final Car? carDetails;

  final String? infoSource;
  final String? editionForSubsidiary;

  ClientCarSimpleCar({
    this.carDetails,
    required super.id,
    super.plate,
    super.vin,
    super.motorNumber,
    required super.country,
    required super.car,
    super.name,
    super.fullName,
    required super.createdAt,
    required super.updatedAt,
    this.infoSource,
    this.editionForSubsidiary,
  });

  factory ClientCarSimpleCar.fromJson(Map<String, dynamic> data) {
    final carDetails = CarModel.fromJson(data['car']);

    data.remove("car");

    final baseClientCar = ClientCarModel.fromJson(data);

    return ClientCarSimpleCar(
      id: baseClientCar.id,
      plate: baseClientCar.plate,
      vin: baseClientCar.vin,
      motorNumber: baseClientCar.motorNumber,
      country: baseClientCar.country,
      car: carDetails.id,
      carDetails: carDetails,
      name: baseClientCar.name,
      fullName: baseClientCar.fullName,
      createdAt: baseClientCar.createdAt,
      updatedAt: baseClientCar.updatedAt,
    );
  }
}

class ClientCarCarModel extends ClientCar<Car<int>> {
  @override
  final int id;
  @override
  final String? plate;
  @override
  final String? vin;
  @override
  final String? motorNumber;
  @override
  final String country;
  @override
  final Car<int>? car;
  @override
  final String? name;
  @override
  final String? fullName;
  @override
  final String createdAt;
  @override
  final String updatedAt;

  ClientCarCarModel({
    required this.id,
    this.plate,
    this.vin,
    this.motorNumber,
    required this.country,
    this.name,
    this.fullName,
    this.car,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ClientCarCarModel.fromJson(Map<String, dynamic> data) {
    Car<int>? car;
    var carData = data["car"];

    if (carData != null) {
      car = CarModel<int>.fromJson(carData);
    }

    return ClientCarCarModel(
      id: data["id"],
      plate: data["plate"],
      vin: data["vin"],
      motorNumber: data["motor_number"],
      country: data["country"],
      name: data["name"],
      car: car,
      fullName: data["ful_name"],
      createdAt: data["created_at"],
      updatedAt: data["updated_at"],
    );
  }

  @override
  String toString() {
    return 'ClientCarCarModel(id: $id, plate: $plate, vin: $vin, motorNumber: $motorNumber, country: $country, carDetails: ${car.toString()}, name: $name, fullName: $fullName, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

