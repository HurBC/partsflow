import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:partsflow/screens/orders/kanban/details/kanban_order_details_screen.dart';
import 'package:partsflow/screens/orders/kanban/kanban_orders_screen.dart';
import 'package:partsflow/screens/login/login_screen.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final _router = GoRouter(
    initialLocation: "/login",
    routes: [
      GoRoute(
        path: "/login",
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: "/orders/kanban",
        builder: (context, state) => KanbanOrdersScreen(),
      ),
      GoRoute(
        path: "/orders/kanban/order/:id",
        builder: (context, state)  {
          final orderId = int.parse(state.pathParameters["id"] ?? "0");

          return KanbanOrderDetailsScreen(orderId: orderId);
        },
      ),
  ]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
