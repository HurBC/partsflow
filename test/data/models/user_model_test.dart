import 'package:flutter_test/flutter_test.dart';
import 'package:partsflow/data/models/users/user.dart';

void main() {
  group('UserModel', () {
    test('fromJson creates a valid UserModel', () {
      final json = {
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

      final user = UserModel.fromJson(json);

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

    test('fromJson handles null values', () {
      final json = {'id': '123', 'first_name': 'John'};

      final user = UserModel.fromJson(json);

      expect(user.id, '123');
      expect(user.firstName, 'John');
      expect(user.lastName, null);
      expect(user.email, null);
      expect(user.createdAt, null);
    });
  });
}
