import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grocery_shop/services/auth/auth_gate.dart';
import 'package:grocery_shop/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:grocery_shop/themes/theme_provider.dart'; 

void main() async {
  // Required before any async operation in main()
  WidgetsFlutterBinding.ensureInitialized();  

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      home: const AuthGate(),
      debugShowCheckedModeBanner: false,
      title: 'Grocery Shop',
      theme: themeProvider.getTheme(), // uses provider theme
    );
  }
}
