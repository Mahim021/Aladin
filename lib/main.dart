import 'package:flutter/material.dart';
import 'package:grocery_shop/auth/login_or_register.dart';


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
      theme: ThemeData(),
      home: const LoginOrRegister(),
    );
  }
}


