import 'dart:convert';
import 'dart:io';

import "package:http/http.dart" as http;
import 'package:partsflow/core/components/sort_tag_filter.dart';
import 'package:partsflow/core/globals/env.dart';
import 'package:partsflow/core/globals/globals.dart';
import 'package:partsflow/data/models/order/enums/order_enums.dart';
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
  static Future<List<KanbanOrderRepository>> getKanbanOrders(
    ListOrders params,
  ) async {
    final queryParams = StringBuffer("");
    final mapParams = params.toMap();

    mapParams.entries.forEach((element) {
      String key = element.key;
      var value = element.value;

      if (value == null) return;

      if (value is List) {
        final listValues = value
            .map((item) {
              if (item is Enum) {
                try {
                  final jsonValue = (item as dynamic).toJson();

                  return jsonValue;
                } catch (e) {
                  return item.name;
                }
              }

              return item.toString();
            })
            .join(",");

        queryParams.write("$key=$listValues");
      } else if (value is SortTagSortingType) {
        queryParams.write(
          "$key=${value == SortTagSortingType.descendant ? "-$key" : key}",
        );
      } else {
        queryParams.write('$key=$value');
      }

      if (element != mapParams.entries.last) queryParams.write("&");
    });

    print("GETTING ORDERS WITH STATUS ${queryParams.toString()}");

    final response = await http.get(
      Uri.parse(
        "${_Configs.apiUrl}/?${queryParams.toString()}&sort_by=-created_at&offset=0",
      ),
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
      KanbanOrderRepository order = KanbanOrderRepository.fromJson(
        decodedOrder,
      );

      orders.add(order);
    }

    return orders;
  }
}
