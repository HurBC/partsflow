import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';
import 'package:partsflow/core/colors/partsflow_colors.dart';
import 'package:partsflow/screens/orders/kanban/widgets/kanban_orders_body.dart';

class KanbanOrdersScreen extends StatefulWidget {
  const KanbanOrdersScreen({super.key});

  @override
  State<KanbanOrdersScreen> createState() => _KanbanOrdersScreenState();
}

class _KanbanOrdersScreenState extends State<KanbanOrdersScreen> {
  final GlobalKey<KanbanOrdersBodyState> _bodyKey = GlobalKey();

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
      body: KanbanOrdersBody(key: _bodyKey),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: PartsflowColors.secondary,
        foregroundColor: Colors.white,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.add_task),
            label: "New Order",
            onTap: () async {
              await context.push("/orders/kanban/create/order");
              _bodyKey.currentState?.loadAllOrders(immediateLoad: true);
            },
          ),
        ],
      ),
    );
  }
}
