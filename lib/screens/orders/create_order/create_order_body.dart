import 'package:flutter/material.dart';
import 'package:partsflow/core/colors/partsflow_colors.dart';
import 'package:partsflow/core/widgets/car/client_car_search.dart';
import 'package:partsflow/core/widgets/card.dart';
import 'package:partsflow/core/widgets/clients/search_client.dart';
import 'package:partsflow/core/widgets/products/product_search.dart';
import 'package:partsflow/data/abstract_models/client/client.dart';

class CreateOrderBody extends StatefulWidget {
  const CreateOrderBody({super.key});

  @override
  State<CreateOrderBody> createState() => _CreateOrderBodyState();
}

class _CreateOrderBodyState extends State<CreateOrderBody> {
  Client? _selectedClient;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        spacing: 12.0,
        children: [
          SearchClient(
            onClientSelected: (selectedClient) {
              setState(() {
                _selectedClient = selectedClient;
              });
            },
          ),
          ClientCarSearch(),
          ProductSearch(),
        ],
      ),
    );
  }
}
