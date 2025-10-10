
import 'package:flutter/material.dart';

class MyCurrentLocation extends StatelessWidget {
  const MyCurrentLocation({super.key});

  void openLocationSearchBox(BuildContext context) {
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: const Text("Your location"),
        content: const TextField(
          decoration: InputDecoration(
            hintText: "Search for your location",
          ),
        ),
        actions: [
          // cancel button
          MaterialButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),

          // save button
          MaterialButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Save"),
          ),

        ]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.all(25.0),

      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Deliver now",
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
            fontWeight: FontWeight.bold,
          ),
        ),

       GestureDetector(
        onTap: () => openLocationSearchBox(context),
        child:  Row(
          children: [
            //address
            Text("6901 Hollywood Blv"),
            //dropdown menu
            Icon(Icons.keyboard_arrow_down_rounded),
          ],
        )
       )
      ],
    )
      
    );
  }
}