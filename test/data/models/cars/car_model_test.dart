import 'package:flutter_test/flutter_test.dart';
import 'package:partsflow/data/models/cars/brand.dart';
import 'package:partsflow/data/models/cars/car.dart';

void main() {
  group('CarModel', () {
    const id = 1;
    const modelName = 'Corolla';
    const version = 'XEI';
    const displacement = '2.0';
    const year = 2023;

    final brandJson = {
      'id': 10,
      'name': 'Toyota',
      'country': 'Japan',
      'is_light_vehicle': true,
    };

    final carJsonWithBrandObject = {
      'id': id,
      'model': modelName,
      'version': version,
      'displacement': displacement,
      'year': year,
      'brand': brandJson,
    };

    final carJsonWithBrandId = {
      'id': id,
      'model': modelName,
      'version': version,
      'displacement': displacement,
      'year': year,
      'brand': 10,
    };

    final carJsonWithBrandIdInMap = {
      'id': id,
      'model': modelName,
      'version': version,
      'displacement': displacement,
      'year': year,
      'brand': {'id': 10},
    };

    // Test 1: fromJson with BrandModel (full object)
    test('fromJson handles BrandModel generic type', () {
      final car = CarModel<BrandModel>.fromJson(carJsonWithBrandObject);
      expect(car.id, id);
      expect(car.model, modelName);
      expect(car.brand, isA<BrandModel>());
      expect(car.brand?.name, 'Toyota');
    });

    // Test 2: fromJson with int branding (direct ID)
    test('fromJson handles int generic type with direct ID', () {
      final car = CarModel<int>.fromJson(carJsonWithBrandId);
      expect(car.id, id);
      expect(car.brand, 10);
    });

    // Test 3: fromJson with int branding (nested ID map)
    test('fromJson handles int generic type with nested Map ID', () {
      final car = CarModel<int>.fromJson(carJsonWithBrandIdInMap);
      expect(car.id, id);
      expect(car.brand, 10);
    });

    // Test 4: SimpleCar tests
    test('SimpleCar fromJson', () {
      final json = {'id': 100, 'name': 'Simple'};
      final simple = SimpleCar.fromJson(json);
      expect(simple.id, 100);
      expect(simple.name, 'Simple');
    });

    // Test 5: Optional fields handling
    test('Handles optional fields being null', () {
      final json = {'id': id, 'model': modelName, 'year': year, 'brand': 10};
      final car = CarModel<int>.fromJson(json);
      expect(car.version, null);
      expect(car.displacement, null);
    });

    // Test 6: Manufacturer field
    test('Correctly maps manufacturer', () {
      final json = Map<String, dynamic>.from(carJsonWithBrandId);
      json['manufacturer'] = 'Toyota Mfg';
      final car = CarModel<int>.fromJson(json);
      expect(car.manufacturer, 'Toyota Mfg');
    });

    // Test 7: Origin Country field
    test('Correctly maps origin_country', () {
      final json = Map<String, dynamic>.from(carJsonWithBrandId);
      json['origin_country'] = 'Brazil';
      final car = CarModel<int>.fromJson(json);
      expect(car.originCountry, 'Brazil');
    });

    // Test 8: First motor numbers field
    test('Correctly maps first_motor_numbers', () {
      final json = Map<String, dynamic>.from(carJsonWithBrandId);
      json['first_motor_numbers'] = 'ABC';
      final car = CarModel<int>.fromJson(json);
      expect(car.firstMotorNumbers, 'ABC');
    });

    // Test 9: Original model field
    test('Correctly maps original_model', () {
      final json = Map<String, dynamic>.from(carJsonWithBrandId);
      json['original_model'] = 'Old Corolla';
      final car = CarModel<int>.fromJson(json);
      expect(car.originalModel, 'Old Corolla');
    });

    // Test 10: Constructor assignments
    test('Constructor assigns all fields correctly', () {
      final car = CarModel<int>(
        id: 1,
        model: 'M',
        year: 2020,
        brand: 5,
        version: 'V',
        displacement: 'D',
        manufacturer: 'Man',
        firstMotorNumbers: 'F',
        originCountry: 'O',
        originalModel: 'OM',
      );
      expect(car.year, 2020);
      expect(car.manufacturer, 'Man');
    });
  });
}
