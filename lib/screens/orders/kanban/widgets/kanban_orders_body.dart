import 'dart:async';

import 'package:flutter/material.dart';
import 'package:partsflow/core/components/sort_tag_filter.dart';
import 'package:partsflow/core/constants/orders.dart';
import 'package:partsflow/data/models/order/enums/order_enums.dart';
import 'package:partsflow/data/models/order/order.dart';
import 'package:partsflow/data/models/order/requests/order_requests.dart';
import 'package:partsflow/screens/orders/widgets/order_card.dart';
import 'package:partsflow/services/orders/kanban_service.dart';

const int KANBAN_PAGE_SIZE = 10;

class KanbanOrdersBody extends StatefulWidget {
  const KanbanOrdersBody({super.key});

  @override
  State<KanbanOrdersBody> createState() => _KanbanOrdersBodyState();
}

class _KanbanOrdersBodyState extends State<KanbanOrdersBody> {
  /* States */
  Timer? _timer;

  List<KanbanOrderRepository> _kanbanOrders = [];
  late List<OrderStatusChoices> _kanbanOrdersStatus =
      OrderStatusChoicesExtension.fromKanbanStatus(kanbanStatus[0].value);

  ({String label, String value}) _selectedKanbanOrderStatus = kanbanStatus[0];

  SortTagSortingType _categorySortType = SortTagSortingType.none;
  SortTagSortingType _ticketSortType = SortTagSortingType.none;
  SortTagSortingType _createdAtSortType = SortTagSortingType.none;

  bool _isKanbanLoading = false;

  /* Methods */
  @override
  void initState() {
    super.initState();

    _timer?.cancel();
    _loadAllOrders();
  }

  @override
  void dispose() {
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
        status: _kanbanOrdersStatus,
        sortByCategory: _categorySortType,
        sortByEstimatedTicket: _ticketSortType,
        sortBy: _createdAtSortType
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
        status: _kanbanOrdersStatus,
        sortByCategory: _categorySortType,
        sortByEstimatedTicket: _ticketSortType,
        sortBy: _createdAtSortType
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

    setState(() {
      _kanbanOrdersStatus = newStatus;
      _selectedKanbanOrderStatus = selectedOption;
    });

    _loadAllOrders(immediateLoad: true);
  }

  void _handleOnCategoryChange(SortTagSortingType sortType) {
    setState(() {
      _categorySortType = sortType;
    });

    _loadAllOrders(immediateLoad: true);
  }

  void _handleOnTicketChange(SortTagSortingType sortType) {
    setState(() {
      _ticketSortType = sortType;
    });

    _loadAllOrders(immediateLoad: true);
  }

  void _handleOnDateChange(SortTagSortingType sortType) {
    setState(() {
      _createdAtSortType = sortType;
    });

    _loadAllOrders(immediateLoad: true);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
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
                      SortTagFilter(name: "Fecha", onSortTypeChange: _handleOnDateChange,),
                      SortTagFilter(name: "Prioridad", onSortTypeChange: _handleOnCategoryChange,),
                      SortTagFilter(name: "Plata", onSortTypeChange: _handleOnTicketChange,),
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
      );
  }
}
