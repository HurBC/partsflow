import 'dart:async';

import 'package:flutter/material.dart';
import 'package:partsflow/components/orders/order_card.dart';
import 'package:partsflow/core/colors/partsflow_colors.dart';
import 'package:partsflow/data/models/order/enums/order_enums.dart';
import 'package:partsflow/data/models/order/order.dart';
import 'package:partsflow/services/orders/kanban_service.dart';

class KanbanOrdersScreen extends StatefulWidget {
  const KanbanOrdersScreen({super.key});

  @override
  State<KanbanOrdersScreen> createState() => _KanbanOrdersScreenState();
}

class _KanbanOrdersScreenState extends State<KanbanOrdersScreen> {
  Timer? _timer;

  List<KanbanOrderRepository> _kanbanOrders = [];
  List<KanbanOrderRepository> _toQuoteOrders = [];
  List<KanbanOrderRepository> _saleOrders = [];

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

  Future<void> _loadAllOrders() async {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      final data = await KanbanService.getKanbanOrders(
        status: [
          OrderStatusChoices.optionsAccepted,
          OrderStatusChoices.purchaseCompleted,
        ],
        limit: _KanbanOrdersScreenState.KANBAN_PAGE_SIZE,
      );

      setState(() {
        _saleOrders = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (context) => IconButton(onPressed: () {
          Scaffold.of(context).openDrawer();
        }, icon: Icon(Icons.menu, color: PartsflowColors.secondary,))),
        backgroundColor: PartsflowColors.primary,
        title: Image.asset("assets/images/logo_partsflow_white.png"),
      ),
      drawer: Drawer(
        backgroundColor: PartsflowColors.primary,
      ),
      backgroundColor: PartsflowColors.background,
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: _saleOrders.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: OrderCard(order: _saleOrders[index]),
          );
        },
      ),
    );
  }
}
