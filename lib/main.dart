import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:partsflow/screens/orders/create_order/create_order_screen.dart';
import 'package:partsflow/screens/orders/kanban/details/kanban_order_details_screen.dart';
import 'package:partsflow/screens/orders/kanban/kanban_orders_screen.dart';
import 'package:partsflow/screens/login/login_screen.dart';

import 'package:partsflow/services/user_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  final bool isLoggedIn = await AuthService.tryAutoLogin();

  runApp(MainApp(isLoggedIn: isLoggedIn));
}

class MainApp extends StatelessWidget {
  final bool isLoggedIn;

  MainApp({super.key, required this.isLoggedIn});

  late final _router = GoRouter(
    initialLocation: isLoggedIn ? "/orders/kanban" : "/login",
    routes: [
      GoRoute(path: "/login", builder: (context, state) => LoginScreen()),
      GoRoute(
        path: "/orders/kanban",
        builder: (context, state) => KanbanOrdersScreen(),
      ),
      GoRoute(
        path: "/orders/kanban/create/order",
        builder: (context, state) => CreateOrderScreen(),
      ),
      GoRoute(
        path: "/orders/kanban/order/:id",
        builder: (context, state) {
          final orderId = int.parse(state.pathParameters["id"] ?? "0");

          return KanbanOrderDetailsScreen(orderId: orderId);
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: _router);
  }
}
