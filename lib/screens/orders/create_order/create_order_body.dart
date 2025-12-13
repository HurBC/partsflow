import 'package:flutter/material.dart';
import 'package:partsflow/core/colors/partsflow_colors.dart';
import 'package:partsflow/core/widgets/car/client_car_search.dart';
import 'package:partsflow/core/widgets/card.dart';
import 'package:partsflow/core/widgets/clients/search_client.dart';
import 'package:partsflow/core/widgets/products/product_search.dart';
import 'package:partsflow/data/abstract_models/cars/car.dart';
import 'package:partsflow/data/abstract_models/cars/client_car.dart';
import 'package:partsflow/data/abstract_models/client/client.dart';
import 'package:partsflow/data/abstract_models/products/simple_product.dart';
import 'package:partsflow/data/models/order/enums/order_enums.dart';
import 'package:partsflow/data/models/order/order.dart';
import 'package:partsflow/data/requests/orders/create_order.dart';
import 'package:partsflow/data/requests/orders/update_draft_order.dart';
import 'package:partsflow/services/orders/orders_service.dart';

class CreateOrderBody extends StatefulWidget {
  final void Function() onOrderCreated;

  const CreateOrderBody({super.key, required this.onOrderCreated});

  @override
  State<CreateOrderBody> createState() => _CreateOrderBodyState();
}

class _CreateOrderBodyState extends State<CreateOrderBody> {
  Client? _selectedClient;
  ClientCar<Car<int>>? _clientCar;
  List<SimpleProduct> _productList = [];
  OrderModel? _order;

  Future<void> _updateOrder() async {
    if (_order?.id == null) {
      return;
    }

    UpdateDraftOrder updateDraftOrder = UpdateDraftOrder(
      id: _order!.id,
      client: _selectedClient?.id,
      clientCar: _clientCar?.id,
      products: _productList,
      status: OrderStatusChoices.request,
    );

    final response = await OrdersService.updateDraftOrder(updateDraftOrder);

    if (response) {
      widget.onOrderCreated();
    }
  }

  Future<void> _createOrder() async {
    CreateOrder body = CreateOrder(
      source: OrderSourceChoices.apiIntegration,
      operationMode: OrderOperationModeEnum.manual,
      client: _selectedClient?.id ?? "e6730a02-8763-44d1-b0d1-db87835fbd87",
      clientCar: _clientCar?.id,
    );

    final createdOrder = await OrdersService.createOrder(body);

    _order = createdOrder;

    debugPrint("PEDIDO CREADO ${createdOrder.client}");
  }

  void _handleOnProductSelected(
    SimpleProduct selectedProduct,
    BuildContext context,
  ) {
    List<SimpleProduct> currentProductList = _productList;

    bool isProductInList = currentProductList.any(
      (p) => p.getId() == selectedProduct.getId(),
    );

    if (isProductInList) {
      final scaffold = ScaffoldMessenger.of(context);

      scaffold.showSnackBar(
        SnackBar(
          backgroundColor: PartsflowColors.confirm,
          behavior: SnackBarBehavior.floating,
          content: const Text("Este producto ya esta en la lista"),
        ),
      );
    } else {
      currentProductList.add(selectedProduct);

      setState(() {
        _productList = currentProductList;
      });
    }
  }

  void _handleOnClientCarSelected(ClientCar<Car<int>> selectedClientCar) {
    setState(() {
      _clientCar = selectedClientCar;
    });

    debugPrint("MOGUS $selectedClientCar");
  }

  @override
  void initState() {
    super.initState();

    _createOrder();
  }

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
          ClientCarSearch(onClientCarSelected: _handleOnClientCarSelected),
          ProductSearch(
            onProductSelected: (selectedProduct) {
              _handleOnProductSelected(selectedProduct, context);
            },
          ),
          ExpansionTile(
            title: const Text("Productos"),
            children: _productList.map((e) => Text(e.getName())).toList(),
          ),
          ElevatedButton(onPressed: _updateOrder, child: Text("Crear pedido")),
        ],
      ),
    );
  }
}
