import 'package:flutter/material.dart';
import 'package:grocery_shop/models/food.dart';
import 'package:grocery_shop/models/restaurant.dart';

class FoodPage extends StatefulWidget {
  final Food food;
  final Restaurant restaurant;
  const FoodPage({super.key, required this.food, required this.restaurant});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  Map<Addon, bool> selectedAddons = {};

  @override
  void initState() {
    super.initState();
    for (Addon addon in widget.food.addons) {
      selectedAddons[addon] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.food.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              widget.food.imagePath,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              widget.food.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              '৳${widget.food.price.toStringAsFixed(2)} BDT',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.food.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            Text(
              'Add-ons',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: widget.food.addons.length,
                itemBuilder: (context, index) {
                  Addon addon = widget.food.addons[index];
                  return CheckboxListTile(
                    title: Text(addon.name),
                    subtitle: Text('৳${addon.price.toStringAsFixed(2)} BDT'),
                    value: selectedAddons[addon],
                    onChanged: (bool? value) {
                      setState(() {
                        selectedAddons[addon] = value ?? false;
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Add to cart
                  widget.restaurant.addToCart(widget.food, selectedAddons);
                  
                  // Show confirmation message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${widget.food.name} added to cart!'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                  
                  // Go back to previous page
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Add to Cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}