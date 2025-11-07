import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:partsflow/core/globals/env.dart';
import 'package:partsflow/core/globals/globals.dart';
import "package:http/http.dart" as http;
import 'package:partsflow/data/models/order/order.dart';

class _Configs {
  static String get apiUrl => "${Env.partsflowUrl}/orders";
  static Map<String, String> get headers => {
    "accept": "application/json",
    "Authorization": "Bearer ${Globals.userToken}",
  };
}

class OrdersService {
  static Future<OrderDetailRespository> getOrder({
    required int orderId
  }) async {
    final uri = Uri.parse("${_Configs.apiUrl}/$orderId");

    final response = await http.get(uri, headers: _Configs.headers);

    if (response.statusCode != 200) {
      debugPrint("ERROR BODY: ${response.body}");

      throw HttpException(
        "Error al obtener los pedidos. Codigo de error ${response.statusCode}",
        uri: Uri.parse(_Configs.apiUrl),
      );
    }

    var decodedBody = jsonDecode(response.body);

    OrderDetailRespository orderDetail = OrderDetailRespository.fromJson(decodedBody);

    return orderDetail;
  }
}