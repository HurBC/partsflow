import 'dart:async';

import 'package:flutter/material.dart';
import 'package:partsflow/components/orders/order_card.dart';
import 'package:partsflow/core/colors/partsflow_colors.dart';
import 'package:partsflow/core/components/sort_tag_filter.dart';
import 'package:partsflow/core/constants/orders.dart';
import 'package:partsflow/data/models/order/enums/order_enums.dart';
import 'package:partsflow/data/models/order/order.dart';
import 'package:partsflow/data/models/order/requests/order_requests.dart';
import 'package:partsflow/services/orders/kanban_service.dart';

class KanbanOrdersScreen extends StatefulWidget {
  const KanbanOrdersScreen({super.key});

  @override
  State<KanbanOrdersScreen> createState() => _KanbanOrdersScreenState();
}

class _KanbanOrdersScreenState extends State<KanbanOrdersScreen> {
  Timer? _timer;

  List<KanbanOrderRepository> _kanbanOrders = [];
  late List<OrderStatusChoices> _kanbanOrdersStatus =
      OrderStatusChoicesExtension.fromKanbanStatus(kanbanStatus[0].value);

  ({String label, String value}) _selectedKanbanOrderStatus = kanbanStatus[0];

  /* Booleans */
  bool _isKanbanLoading = false;

  static const int KANBAN_PAGE_SIZE = 10;

  @override
  void initState() {
    super.initState();

    _timer?.cancel();
    _loadAllOrders();
  }

  @override
  void dispose() {
    print("CLOSING KANBAN");

    _timer?.cancel();

    super.dispose();
  }

  Future<void> _loadAllOrders({bool immediateLoad = false}) async {
    // Cancel the current timer
    _timer?.cancel();

    if (immediateLoad) {
      setState(() {
        _isKanbanLoading = true;
      });

      ListOrders params = ListOrders(
        limit: KANBAN_PAGE_SIZE,
        status: _kanbanOrdersStatus
      );

      final data = await KanbanService.getKanbanOrders(
        params
      );

      setState(() {
        _kanbanOrders = data;
        _isKanbanLoading = false;
      });
    }

    // Create the timer
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      ListOrders params = ListOrders(
        limit: KANBAN_PAGE_SIZE,
        status: _kanbanOrdersStatus
      );

      final data = await KanbanService.getKanbanOrders(
        params
      );

      setState(() {
        _kanbanOrders = data;
      });
    });
  }

  void _handleOnKanbanOrderStatusChange(
    ({String label, String value})? selectedOption,
  ) {
    if (selectedOption == null) return;

    List<OrderStatusChoices> newStatus =
        OrderStatusChoicesExtension.fromKanbanStatus(selectedOption.value);

    debugPrint("SELECTED_VALUE $newStatus");

    setState(() {
      _kanbanOrdersStatus = newStatus;
      _selectedKanbanOrderStatus = selectedOption;
    });

    _loadAllOrders(immediateLoad: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(Icons.menu, color: PartsflowColors.secondary),
          ),
        ),
        backgroundColor: PartsflowColors.primary,
        title: Image.asset("assets/images/logo_partsflow_white.png"),
      ),
      drawer: Drawer(backgroundColor: PartsflowColors.primary),
      backgroundColor: PartsflowColors.background,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Row(
                    children: [
                      DropdownButton<({String label, String value})>(
                        value: _selectedKanbanOrderStatus,
                        items: kanbanStatus.map((status) {
                          return DropdownMenuItem<
                            ({String label, String value})
                          >(value: status, child: Text(status.label));
                        }).toList(),
                        onChanged: _handleOnKanbanOrderStatusChange,
                      ),
                      Spacer(),
                      Text("${_kanbanOrders.length} pedidos"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SortTagFilter(name: "Fecha", onSortTypeChange: (sortType) {
                        debugPrint("SORTED_TYPE $sortType" );
                      },),
                      SortTagFilter(name: "Prioridad", onSortTypeChange: (sortType) {
                        
                      },),
                      SortTagFilter(name: "Plata", onSortTypeChange: (sortType) {
                        
                      },),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: _isKanbanLoading
                  ? Text("Cargando Pedidos")
                  : _kanbanOrders.isEmpty
                  ? Text("Sin pedidos en este estado")
                  : ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: _kanbanOrders.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: OrderCard(order: _kanbanOrders[index]),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
