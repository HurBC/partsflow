import 'package:partsflow/data/abstract_models/user/user.dart';

class UserModel extends User {
  final String id;
  final String? cognitoId;
  final String firstName;
  final String? lastName;
  final String? fullName;
  final String? email;
  final String? phone;
  final bool? isActive;
  final bool? isAvailable;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? isAdmin;

  UserModel({
    required this.id,
    this.cognitoId,
    required this.firstName,
    this.lastName,
    this.fullName,
    this.email,
    this.phone,
    this.isActive,
    this.isAvailable,
    this.createdAt,
    this.updatedAt,
    this.isAdmin,
  });

  // fromJson
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      cognitoId: json['cognito_id'] as String?,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String?,
      fullName: json['full_name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      isActive: json['is_active'] as bool?,
      isAvailable: json['is_available'] as bool?,
      createdAt: json['created_at'] !=  null ? DateTime.parse(json['created_at'] as String) : null,
      updatedAt: json['updated_at'] !=  null ? DateTime.parse(json['updated_at'] as String) : null,
      isAdmin: json['is_admin'] as bool?,
    );
  }
}

