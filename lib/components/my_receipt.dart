import 'package:flutter/material.dart';

class MyReceipt extends StatelessWidget {
  final String receipt;
  const MyReceipt({super.key, required this.receipt});

  @override
  Widget build(BuildContext context) {
    return Text(
      receipt,
      style: const TextStyle(
        fontFamily: 'Courier',
        fontSize: 14,
      ),
    );
  }
}