abstract class User {
  String get id;
  String? get cognitoId;
  String get firstName;
  String? get lastName;
  String? get fullName;
  String? get email;
  String? get phone;
  bool? get isActive;
  bool? get isAvailable;
  DateTime? get createdAt;
  DateTime? get updatedAt;
  bool? get isAdmin;
}
