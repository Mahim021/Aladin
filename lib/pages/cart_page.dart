import 'package:flutter/material.dart';
import 'package:grocery_shop/components/my_button.dart';
import 'package:grocery_shop/components/my_cart_tile.dart';
import 'package:grocery_shop/models/restaurant.dart';
import 'package:provider/provider.dart';
import 'package:grocery_shop/pages/payment_page.dart';

/// CartPage displays the current user's cart using Provider (Restaurant).
/// This file was cleaned to remove merge artifacts and duplicate definitions.
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) {
        final userCart = restaurant.cart;

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            title: const Text('Cart'),
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.inversePrimary,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.delete_forever),
                onPressed: userCart.isEmpty
                    ? null
                    : () async {
                        final confirmed = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Clear cart?'),
                            content: const Text('This will remove all items from your cart.'),
                            actions: [
                              TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                              TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Yes')),
                            ],
                          ),
                        );
                        if (confirmed == true) restaurant.clearCart();
                      },
              )
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: userCart.isEmpty
                    ? Center(child: Text('Your cart is empty', style: Theme.of(context).textTheme.bodyLarge))
                    : ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: userCart.length,
                        itemBuilder: (context, index) => MyCartTile(cartItem: userCart[index]),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total', style: Theme.of(context).textTheme.titleMedium),
                        Text('includes add-ons', style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('৳${restaurant.getTotalPrice().toStringAsFixed(2)}', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: 180,
                          child: MyButton(
                            text: 'Checkout',
                            onTap: userCart.isEmpty
                                ? null
                                : () {
                                    Navigator.push(context, MaterialPageRoute(builder: (_) => const PaymentPage()));
                                  },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}