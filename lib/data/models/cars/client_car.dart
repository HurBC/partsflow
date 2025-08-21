import 'package:partsflow/data/models/cars/car.dart';

class ClientCarRepository {
  final int id;
  final String? plate;
  final String? vin;
  final String? motorNumber;
  final String country;
  final int? car;
  final String? name;
  final String? fullName;
  final String createdAt;
  final String updatedAt;

  ClientCarRepository({
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
    return 'ClientCarRepository(id: $id, plate: $plate, vin: $vin, motorNumber: $motorNumber, country: $country, car: $car, name: $name, fullName: $fullName, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory ClientCarRepository.fromJson(Map<String, dynamic> data) {
    return ClientCarRepository(
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

class ClientCarSimpleCar extends ClientCarRepository {
  final SimpleCar simpleCar;

  ClientCarSimpleCar({
    required this.simpleCar,
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
  });

  factory ClientCarSimpleCar.fromJson(Map<String, dynamic> data) {
    final simpleCar = SimpleCar.fromJson(data['car']);

    data.remove("car");

    final baseClientCar = ClientCarRepository.fromJson(data);

    return ClientCarSimpleCar(
      id: baseClientCar.id,
      plate: baseClientCar.plate,
      vin: baseClientCar.vin,
      motorNumber: baseClientCar.motorNumber,
      country: baseClientCar.country,
      car: simpleCar.id,
      simpleCar: simpleCar,
      name: baseClientCar.name,
      fullName: baseClientCar.fullName,
      createdAt: baseClientCar.createdAt,
      updatedAt: baseClientCar.updatedAt,
    );
  }
}
