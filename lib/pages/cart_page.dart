import 'package:flutter/material.dart';
import 'package:grocery_shop/components/my_button.dart';
import 'package:grocery_shop/components/my_cart_tile.dart';
import 'package:grocery_shop/models/restaurant.dart';
import 'package:grocery_shop/pages/payment_page.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) {
        final userCart = restaurant.cart;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Cart"),
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.inversePrimary,
            actions: [
              // Clear cart button
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Are you sure you want to clear the cart?"),
                      actions: [
                        // Cancel button
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel"),
                        ),
                        // Yes button
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            restaurant.clearCart();
                          },
                          child: const Text("Yes"),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
          body: Column(
            children: [
              // List of cart items
              Expanded(
                child: userCart.isEmpty
                    ? const Center(
                        child: Text("Cart is empty..."),
                      )
                    : ListView.builder(
                        itemCount: userCart.length,
                        padding: const EdgeInsets.all(10),
                        itemBuilder: (context, index) {
                          // Get individual cart item
                          final cartItem = userCart[index];

                          // Return cart tile UI
                          return MyCartTile(cartItem: cartItem);
                        },
                      ),
              ),

              // Button to pay
              if (userCart.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      // Total price
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          Text(
                            '\$${restaurant.getTotalPrice().toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      
                      // Checkout button
                      MyButton(
                        text: "Go to checkout",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PaymentPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}