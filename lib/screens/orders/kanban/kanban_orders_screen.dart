import 'package:flutter/material.dart';
import 'package:partsflow/core/colors/partsflow_colors.dart';
import 'package:partsflow/screens/orders/kanban/widgets/kanban_orders_body.dart';

class KanbanOrdersScreen extends StatelessWidget {
  const KanbanOrdersScreen({super.key});

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
      body: KanbanOrdersBody(),
    );
  }
}
