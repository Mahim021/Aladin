import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/restaurant.dart';

class MyReceipt extends StatelessWidget {
  const MyReceipt({super.key});

  @override
  Widget build(BuildContext context) {
    final restaurant = Provider.of<Restaurant>(context);

    return Text(
      restaurant.displayCartReceipt(),
      style: const TextStyle(
        fontFamily: 'Courier',
        fontSize: 14,
      ),
    );
  }
}