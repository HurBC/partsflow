import 'package:partsflow/data/abstract_models/user/user.dart';

class UserModel extends User {
  @override
  final String id;
  @override
  final String? cognitoId;
  @override
  final String firstName;
  @override
  final String? lastName;
  @override
  final String? fullName;
  @override
  final String? email;
  @override
  final String? phone;
  @override
  final bool? isActive;
  @override
  final bool? isAvailable;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
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
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      isAdmin: json['is_admin'] as bool?,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cognito_id': cognitoId,
      'first_name': firstName,
      'last_name': lastName,
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'is_active': isActive,
      'is_available': isAvailable,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'is_admin': isAdmin,
    };
  }
}
