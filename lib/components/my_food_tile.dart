import 'package:flutter/material.dart';
import '../models/food.dart';

class FoodTile extends StatelessWidget {
  final Food food;
  final void Function()? onTap;
  const FoodTile({super.key, required this.food, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
               Expanded(child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(food.name),
                Text(food.price.toString()),
                Text(food.description,
                style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
          ),],),),
          const SizedBox(width: 15),
               Image.asset(food.imagePath, width: 100, height: 120, fit: BoxFit.cover,),
            ],
          ),
        ),
        Divider(color: Theme.of(context).colorScheme.tertiary,
        endIndent: 25,
        indent: 25),
      ],
    );
  }
}