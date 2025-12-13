import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:partsflow/core/globals/env.dart';
import 'package:partsflow/core/globals/globals.dart';
import 'package:partsflow/data/models/users/login_response.dart';
import "package:http/http.dart" as http;

class _Configs {
  static String apiUrl = "${Env.partsflowUrl}/users";
}

class AuthService {
  static Future<LoginResponse?> login({
    required String email,
    required String password,
    http.Client? client,
  }) async {
    var apiUrl = _Configs.apiUrl;
    var httpClient = client ?? http.Client();

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

    return loginResponse;
  }
}
