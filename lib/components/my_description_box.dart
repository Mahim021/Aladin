import 'package:flutter/material.dart';

class MyDescriptionBox extends StatelessWidget {
  const MyDescriptionBox({super.key});

  @override
  Widget build(BuildContext context) {
    // textstyle
    var myPrimaryTextStyle = TextStyle(
      color: Theme.of(context).colorScheme.inversePrimary,
    );
    var mySecondaryTextStyle = TextStyle(
      color: Theme.of(context).colorScheme.primary,
    );

    return Padding(
      padding: const EdgeInsets.only(
        left: 25.0,
        right: 25.0,
        bottom: 25.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.secondary),
          borderRadius: BorderRadius.circular(8),
        ), // BoxDecoration
        padding: const EdgeInsets.all(20),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // delivery fee
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('\$0.99', style: myPrimaryTextStyle),
                const SizedBox(height: 2),
                Text('Delivery fee', style: mySecondaryTextStyle),
              ],
            ), // Column
            // delivery time
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('15-30 min', style: myPrimaryTextStyle),
                const SizedBox(height: 2),
                Text('Delivery time', style: mySecondaryTextStyle),
              ],
            ), // Column
          ],
        ), // Row
      ), // Container
    );
  }
}
