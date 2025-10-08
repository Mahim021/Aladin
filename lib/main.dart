import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:grocery_shop/auth/login_or_register.dart';
import 'package:grocery_shop/themes/dark_mode.dart';
import 'package:grocery_shop/themes/light_mode.dart';
import 'package:grocery_shop/themes/theme_provider.dart'; // <-- import ThemeProvider

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grocery Shop',
      theme: themeProvider.getTheme(), // uses provider theme
      home: const LoginOrRegister(),
    );
  }
}
