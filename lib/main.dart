import 'package:flutter/material.dart';
import 'package:grocery_shop/themes/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:grocery_shop/pages/login_page.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
  ));
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(
        onTap: null,
      ),
      theme: Provider.of<ThemeProvider>(context).getTheme(),
    );
  }
}


