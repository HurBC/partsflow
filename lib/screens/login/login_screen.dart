import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:partsflow/core/colors/partsflow_colors.dart';
import 'package:partsflow/data/models/users/login_response.dart';
import 'package:partsflow/screens/orders/kanban/kanban_orders_screen.dart';
import 'package:partsflow/services/user_service.dart';
import 'package:vibration/vibration.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _showPasword = false;
  bool _isLogin = false;

  void _loginIntoPartsflow(BuildContext context) async {
    final scaffold = ScaffoldMessenger.of(context);

    String email = _emailController.text;
    String password =  _passwordController.text;

    if (email.isEmpty) {
      scaffold.showSnackBar(SnackBar(content: Text("El correo es necesario")));

      return;
    }

    if (password.isEmpty) {
      scaffold.showSnackBar(
        SnackBar(content: Text("La contraseña es necesaria")),
      );

      return;
    }

    setState(() {
      _isLogin = true;
    });

    try {
      debugPrint("TRYING TO LOGIN WITH $email $password");

      await AuthService.login(email: email, password: password);

      
      debugPrint("LOGIN WITH $email $password");

      setState(() {
        _isLogin = false;
      });

      scaffold.showSnackBar(
        SnackBar(
          backgroundColor: PartsflowColors.confirm,
          behavior: SnackBarBehavior.floating,
          content: Text("Inicio de sesion exitoso"),
        ),
      );

      context.go("/orders/kanban");
    } on HttpException catch (e) {
      setState(() {
        _isLogin = false;
      });

      if (await Vibration.hasVibrator()) {
        debugPrint("Trying to make the phone vibrate");
        Vibration.vibrate(duration: 500);
      } else {
        
        debugPrint("The phone havent a vibrate system");
      }

      scaffold.showSnackBar(
        SnackBar(
          backgroundColor: Colors.white,
          behavior: SnackBarBehavior.floating,
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: PartsflowColors.error),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  e.message.isNotEmpty == true
                      ? e.message
                      : 'Ocurrió un error inesperado. Intenta nuevamente.',
                  style: const TextStyle(color: PartsflowColors.backgroundDark),
                ),
              ),
            ],
          ),
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PartsflowColors.primary,
      body: Center(
        child: Container(
          width: 300,
          height: 350,
          decoration: BoxDecoration(
            color: PartsflowColors.secondary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "Login in Partsflow",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: PartsflowColors.secondaryDark,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 290,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextField(
                        controller: _emailController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Ingrersa tu email",
                          hintStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: PartsflowColors.secondaryDark,
                          ),
                        ),
                      ),
                      TextField(
                        controller: _passwordController,
                        obscureText: !_showPasword,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Ingrersa tu contaseña",
                          hintStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(
                            Icons.lock_outlined,
                            color: PartsflowColors.secondaryDark,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _showPasword = !_showPasword;
                              });
                            },
                            child: Icon(
                              (_showPasword)
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: PartsflowColors.secondaryDark,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            _loginIntoPartsflow(context);
                          },
                          style: ButtonStyle(
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(6),
                              ),
                            ),
                            backgroundColor: WidgetStateProperty.all(
                              Colors.white,
                            ),
                          ),
                          child: Text(
                            (_isLogin) ? "Ingresando..." : "Ingrersar",
                            style: TextStyle(
                              color: PartsflowColors.secondaryDark,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
