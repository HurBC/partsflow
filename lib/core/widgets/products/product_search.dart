import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:partsflow/data/requests/products/search_products.dart';
import 'package:partsflow/services/products/products_service.dart';

class ProductSearch extends StatefulWidget {
  const ProductSearch({super.key});

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
        debugPrint("PRRODUCTO SELECCIONADO: ${value}");
      },
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
