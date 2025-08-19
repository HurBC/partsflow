import 'package:flutter/material.dart';
import 'package:partsflow/core/colors/partsflow_colors.dart';

class KanbanOrdersScreen extends StatefulWidget {
  const KanbanOrdersScreen({super.key});

  @override
  State<KanbanOrdersScreen> createState() => _KanbanOrdersScreenState();
}

class _KanbanOrdersScreenState extends State<KanbanOrdersScreen> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/images/logo_partsflow_white.png"),
        backgroundColor: PartsflowColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("Aqui se veran los pedidos"),
      ),
    );
  }
}
