import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:partsflow/core/globals/env.dart';
import 'package:partsflow/core/globals/globals.dart';
import 'package:partsflow/core/models/list_api_response.dart';
import 'package:partsflow/data/abstract_models/cars/car.dart';
import 'package:partsflow/data/abstract_models/cars/client_car.dart';
import 'package:partsflow/data/models/cars/client_car.dart';
import 'package:partsflow/data/requests/car.dart';
import "package:http/http.dart" as http;

class _Configs {
  static String get apiUrl => "${Env.partsflowUrl}/supplier_cars/clientcar";
  static Map<String, String> get headers => {
    "accept": "application/json",
    "Authorization": "Bearer ${Globals.userToken}",
  };
}

class CarService {
  static http.Client? _mockClient;
  static set mockClient(http.Client? client) => _mockClient = client;

  static Future<ListApiResponse<ClientCar<Car<int>>>> searcClientCar(
    SearcClientCarParams params, {
    http.Client? client,
  }) async {
    debugPrint("==== Buscando vehiculos con params: ${params.toMap()} ===");

    final uri = Uri.parse("${_Configs.apiUrl}/search/").replace(
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

    debugPrint("DECODED BODY $decodedBody");

    ListApiResponse<ClientCar<Car<int>>> clientCars = ListApiResponse.fromJson(
      decodedBody,
      (item) => ClientCarCarModel.fromJson(item),
    );

    return clientCars;
  }
}
