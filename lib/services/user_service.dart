import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:partsflow/core/globals/env.dart';
import 'package:partsflow/core/globals/globals.dart';
import 'package:partsflow/data/models/users/login_response.dart';
import 'package:partsflow/data/models/users/user.dart';
import "package:http/http.dart" as http;
import 'package:partsflow/services/local_storage_service.dart';

class _Configs {
  static String apiUrl = "${Env.partsflowUrl}/users";
}

class AuthService {
  static http.Client? _mockClient;
  static set mockClient(http.Client? client) => _mockClient = client;

  static Future<LoginResponse?> login({
    required String email,
    required String password,
    http.Client? client,
  }) async {
    var httpClient = client ?? _mockClient ?? http.Client();

    // var jsonBody = jsonEncode();

    debugPrint(
      "SIGN IN WITH CREDENTIALS: ${{"email": email, "password": password}}",
    );

    final response = await httpClient
        .post(
          Uri.parse("${_Configs.apiUrl}/login/"),
          body: jsonEncode({"email": email, "password": password}),
          headers: {
            "accept": "application/json",
            "Content-Type": "application/json",
          },
        )
        .timeout(const Duration(seconds: 10));

    if (response.statusCode != 200) {
      debugPrint("ERROR BODY: ${response.body}");

      throw HttpException(
        "Error al iniciar sesion. Codigo de error: ${response.statusCode}",
        uri: Uri.parse(_Configs.apiUrl),
      );
    }

    var decodedBody = jsonDecode(response.body);
    var loginResponse = LoginResponse.fromJson(decodedBody);

    Globals.userToken = loginResponse.token;

    // Persist session
    final localStorage = LocalStorageService();
    await localStorage.saveUserToken(loginResponse.token);

    // Fetch and save user profile
    try {
      final user = await getProfile(client: httpClient);
      await localStorage.saveUser(user);
    } catch (e) {
      debugPrint("Error fetching profile: $e");
      // Decide if login should fail if profile fails.
      // For now allow login but user data might be missing.
    }

    return loginResponse;
  }

  static Future<UserModel> getProfile({http.Client? client}) async {
    var httpClient = client ?? _mockClient ?? http.Client();
    final token = Globals.userToken;

    final response = await httpClient.get(
      Uri.parse("${_Configs.apiUrl}/me"),
      headers: {
        "accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode != 200) {
      throw HttpException(
        "Error fetching profile. Code: ${response.statusCode}",
        uri: Uri.parse("${_Configs.apiUrl}/me"),
      );
    }

    return UserModel.fromJson(jsonDecode(response.body));
  }

  static Future<void> logout() async {
    final localStorage = LocalStorageService();
    await localStorage.clearSession();
    Globals.userToken = null;
  }

  static Future<bool> tryAutoLogin() async {
    final localStorage = LocalStorageService();
    final token = await localStorage.getUserToken();
    if (token == null) return false;

    // Optionally verify token validity with API here if needed
    // For now, trust local token and restore user
    final user = await localStorage.getUser();
    if (user == null) return false;

    Globals.userToken = token;
    // You might want to store current user in Globals too if needed elsewhere
    // Globals.currentUser = user;

    return true;
  }
}
