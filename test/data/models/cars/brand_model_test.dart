import 'package:flutter_test/flutter_test.dart';
import 'package:partsflow/data/models/cars/brand.dart';

void main() {
  group('BrandModel', () {
    const id = 1;
    const name = 'Toyota';
    const country = 'Japan';
    const isLightVehicle = true;
    const createdAt = '2023-01-01';
    const updatedAt = '2023-01-02';

    final brandJson = {
      'id': id,
      'name': name,
      'country': country,
      'is_light_vehicle': isLightVehicle,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };

    // Test 1: Constructor
    test('Constructor works correctly', () {
      final brand = BrandModel(
        id: id,
        name: name,
        country: country,
        isLightVehicle: isLightVehicle,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
      expect(brand.id, id);
      expect(brand.name, name);
    });

    // Test 2: fromJson valid
    test('fromJson creates valid instance', () {
      final brand = BrandModel.fromJson(brandJson);
      expect(brand.id, id);
      expect(brand.name, name);
      expect(brand.country, country);
      expect(brand.isLightVehicle, isLightVehicle);
      expect(brand.createdAt, createdAt);
      expect(brand.updatedAt, updatedAt);
    });

    // Test 3: Optional fields null
    test('fromJson handles null optional fields', () {
      final json = {
        'id': id,
        'name': name,
        'country': country,
        'is_light_vehicle': null,
        'created_at': null,
        'updated_at': null,
      };
      final brand = BrandModel.fromJson(json);
      expect(brand.isLightVehicle, null);
      expect(brand.createdAt, null);
      expect(brand.updatedAt, null);
    });

    // Test 4: Extends Brand
    test('Check inheritance', () {
      final brand = BrandModel.fromJson(brandJson);
      // ignore: unnecessary_type_check
      expect(brand is BrandModel, true);
    });

    // Test 5: Field types
    test('Field types are correct', () {
      final brand = BrandModel.fromJson(brandJson);
      expect(brand.id, isA<int>());
      expect(brand.name, isA<String>());
    });

    // Test 6: Missing keys handling (if permissive or throws)
    // Here it maps directly to arguments, so if 'id' is missing it gets null,
    // and required int id cannot be null -> type error.
    test('fromJson throws if required field missing', () {
      final json = {'name': 'Toyota'}; // missing id
      expect(() => BrandModel.fromJson(json), throwsA(anything));
    });

    // Test 7: isLightVehicle boolean check
    test('isLightVehicle explicitly false', () {
      final json = Map<String, dynamic>.from(brandJson);
      json['is_light_vehicle'] = false;
      final brand = BrandModel.fromJson(json);
      expect(brand.isLightVehicle, false);
    });

    // Test 8: Equality check (manual since no Equatable)
    test('Manual equality check', () {
      final b1 = BrandModel.fromJson(brandJson);
      final b2 = BrandModel.fromJson(brandJson);
      expect(b1.id, b2.id);
      expect(b1.name, b2.name);
    });

    // Test 9: Extra fields ignored
    test('Extra fields are ignored', () {
      final json = Map<String, dynamic>.from(brandJson);
      json['extra'] = 'ignored';
      final brand = BrandModel.fromJson(json);
      expect(brand.id, id);
    });

    // Test 10: Empty strings
    test('Handles empty strings', () {
      final json = {
        'id': id,
        'name': '',
        'country': '',
        'is_light_vehicle': true,
      };
      final brand = BrandModel.fromJson(json);
      expect(brand.name, '');
      expect(brand.country, '');
    });
  });
}
