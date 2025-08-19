import 'dart:convert';

import 'package:partsflow/data/models/users/login_response.dart';
import "package:http/http.dart" as http;
import 'package:partsflow/data/repository.dart';

class UserRerpository {
  final String? partsflowUrl;
  late String usersUrl;

  UserRerpository({required this.partsflowUrl}) {
    usersUrl = "$partsflowUrl/users";
  }

  Future<LoginResponse?> login({
    required String email,
    required String password,
  }) async {
    var json = jsonEncode({"email": email, "password": password});

    final response = await http.post(
      Uri.parse("$usersUrl/login/"),
      body: json,
      headers: {
        "accept": "application/json",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode != 200) return null;

    var decodedResponse = jsonDecode(response.body);

    return LoginResponse.fromJson(decodedResponse);
  }
}
