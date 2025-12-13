import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import "package:http/http.dart" as http;
import 'package:partsflow/core/widgets/sort_tag_filter.dart';
import 'package:partsflow/core/globals/env.dart';
import 'package:partsflow/core/globals/globals.dart';
import 'package:partsflow/data/models/order/order.dart';
import 'package:partsflow/data/models/order/requests/order_requests.dart';

class _Configs {
  static String get apiUrl => "${Env.partsflowUrl}/orders/kanban";
  static Map<String, String> get headers => {
    "accept": "application/json",
    "Authorization": "Bearer ${Globals.userToken}",
  };
}

class KanbanService {
  static Future<List<KanbanOrderModel>> getKanbanOrders(
    ListOrders params, {
    http.Client? client,
  }) async {
    final queryParams = StringBuffer("");
    final mapParams = params.toMap();
    var httpClient = client ?? http.Client();

    for (var element in mapParams.entries) {
      String key = element.key;
      var value = element.value;

      if (value == null) continue;

      if (value is List) {
        final listValues = value
            .map((item) {
              return item.toString();
            })
            .join(",");

        queryParams.write("$key=$listValues");
      } else if (value is SortTagSortingType) {
        if (key == "sort_by_category") {
          queryParams.write(
            "$key=${value == SortTagSortingType.descendant ? "-category_weight" : "category_weight"}",
          );
        } else if (key == "sort_by_estimated_ticket") {
          queryParams.write(
            "$key=${value == SortTagSortingType.descendant ? "-estimated_ticket" : "estimated_ticket"}",
          );
        } else {
          queryParams.write(
            "$key=${value == SortTagSortingType.descendant ? "-created_at" : "created_at"}",
          );
        }
      } else {
        queryParams.write('$key=$value');
      }

      if (element != mapParams.entries.last) queryParams.write("&");
    }

    debugPrint("GETTING ORDERS WITH PARAMS ${queryParams.toString()}");

    final response = await httpClient.get(
      Uri.parse("${_Configs.apiUrl}/?${queryParams.toString()}"),
      headers: _Configs.headers,
    );

    if (response.statusCode != 200) {
      debugPrint("ERROR BODY: ${response.body}");

      throw HttpException(
        "Error al obtener los pedidos. Codigo de error ${response.statusCode}",
        uri: Uri.parse(_Configs.apiUrl),
      );
    }

    var decodedBody = jsonDecode(response.body);

    List<KanbanOrderModel> orders = List.empty(growable: true);

    for (var decodedOrder in decodedBody["results"] as List) {
      KanbanOrderModel order = KanbanOrderModel.fromJson(decodedOrder);

      orders.add(order);
    }

    return orders;
  }
}
