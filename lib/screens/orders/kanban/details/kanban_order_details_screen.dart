import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:partsflow/core/colors/partsflow_colors.dart';
import 'package:partsflow/screens/orders/kanban/details/tabs/order_info.dart';

class KanbanOrderDetailsScreen extends StatefulWidget {
  final int orderId;

  const KanbanOrderDetailsScreen({super.key, required this.orderId});

  @override
  State<KanbanOrderDetailsScreen> createState() =>
      _KanbanOrderDetailsScreenState();
}

class _KanbanOrderDetailsScreenState extends State<KanbanOrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    /*
    var defaultTabController = DefaultTabController(
        length: 4,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(child: Icon(Icons.info_rounded)),
                Tab(child: Icon(Icons.request_quote_rounded)),
                Tab(child: Icon(Icons.receipt_long_rounded)),
                Tab(child: Icon(Icons.note_alt_rounded)),
              ],
            ),
            Expanded(
              child: Center(
                child: TabBarView(
                  children: [
                    OrderDetailInfo(orderId: widget.orderId),
                    Container(color: OrdersColors.silverGradient[0]),
                    Container(color: OrdersColors.bronzeGradient[0]),
                    Container(color: OrdersColors.trashGradient[0]),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
      */

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: PartsflowColors.secondary,
            ),
          ),
        ),
        backgroundColor: PartsflowColors.primary,
        title: Text(
          "Pedido #${widget.orderId}",
          style: const TextStyle(color: PartsflowColors.secondary),
        ),
      ),
      backgroundColor: PartsflowColors.background,
      body: OrderDetailInfo(orderId: widget.orderId),
    );
  }
}
