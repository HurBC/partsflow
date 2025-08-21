import 'dart:async';

import 'package:flutter/material.dart';
import 'package:partsflow/core/colors/partsflow_colors.dart';
import 'package:partsflow/data/models/order/order.dart';
import 'package:partsflow/services/orders/kanban_service.dart';

class KanbanOrdersScreen extends StatefulWidget {
  const KanbanOrdersScreen({super.key});

  @override
  State<KanbanOrdersScreen> createState() => _KanbanOrdersScreenState();
}

class _KanbanOrdersScreenState extends State<KanbanOrdersScreen> {
  Timer? _timer;

  List<KanbanOrderRepostory> _kanbanOrders = [];

  OrderStatusChoices _kanbanOrderStatus = OrderStatusChoices.purchaseCompleted;

  @override
  void initState() {
    super.initState();

    _timer?.cancel();
    _loadOrders();
  }

  @override
  void dispose() {
    print("CLOSING KANBAN");

    _timer?.cancel();

    super.dispose();
  }

  Future<void> _loadOrders() async {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      final data = await KanbanService.getKanbanOrders(
        status: _kanbanOrderStatus,
      );

      setState(() {
        _kanbanOrders = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/images/logo_partsflow_white.png"),
        backgroundColor: PartsflowColors.primary,
      ),
      drawer: Container(
        decoration: BoxDecoration(color: Colors.red),
        width: 300,
        child: Column(children: [Text("data")]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _kanbanOrderStatus = OrderStatusChoices.quotationSent;
                    });
                  },
                  child: Text(OrderStatusChoices.quotationSent.toJson()),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _kanbanOrderStatus = OrderStatusChoices.canceled;
                    });
                  },
                  child: Text(OrderStatusChoices.canceled.toJson()),
                ),
              ],
            ),
            Column(
              children: _kanbanOrders
                  .map(
                    (ko) => Text(
                      "${ko.id}-${ko.responsible ?? ko.responsibleData?.id}-${ko.clientDetails.fullName}-${ko.status.toJson()}",
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
