import 'package:flutter/material.dart';
import 'package:grocery_shop/auth/login_or_register.dart';
import 'package:grocery_shop/themes/dark_mode.dart';
import 'package:grocery_shop/themes/light_mode.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: darkMode,
      home: const LoginOrRegister(),
    );
  }
}

// 1. Create a login page