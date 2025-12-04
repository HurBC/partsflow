import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:partsflow/core/globals/env.dart';
import 'package:partsflow/core/globals/globals.dart';
import 'package:partsflow/data/models/cars/client_car.dart';
import 'package:partsflow/services/cars/car_service.dart';
import "package:http/http.dart" as http;

class _Configs {
  static String get apiUrl => "${Env.partsflowUrl}/supplier_cars/clientcar";
  static Map<String, String> get headers => {
    "accept": "application/json",
    "Authorization": "Bearer ${Globals.userToken}",
  };
}

extension SupplierCarService on CarService {
  static Future<ClientCarCarModel> getClientCar({
    required int clientCarId
  }) async {
    debugPrint("GETTING CLIENT CAR INFO");

    final uri = Uri.parse("${_Configs.apiUrl}/$clientCarId");

    final response = await http.get(uri, headers: _Configs.headers);

    if (response.statusCode != 200) {
      debugPrint("ERROR BODY: ${response.body}");

      throw HttpException(
        "Error al obtener los pedidos. Codigo de error ${response.statusCode}",
        uri: uri,
      );
    }

    var decodedBody = jsonDecode(response.body);

    debugPrint("DECODED BODY: $decodedBody");

    ClientCarCarModel clientCar = ClientCarCarModel.fromJson(decodedBody);

    return clientCar;
  }
}