import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:partsflow/services/products/products_service.dart';
import 'package:partsflow/data/requests/products/search_products.dart';
import 'package:partsflow/core/globals/globals.dart';

class MockClient extends Mock implements http.Client {}

class FakeSearchProducts extends Fake implements SearchProducts {
  @override
  Map<String, dynamic> toMap() => {};

  @override
  String get query => 'valid query';
}

void main() {
  late MockClient client;

  setUp(() {
    dotenv.testLoad(fileInput: "PARTSFLOW_API_URL=https://api.example.com");
    client = MockClient();
    registerFallbackValue(Uri());
    Globals.userToken = 'fake_token';
  });

  group('ProductsService', () {
    final productJson = {
      'id': 1,
      'name': 'Brake Pad',
      'sku': 'BP-123',
      'is_visible': true,
    };

    final listResponse = {
      'count': 1,
      'results': [productJson],
    };

    // Test 1: searchProduct success
    test('searchProduct returns ListApiResponse', () async {
      when(
        () => client.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response(jsonEncode(listResponse), 200));

      final result = await ProductsService.searchProduct(
        FakeSearchProducts(),
        client: client,
      );

      expect(result.count, 1);
      expect(result.results.length, 1);
      expect(result.results.first.getName(), 'Brake Pad');
    });

    // Test 2: searchProduct failure (500)
    test('searchProduct throws Exception on failure', () async {
      when(
        () => client.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response('Error', 500));

      expect(
        () =>
            ProductsService.searchProduct(FakeSearchProducts(), client: client),
        throwsA(isA<Exception>()),
      );
    });

    // Test 3: Specific error message on empty query (if service implements that logic)
    // Code has: if (params.query.isEmpty) throw Exception("Por favor escriba el nombre de un producto");
    test('throws specific message if query is empty on error', () async {
      when(
        () => client.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response('Error', 400));

      final params = MockSearchProductsEmpty();

      expect(
        () => ProductsService.searchProduct(params, client: client),
        throwsA(
          predicate<Exception>(
            (e) => e.toString().contains('Por favor escriba el nombre'),
          ),
        ),
      );
    });

    // Test 4: Default error message if query not empty
    test(
      'throws generic error message if query is not empty on error',
      () async {
        when(
          () => client.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => http.Response('Error', 500));

        final params = FakeSearchProducts(); // query is 'valid query'

        expect(
          () => ProductsService.searchProduct(params, client: client),
          throwsA(
            predicate<Exception>(
              (e) => e.toString().contains('Error al buscar productos'),
            ),
          ),
        );
      },
    );

    // Test 5: Verify URI
    test('constructs URI correctly', () async {
      when(
        () => client.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response(jsonEncode(listResponse), 200));

      await ProductsService.searchProduct(FakeSearchProducts(), client: client);
      verify(
        () => client.get(
          any(
            that: predicate<Uri>(
              (uri) => uri.path.contains('/products/search'),
            ),
          ),
          headers: any(named: 'headers'),
        ),
      ).called(1);
    });

    // Test 6: Empty response
    test('Handle empty response', () async {
      final emptyResponse = {'count': 0, 'results': []};
      when(
        () => client.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response(jsonEncode(emptyResponse), 200));

      final result = await ProductsService.searchProduct(
        FakeSearchProducts(),
        client: client,
      );
      expect(result.results, isEmpty);
    });

    // Test 7: Malformed JSON
    test('Format exception on bad json', () async {
      when(
        () => client.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response('{bad', 200));

      expect(
        () =>
            ProductsService.searchProduct(FakeSearchProducts(), client: client),
        throwsA(isA<FormatException>()),
      );
    });

    // Test 8: Network Exception
    test('Propagates network exception', () async {
      when(
        () => client.get(any(), headers: any(named: 'headers')),
      ).thenThrow(SocketException('failed'));

      expect(
        () =>
            ProductsService.searchProduct(FakeSearchProducts(), client: client),
        throwsA(isA<SocketException>()),
      );
    });

    // Test 9: Verify headers
    test('Verify Authorization header', () async {
      when(
        () => client.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response(jsonEncode(listResponse), 200));

      await ProductsService.searchProduct(FakeSearchProducts(), client: client);

      final captured = verify(
        () => client.get(any(), headers: captureAny(named: 'headers')),
      ).captured.last;
      expect(captured['Authorization'], contains('Bearer'));
    });

    // Test 10: 404 Error
    test('Throws on 404', () async {
      when(
        () => client.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response('Not Found', 404));

      expect(
        () =>
            ProductsService.searchProduct(FakeSearchProducts(), client: client),
        throwsA(isA<Exception>()),
      );
    });
  });
}

class MockSearchProductsEmpty extends Fake implements SearchProducts {
  @override
  Map<String, dynamic> toMap() => {};

  @override
  String get query => '';
}
