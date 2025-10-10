import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:grocery_shop/auth/login_or_register.dart';
import 'package:grocery_shop/models/restaurant.dart';
import 'package:grocery_shop/themes/theme_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(
          create: (context) => Restaurant(
            imagePath: 'assets/images/restaurant.jpg',
            address: 'Kushtia, Bangladesh',
            rating: 4.5,
          ),
        ),
      ],
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
