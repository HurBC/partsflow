import 'dart:convert';
import 'dart:io';

import "package:http/http.dart" as http;
import 'package:partsflow/core/globals/env.dart';
import 'package:partsflow/core/globals/globals.dart';
import 'package:partsflow/data/models/order/enums/order_enums.dart';
import 'package:partsflow/data/models/order/order.dart';

class _Configs {
  static String get apiUrl => "${Env.partsflowUrl}/orders/kanban";
  static Map<String, String> get headers => {
    "accept": "application/json",
    "Authorization": "Bearer ${Globals.userToken}",
  };
}

enum SortByCategoryEnum { categoryWeightASC, categoryWeightDESC }

class KanbanService {
  static Future<List<KanbanOrderRepository>> getKanbanOrders({
    List<OrderStatusChoices>? status,
    int? limit,
    int? offset,
  }) async {
    final params = StringBuffer("");

    if (status != null) {
      params.write("status=");

      for (var i = 0; i < status.length; i++) {
        params.write(status[i].toJson());

        if (i != (status.length - 1)) {
          params.write(",");
        }
      }
    }

    if (limit != null) {
      if (params.toString() != "") params.write("&");

      params.write("limit=$limit");
    }

    print("GETTING ORDERS WITH STATUS ${params.toString()}");

    final response = await http.get(
      Uri.parse("${_Configs.apiUrl}/?${params.toString()}&sort_by=-created_at&offset=0"),
      headers: _Configs.headers,
    );

    if (response.statusCode != 200) {
      print("ERROR BODY: ${response.body}");

      throw HttpException(
        "Error al obtener los pedidos. Codigo de error ${response.statusCode}",
        uri: Uri.parse(_Configs.apiUrl),
      );
    }

    var decodedBody = jsonDecode(response.body);

    List<KanbanOrderRepository> orders = List.empty(growable: true);

    for (var decodedOrder in decodedBody["results"] as List) {
      KanbanOrderRepository order = KanbanOrderRepository.fromJson(decodedOrder);

      orders.add(order);
    }

    return orders;
  }
}
