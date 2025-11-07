import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:partsflow/core/colors/partsflow_colors.dart';
import 'package:partsflow/services/orders/orders_service.dart';

class KanbanOrderDetailsScreen extends StatelessWidget {
  final int orderId;

  const KanbanOrderDetailsScreen({super.key, required this.orderId});


  Future<void> _loadOrderDetails() async {
    final data = await OrdersService.getOrder(orderId: orderId);

    debugPrint("ORDER $orderId data $data");
    debugPrint("ORDER ${data.id}");
    debugPrint("ORDER ${data.clientDetails?.firstName}");
    debugPrint("ORDER ${data.ticket}");
    debugPrint("ORDER ${data.estimatedTicket}");
  }

  @override
  Widget build(BuildContext context) {
    _loadOrderDetails();
    
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () => context.pop(),
            icon: Icon(Icons.arrow_back_rounded, color: PartsflowColors.secondary),
          ),
        ),
        backgroundColor: PartsflowColors.primary,
        title: Image.asset("assets/images/logo_partsflow_white.png"),
      ),
      backgroundColor: PartsflowColors.background,
      body: Text("ORDER $orderId"),
    );
  }
}