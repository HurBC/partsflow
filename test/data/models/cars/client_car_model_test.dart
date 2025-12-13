import 'package:flutter_test/flutter_test.dart';
import 'package:partsflow/data/models/cars/car.dart';
import 'package:partsflow/data/models/cars/client_car.dart';

void main() {
  group('ClientCarModel', () {
    const id = 1;
    const plate = 'ABC-123';
    const vin = 'VIN12345';
    const motorNumber = 'M123';
    const country = 'Chile';
    const carId = 50;
    const createdAt = '2023-01-01';
    const updatedAt = '2023-01-02';

    final baseJson = {
      'id': id,
      'plate': plate,
      'vin': vin,
      'motor_number': motorNumber,
      'country': country,
      'car': carId,
      'name': 'My Car',
      'full_name': 'My Car Full Name',
      'created_at': createdAt,
      'updated_at': updatedAt,
    };

    // Test 1: ClientCarModel fromJson
    test('ClientCarModel fromJson works', () {
      final model = ClientCarModel.fromJson(baseJson);
      expect(model.id, id);
      expect(model.plate, plate);
      expect(model.car, carId);
    });

    // Test 2: ClientCarSimpleCar fromJson (extends ClientCarModel, parses car details)
    test('ClientCarSimpleCar fromJson works', () {
      // Logic in fromJson of ClientCarSimpleCar:
      // final carDetails = CarModel.fromJson(data['car']);
      // data.remove("car");
      // final baseClientCar = ClientCarModel.fromJson(data);

      // We need to construct data such that 'car' is a Map (for CarModel)
      // AND also ClientCarModel expects 'car' to be int or null?
      // Wait, ClientCarModel.fromJson expects 'car' to be int?.
      // BUT ClientCarSimpleCar removes 'car' from map before calling base fromJson?
      // Yes: `data.remove("car")`.
      // The base `ClientCarModel.fromJson` will thus see `car` as null (since it's removed).
      // Let's verify `ClientCarSimpleCar` constructor passes `car: carDetails.id`.

      final carJson = {
        'id': 99,
        'model': 'Civic',
        'year': 2022,
        'brand': 10, // int ID generic
      };

      final complexJson = Map<String, dynamic>.from(baseJson);
      complexJson['car'] = carJson; // Replace int ID with object

      final simpleCar = ClientCarSimpleCar.fromJson(complexJson);

      expect(simpleCar.id, id);
      expect(simpleCar.carDetails, isNotNull);
      expect(simpleCar.carDetails!.model, 'Civic');
      expect(simpleCar.car, 99); // Should extract ID from car details
    });

    // Test 3: ClientCarCarModel fromJson
    test('ClientCarCarModel fromJson works', () {
      final carJson = {'id': 99, 'model': 'Civic', 'year': 2022, 'brand': 10};

      final complexJson = Map<String, dynamic>.from(baseJson);
      complexJson['car'] = carJson;
      // ClientCarCarModel keys vary slightly?
      // code: fullName: data["ful_name"] vs "full_name" in others?
      // Checking file content: `fullName: data["ful_name"]` (typo in source code? or actual API key?)
      // I should respect source code.
      complexJson['ful_name'] = 'Full Name';

      final model = ClientCarCarModel.fromJson(complexJson);
      expect(model.id, id);
      expect(model.car, isA<CarModel<int>>());
      expect(model.car?.id, 99);
      expect(model.fullName, 'Full Name');
    });

    // Test 4: Verify toString
    test('toString returns expected format', () {
      final model = ClientCarModel.fromJson(baseJson);
      expect(model.toString(), contains('ClientCarModel'));
      expect(model.toString(), contains(plate));
    });

    // Test 5: ClientCarSimpleCar nullable fields
    test('ClientCarSimpleCar handles null optional fields', () {
      final carJson = {'id': 99, 'model': 'Civic', 'year': 2022, 'brand': 10};
      // Minimal json
      final json = {
        'id': 1,
        'country': 'US',
        'created_at': 'date',
        'updated_at': 'date',
        'car': carJson,
      };

      final model = ClientCarSimpleCar.fromJson(json);
      expect(model.plate, null);
      expect(model.vin, null);
    });

    // Test 6: Check hierarchy
    test('ClientCarSimpleCar is ClientCarModel', () {
      final carJson = {'id': 99, 'model': 'Civic', 'year': 2022, 'brand': 10};
      final json = {
        'id': 1,
        'country': 'US',
        'created_at': 'date',
        'updated_at': 'date',
        'car': carJson,
      };
      final model = ClientCarSimpleCar.fromJson(json);
      expect(model, isA<ClientCarModel>());
    });

    // Test 7: ClientCarModel fromJson with null car
    test('ClientCarModel allows null car', () {
      final json = Map<String, dynamic>.from(baseJson);
      json['car'] = null;
      final model = ClientCarModel.fromJson(json);
      expect(model.car, null);
    });

    // Test 8: infoSource and editionForSubsidiary in ClientCarSimpleCar
    test('ClientCarSimpleCar constructor properties', () {
      final model = ClientCarSimpleCar(
        carDetails: null,
        id: 1,
        country: 'C',
        car: 1,
        createdAt: 'd',
        updatedAt: 'd',
        infoSource: 'Source',
        editionForSubsidiary: 'Edition',
      );
      expect(model.infoSource, 'Source');
      expect(model.editionForSubsidiary, 'Edition');
    });

    // Test 9: ClientCarCarModel toString
    test('ClientCarCarModel toString', () {
      final model = ClientCarCarModel(
        id: 1,
        country: 'C',
        createdAt: 'd',
        updatedAt: 'd',
        car: null,
      );
      expect(model.toString(), contains('ClientCarCarModel'));
    });

    // Test 10: ClientCarCarModel handles null car
    test('ClientCarCarModel handles null car fromJson', () {
      final json = {
        'id': 1,
        'country': 'C',
        'created_at': 'd',
        'updated_at': 'd',
        // car missing/null
      };
      final model = ClientCarCarModel.fromJson(json);
      expect(model.car, null);
    });
  });
}
