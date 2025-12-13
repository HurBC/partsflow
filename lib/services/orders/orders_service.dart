import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:partsflow/core/globals/env.dart';
import 'package:partsflow/core/globals/globals.dart';
import "package:http/http.dart" as http;
import 'package:partsflow/data/models/order/order.dart';
import 'package:partsflow/data/requests/orders/create_order.dart';
import 'package:partsflow/data/requests/orders/update_draft_order.dart';

class _Configs {
  static String get apiUrl => "${Env.partsflowUrl}/orders";
  static Map<String, String> get headers => {
    "accept": "application/json",
    "content-type": "application/json",
    "Authorization": "Bearer ${Globals.userToken}",
  };
}

class OrdersService {
  static Future<OrderDetailRespository> getOrder({
    required int orderId,
    http.Client? client,
  }) async {
    final uri = Uri.parse("${_Configs.apiUrl}/$orderId");
    var httpClient = client ?? http.Client();

    final response = await httpClient.get(uri, headers: _Configs.headers);

    if (response.statusCode != 200) {
      debugPrint("ERROR BODY: ${response.body}");

      throw HttpException(
        "Error al obtener los pedidos. Codigo de error ${response.statusCode}",
        uri: Uri.parse(_Configs.apiUrl),
      );
    }

    var decodedBody = jsonDecode(response.body);

    OrderDetailRespository orderDetail = OrderDetailRespository.fromJson(
      decodedBody,
    );

    return orderDetail;
  }

  static Future<OrderModel> createOrder(
    CreateOrder body, {
    http.Client? client,
  }) async {
    debugPrint("==== Creando Pedido ===");

    final uri = Uri.parse("${_Configs.apiUrl}/");
    var httpClient = client ?? http.Client();

    final response = await httpClient.post(
      uri,
      body: jsonEncode(body.toJson()),
      headers: _Configs.headers,
    );

    if (response.statusCode != 201) {
      debugPrint("ERROR BODY: ${response.body}");

      throw HttpException(
        "Error al crear el pedido. Codigo de error ${response.statusCode}",
        uri: Uri.parse(_Configs.apiUrl),
      );
    }

    var decodedBody = jsonDecode(response.body);

    OrderModel order = OrderModel.fromJson(decodedBody);

    return order;
  }

  static Future<bool> updateDraftOrder(
    UpdateDraftOrder body, {
    http.Client? client,
  }) async {
    debugPrint("==== Actualizando Pedido ====");
    debugPrint("INFO: ${jsonEncode(body.toJson())}");

    final uri = Uri.parse("${_Configs.apiUrl}/${body.id}/update_draft_order/");
    var httpClient = client ?? http.Client();

    final response = await httpClient.patch(
      uri,
      body: jsonEncode(body.toJson()),
      headers: _Configs.headers,
    );

    if (response.statusCode != 200) {
      debugPrint("ERROR BODY: ${response.body}");

      throw HttpException(
        "Error al crear el pedido. Codigo de error ${response.statusCode}",
        uri: Uri.parse(_Configs.apiUrl),
      );
    }

    return true;
  }
}
