import 'package:flutter_test/flutter_test.dart';
import 'package:partsflow/data/models/users/user.dart';

void main() {
  group('UserModel', () {
    final baseJson = {
      'id': '123',
      'cognito_id': 'cognito_123',
      'first_name': 'John',
      'last_name': 'Doe',
      'full_name': 'John Doe',
      'email': 'john.doe@example.com',
      'phone': '1234567890',
      'is_active': true,
      'is_available': true,
      'created_at': '2023-01-01T00:00:00.000Z',
      'updated_at': '2023-01-02T00:00:00.000Z',
      'is_admin': false,
    };

    // Test 1: fromJson creates a valid UserModel
    test('fromJson creates a valid UserModel', () {
      final user = UserModel.fromJson(baseJson);

      expect(user.id, '123');
      expect(user.cognitoId, 'cognito_123');
      expect(user.firstName, 'John');
      expect(user.lastName, 'Doe');
      expect(user.fullName, 'John Doe');
      expect(user.email, 'john.doe@example.com');
      expect(user.phone, '1234567890');
      expect(user.isActive, true);
      expect(user.isAvailable, true);
      expect(user.createdAt, DateTime.parse('2023-01-01T00:00:00.000Z'));
      expect(user.updatedAt, DateTime.parse('2023-01-02T00:00:00.000Z'));
      expect(user.isAdmin, false);
    });

    // Test 2: fromJson handles null optional values
    test('fromJson handles null optional values', () {
      final json = {
        'id': '123',
        'first_name': 'John',
        'last_name': null,
        'email': null,
        'created_at': null,
        'is_active': null,
      };

      final user = UserModel.fromJson(json);

      expect(user.id, '123');
      expect(user.firstName, 'John');
      expect(user.lastName, null);
      expect(user.email, null);
      expect(user.createdAt, null);
      expect(user.isActive, null);
    });

    // Test 3: fromJson handles missing optional keys
    test('fromJson handles missing optional keys', () {
      final json = {'id': '123', 'first_name': 'John'};

      final user = UserModel.fromJson(json);
      expect(user.cognitoId, null);
      expect(user.isAdmin, null);
    });

    // Test 4: DateTime parsing check
    test('Date parsing is correct', () {
      final json = Map<String, dynamic>.from(baseJson);
      json['created_at'] = '2025-12-25T10:00:00Z';
      final user = UserModel.fromJson(json);
      expect(user.createdAt?.year, 2025);
      expect(user.createdAt?.month, 12);
    });

    // Test 5: Check isAdmin boolean
    test('isAdmin is correctly mapped', () {
      final json = Map<String, dynamic>.from(baseJson);
      json['is_admin'] = true;
      final user = UserModel.fromJson(json);
      expect(user.isAdmin, true);
    });

    // Test 6: Constructor assignments
    test('Constructor works correctly', () {
      final user = UserModel(
        id: '999',
        firstName: 'Jane',
        email: 'jane@example.com',
      );
      expect(user.id, '999');
      expect(user.firstName, 'Jane');
      expect(user.email, 'jane@example.com');
      expect(user.isAdmin, null);
    });

    // Test 7: Validation or Types (implicit but good to verify)
    test('Type checks', () {
      final user = UserModel.fromJson(baseJson);
      expect(user.id, isA<String>());
      expect(user.isActive, isA<bool>());
    });

    // Test 8: Empty strings allowed?
    test('Handles empty strings', () {
      final json = {'id': '', 'first_name': '', 'email': ''};
      final user = UserModel.fromJson(json);
      expect(user.id, '');
      expect(user.firstName, '');
    });

    // Test 9: Null id throws error (id is required string)
    test('Throws if ID is missing', () {
      final json = {'first_name': 'John'};
      expect(() => UserModel.fromJson(json), throwsA(anything));
    });

    // Test 10: Null first_name throws error (required)
    test('Throws if first_name is missing', () {
      final json = {'id': '123'};
      expect(() => UserModel.fromJson(json), throwsA(anything));
    });
  });
}
