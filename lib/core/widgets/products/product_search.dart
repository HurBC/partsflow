import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:partsflow/data/abstract_models/products/simple_product.dart';
import 'package:partsflow/data/requests/products/search_products.dart';
import 'package:partsflow/services/products/products_service.dart';

class ProductSearch extends StatefulWidget {
  final void Function(SimpleProduct selectedProduct) onProductSelected;

  const ProductSearch({super.key, required this.onProductSelected});

  @override
  State<ProductSearch> createState() => _ProductSearchState();
}

class _ProductSearchState extends State<ProductSearch> {
  @override
  Widget build(BuildContext context) {
    return DropdownSearch(
      items: (filter, loadProps) async {
        SearchProducts params = SearchProducts(query: filter, limit: 50);

        final data = await ProductsService.searchProduct(params);

        debugPrint("Productos cargados ${data.results}");

        return data.results;
      },
      onChanged: (value) {
        widget.onProductSelected(value);
      },
      decoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
          labelText: "Buscar productos",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
        ),
      ),
      itemAsString: (item) => item.getName(),
      compareFn: (item1, item2) => item1.getId() == item2.getId(),
      filterFn: (item, filter) => true,
      popupProps: const PopupProps.menu(
        showSearchBox: true,
        searchDelay: Duration(milliseconds: 500),
      ),
    );
  }
}
