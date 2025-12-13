import 'package:flutter_test/flutter_test.dart';
import 'package:partsflow/data/models/products/product.dart';

void main() {
  group('SimpleProductModel', () {
    test('fromJson creates a valid SimpleProductModel', () {
      final json = {'id': 1, 'name': 'Product 1', 'is_visible': true};

      final product = SimpleProductModel.fromJson(json);

      expect(product.id, 1);
      expect(product.name, 'Product 1');
      expect(product.isVisible, true);
    });

    test('getIsVisible returns expected values', () {
      var json = {'id': 1, 'name': 'P', 'is_visible': true};
      var product = SimpleProductModel.fromJson(json);
      expect(product.getIsVisible(), true);

      var json2 = {'id': 1, 'name': 'P', 'is_visible': null};
      product = SimpleProductModel.fromJson(json2);
      expect(product.getIsVisible(), false);
    });
  });
}
