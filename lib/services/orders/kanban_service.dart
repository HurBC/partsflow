
import 'dart:convert';
import 'dart:io';

import "package:http/http.dart" as http;
import 'package:partsflow/core/globals/env.dart';
import 'package:partsflow/core/globals/globals.dart';
import 'package:partsflow/data/models/order/order.dart';

class _Configs {
  static String get apiUrl => "${Env.partsflowUrl}/orders/kanban";
  static Map<String, String> get headers => {
      "accept": "application/json",
      "Authorization": "Bearer ${Globals.userToken}"
    };
}

enum SortByCategoryEnum {
  categoryWeightASC,
  categoryWeightDESC,
}

class KanbanService {
  static Future<List<KanbanOrderRepostory>> getKanbanOrders({
    OrderStatusChoices? status
  }) async {
    print("GETTING ORDERS WITH STATUS ${status?.toJson()}");

    final response = await http.get(
      Uri.parse("${_Configs.apiUrl}/?status=${status?.toJson()}"),
      headers: _Configs.headers
    );

    if (response.statusCode != 200) {
      print("ERROR BODY: ${response.body}");

      throw HttpException(
        "Error al obtener los pedidos. Codigo de error ${response.statusCode}",
        uri: Uri.parse(_Configs.apiUrl)
      );
    }

    var decodedBody = jsonDecode(response.body);

    List<KanbanOrderRepostory> orders = List.empty(growable: true);

    for (var decodedOrder in decodedBody["results"] as List) {
      KanbanOrderRepostory order = KanbanOrderRepostory.fromJson(decodedOrder);

      orders.add(order);
    }

    print("TOTAL ORDERS ${orders.length}");

    return orders;
  }
}
