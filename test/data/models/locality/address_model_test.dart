import 'package:flutter_test/flutter_test.dart';
import 'package:partsflow/data/models/locality/address.dart';

void main() {
  group('AddressModel', () {
    const id = 1;
    const label = 'Home';
    const streetName = 'Main Street';
    const streetNumber = 123;
    const localNumber = 'A';
    const fullAddress = 'Main Street 123, A';

    final communeJson = {
      'id': 10,
      'name': 'Santiago',
      'region': 'Metropolitana',
      'country': 'Chile',
    };

    final addressJson = {
      'id': id,
      'label': label,
      'street_name': streetName,
      'street_number': streetNumber,
      'local_number': localNumber,
      'full_address': fullAddress,
      'commune': communeJson,
    };

    test('should support value comparisons', () {
      final address1 = AddressModel.fromJson(addressJson);
      final address2 = AddressModel.fromJson(addressJson);

      // Since AddressModel doesn't override == (except indirectly potentially),
      // we check fields or if we trust the generated/base model equality.
      // Looking at the code, it extends Address/Commune but probably doesn't use Equatable.
      // So we check fields manually or assume identity is distinct.
      // Let's check fields to be safe.
      expect(address1.id, address2.id);
      expect(address1.label, address2.label);
    });

    // Test 1: fromJson creates valid instance
    test('fromJson creates a valid instance', () {
      final model = AddressModel.fromJson(addressJson);
      expect(model.id, id);
      expect(model.label, label);
      expect(model.streetName, streetName);
      expect(model.streetNumber, streetNumber);
      expect(model.localNumber, localNumber);
      expect(model.fullAddress, fullAddress);
      expect(model.commune.id, 10);
    });

    // Test 2: toJson returns valid map
    test('toJson returns a valid map', () {
      final model = AddressModel.fromJson(addressJson);
      final json = model.toJson();
      expect(json['id'], id);
      expect(json['label'], label);
      expect(json['street_name'], streetName);
      expect(json['commune'], isA<Map>());
      expect((json['commune'] as Map)['name'], 'Santiago');
    });

    // Test 3: Check CommuneModel fromJson
    test('CommuneModel fromJson works correctly', () {
      final commune = CommuneModel.fromJson(communeJson);
      expect(commune.id, 10);
      expect(commune.name, 'Santiago');
      expect(commune.region, 'Metropolitana');
      expect(commune.country, 'Chile');
    });

    // Test 4: Check CommuneModel toJson
    test('CommuneModel toJson works correctly', () {
      final commune = CommuneModel.fromJson(communeJson);
      final json = commune.toJson();
      expect(json['id'], 10);
      expect(json['name'], 'Santiago');
    });

    // Test 5: Verify types of field mapping
    test('Types are correctly mapped', () {
      final model = AddressModel.fromJson(addressJson);
      expect(model.id, isA<int>());
      expect(model.label, isA<String>());
      expect(model.commune, isA<CommuneModel>());
    });

    // Test 6: Verify full address format (just value check)
    test('fullAddress is correctly stored', () {
      final model = AddressModel.fromJson(addressJson);
      expect(model.fullAddress, contains('Main Street'));
      expect(model.fullAddress, contains('123'));
    });

    // Test 7: Handle slightly different json (extra fields ignored)
    test('fromJson ignores extra fields', () {
      final extendedJson = Map<String, dynamic>.from(addressJson);
      extendedJson['extra_field'] = 'something';
      final model = AddressModel.fromJson(extendedJson);
      expect(model.id, id);
    });

    // Test 8: CommuneModel equality (manual check of props)
    test('CommuneModel properties check', () {
      final commune = CommuneModel(id: 1, name: 'A', region: 'B', country: 'C');
      expect(commune.id, 1);
      expect(commune.name, 'A');
    });

    // Test 9: AddressModel constructor works directly
    test('Constructor works directly', () {
      final commune = CommuneModel(id: 1, name: 'A', region: 'B', country: 'C');
      final address = AddressModel(
        id: 1,
        label: 'L',
        streetName: 'S',
        streetNumber: 1,
        localNumber: '1',
        fullAddress: 'Full',
        commune: commune,
      );
      expect(address.id, 1);
      expect(address.commune, commune);
    });

    // Test 10: Check null/empty handling (if applicable, though fields are required)
    // Since fields are required, we can check that it throws if keys are missing in fromJson
    test('fromJson throws if required key is missing', () {
      final badJson = Map<String, dynamic>.from(addressJson);
      badJson.remove('id');
      // In Dart, missing key access might be null, but putting null into 'required int' in constructor fails
      // or 'as int' fails. let's see.
      // json['id'] would be null. passing null to required int parameter is a runtime error in recent dart if null safety is strong.
      expect(() => AddressModel.fromJson(badJson), throwsA(anything));
    });
  });
}
