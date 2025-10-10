import 'package:flutter/material.dart';
import '../models/food.dart';

class MyFoodTile extends StatelessWidget {
  final Food food;
  final void Function()? onTap;
  
  const MyFoodTile({
    super.key,
    required this.food,
    required this.onTap,
  });
  
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Row(),
        ),
        Row(
          children: [
            // food image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                food.imagePath,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ), // ClipRRect
            
            const SizedBox(width: 10),
            
            // name and price
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // food name
                Text(food.name),
                
                // food price
                Text(food.price.toString()),
                Text(food.description),
                
                const SizedBox(height: 10),
              ],
            ), // Column
          ],
        ), // Row
        
        const SizedBox(height: 10),
      ],
    );
  }
}