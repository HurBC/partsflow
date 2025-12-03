import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:partsflow/core/colors/partsflow_colors.dart';

class CreateOrderScreen extends StatefulWidget {
  const CreateOrderScreen({super.key});

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  @override
  Widget build(BuildContext context) {
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
          "Nuevo pedido",
          style: const TextStyle(color: PartsflowColors.secondary),
        ),
      )
    );
  }
}