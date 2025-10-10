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
        top: 25.0,
        bottom: 25.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.secondary),
        ), // BoxDecoration
        
        padding: const EdgeInsets.all(25),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // delivery fee
            Column(
              children: [
                Text('\$0.99', style: myPrimaryTextStyle),
                Text('Delivery fee', style: mySecondaryTextStyle),
              ],
            ), // Column
            // delivery time
            Column(
              children: [
                Text('15-30 min', style: myPrimaryTextStyle),
                Text('Delivery time', style: mySecondaryTextStyle),
              ],
            ), // Column
          ],
        ), // Row
      ), // Container
    );
  }
}
