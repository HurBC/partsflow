import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:partsflow/core/globals/env.dart';
import 'package:partsflow/core/globals/globals.dart';
import 'package:partsflow/core/models/list_api_response.dart';
import 'package:partsflow/data/abstract_models/products/simple_product.dart';
import 'package:partsflow/data/models/products/product.dart';
import 'package:partsflow/data/requests/products/search_products.dart';
import "package:http/http.dart" as http;

class _Configs {
  static String get apiUrl => "${Env.partsflowUrl}/products";
  static Map<String, String> get headers => {
    "accept": "application/json",
    "Authorization": "Bearer ${Globals.userToken}",
  };
}

class ProductsService {
  static http.Client? _mockClient;
  static set mockClient(http.Client? client) => _mockClient = client;

  static Future<ListApiResponse<SimpleProduct>> searchProduct(
    SearchProducts params, {
    http.Client? client,
  }) async {
    debugPrint("==== Buscando productos con params: ${params.toMap()} ===");

    final uri = Uri.parse("${_Configs.apiUrl}/search").replace(
      queryParameters: params.toMap().map(
        (key, value) => MapEntry(key, value.toString()),
      ),
    );

    var httpClient = client ?? _mockClient ?? http.Client();

    final response = await httpClient.get(uri, headers: _Configs.headers);

    if (response.statusCode != 200) {
      if (params.query.isEmpty) {
        throw Exception("Por favor escriba el nombre de un producto");
      }

      throw Exception(
        "Error al buscar productos. Codigo de error ${response.statusCode}",
      );
    }

    var decodedBody = jsonDecode(response.body);

    ListApiResponse<SimpleProduct> products = ListApiResponse.fromJson(
      decodedBody,
      (item) => SimpleProductModel.fromJson(item),
    );

    return products;
  }
}
