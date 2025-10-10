import 'package:flutter/material.dart';
import 'package:grocery_shop/models/restaurant.dart';
import 'package:grocery_shop/models/cart_item.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  final Restaurant restaurant;
  const CartPage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background, // static theme color
      appBar: AppBar(
        title: Text("Cart"),
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      body: Consumer<Restaurant>(
        builder: (context, restaurant, child) {
          final userCart = restaurant.cart;
          if (userCart.isEmpty) {
            return Center(child: Text("Your cart is empty."));
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: userCart.length,
                  itemBuilder: (context, index) {
                    final CartItem item = userCart[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(item.food.imagePath, width: 60, height: 60, fit: BoxFit.cover),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(item.food.name, style: Theme.of(context).textTheme.titleMedium),
                                      Text('৳${item.food.price.toStringAsFixed(2)}', style: Theme.of(context).textTheme.bodyMedium),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove_circle_outline),
                                      onPressed: () {
                                        if (item.quantity > 1) {
                                          restaurant.updateQuantity(item, item.quantity - 1);
                                        } else {
                                          restaurant.removeFromCart(item);
                                        }
                                      },
                                    ),
                                    Text('${item.quantity}', style: Theme.of(context).textTheme.titleMedium),
                                    IconButton(
                                      icon: const Icon(Icons.add_circle_outline),
                                      onPressed: () {
                                        restaurant.updateQuantity(item, item.quantity + 1);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: item.selectedAddons.entries.any((e) => e.value)
                                    ? SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: item.selectedAddons.entries
                                            .where((e) => e.value)
                                            .map((e) => Padding(
                                              padding: const EdgeInsets.only(right: 4.0),
                                              child: Chip(
                                                label: Text(
                                                  '${e.key.name} (৳${e.key.price.toStringAsFixed(2)})',
                                                  style: const TextStyle(fontSize: 12),
                                                ),
                                                visualDensity: VisualDensity.compact,
                                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
                                              ),
                                            ))
                                            .toList(),
                                        ),
                                      )
                                    : Container(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total:",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      '৳${restaurant.getTotalPrice().toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}