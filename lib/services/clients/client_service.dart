import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:partsflow/core/globals/env.dart';
import 'package:partsflow/core/globals/globals.dart';
import 'package:partsflow/core/models/list_api_response.dart';
import 'package:partsflow/data/abstract_models/client/client.dart';
import 'package:partsflow/data/models/clients/client.dart';
import 'package:partsflow/data/models/clients/requests/search_client.dart';
import "package:http/http.dart" as http;

class _Configs {
  static String get apiUrl => "${Env.partsflowUrl}/clients/search/";
  static Map<String, String> get headers => {
    "accept": "application/json",
    "Authorization": "Bearer ${Globals.userToken}",
  };
}

class ClientService {
  static http.Client? _mockClient;
  static set mockClient(http.Client? client) => _mockClient = client;

  static Future<ListApiResponse<Client>> searchClients(
    SearchClientParams params, {
    http.Client? client,
  }) async {
    debugPrint("==== Buscando clientes con params: ${params.toMap()} ===");

    final uri = Uri.parse(_Configs.apiUrl).replace(
      queryParameters: params.toMap().map(
        (key, value) => MapEntry(key, value.toString()),
      ),
    );

    var httpClient = client ?? _mockClient ?? http.Client();

    final response = await httpClient.get(uri, headers: _Configs.headers);

    if (response.statusCode != 200) {
      throw Exception(
        "Error al buscar clientes. Codigo de error ${response.statusCode}",
      );
    }

    var decodedBody = jsonDecode(response.body);

    ListApiResponse<Client> clients = ListApiResponse.fromJson(
      decodedBody,
      (item) => ClientModel.fromJson(item),
    );

    return clients;
  }
}
