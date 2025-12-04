import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:partsflow/data/abstract_models/client/client.dart';
import 'package:partsflow/data/models/clients/requests/search_client.dart';
import 'package:partsflow/services/clients/client_service.dart';

class SearchClient extends StatefulWidget {
  final void Function(Client selectedClient) onClientSelected; 

  const SearchClient({super.key, required this.onClientSelected});

  @override
  State<SearchClient> createState() => _SearchClientState();
}

class _SearchClientState extends State<SearchClient> {
  @override
  Widget build(BuildContext context) {
    return DropdownSearch(
      items: (filter, loadProps) async {
        SearchClientParams params = SearchClientParams(
          limit: 10,
          query: filter,
        );

        final data = await ClientService.searchClients(params);

        debugPrint("Clientes cargados: ${data.results.length}");

        return data.results;
      },
      itemAsString: (item) => "${item.fullName} (${item.phone})",
      onChanged: (value) {
        widget.onClientSelected(value);
      },
      compareFn: (item1, item2) => item1.id == item2.id,
      decoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
          labelText: "Buscar cliente",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
      popupProps: const PopupProps.menu(
        showSearchBox: true,
        searchDelay: const Duration(milliseconds: 500),
      ),
    );
  }
}
