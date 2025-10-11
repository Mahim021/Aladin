import 'package:flutter/material.dart';
import 'package:grocery_shop/components/my_quantity_selector.dart';
import 'package:grocery_shop/models/cart_item.dart';
import 'package:grocery_shop/models/restaurant.dart';
import 'package:provider/provider.dart';

class MyCartTile extends StatelessWidget {
  final CartItem cartItem;

  const MyCartTile({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            // food image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                cartItem.food.imagePath,
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
                Text(cartItem.food.name),

                // food price
                Text('\$${cartItem.food.price.toString()}'),

                const SizedBox(height: 10),

                QuantitySelector(
                  quantity: cartItem.quantity,
                  onIncrement: () {
                    // Increase quantity and update
                    context.read<Restaurant>().updateQuantity(
                      cartItem,
                      cartItem.quantity + 1,
                    );
                  },
                  onDecrement: () {
                    // Decrease quantity or remove from cart
                    if (cartItem.quantity > 1) {
                      context.read<Restaurant>().updateQuantity(
                        cartItem,
                        cartItem.quantity - 1,
                      );
                    } else {
                      context.read<Restaurant>().removeFromCart(cartItem);
                    }
                  },
                ),
              ],
            ), // Column
          ],
        ), // Row
      ],
    );
  }
}
