import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'food.dart';
import 'cart_item.dart';

class Restaurant extends ChangeNotifier {
  final String imagePath;
  final String address;
  final double rating;
  final List<Food> menu;
  final List<CartItem> cart = [];

  // A sample menu used when no menu is provided.
  static final List<Food> sampleMenu = [
    Food(
      name: 'Classic Cheeseburger',
      imagePath: 'assets/images/burger1.jpg',
      description: 'A delicious cheese burger with fresh ingredients.',
      price: 0.99,
      category: FoodCategory.burger,
      addons: [
        Addon(name: 'Extra Cheese', price: 0.99),
        Addon(name: 'Bacon', price: 1.49),
      ],
    ),
    Food(
      name: 'Caesar Salad',
      imagePath: 'assets/images/salad1.jpg',
      description: 'Crisp romaine lettuce with Caesar dressing and croutons.',
      price: 4.99,
      category: FoodCategory.salads,
      addons: [
        Addon(name: 'Grilled Chicken', price: 2.99),
        Addon(name: 'Avocado', price: 1.49),
      ],
    ),
    Food(
      name: 'French Fries',
      imagePath: 'assets/images/fries1.jpg',
      description: 'Golden and crispy french fries.',
      price: 2.99,
      category: FoodCategory.sides,
      addons: [
        Addon(name: 'Cheese Sauce', price: 0.99),
        Addon(name: 'Chili', price: 1.49),
      ],
    ),
    Food(
      name: 'Chocolate Cake',
      imagePath: 'assets/images/dessert1.jpg',
      description: 'Rich and moist chocolate cake slice.',
      price: 3.99,
      category: FoodCategory.desserts,
      addons: [
        Addon(name: 'Whipped Cream', price: 0.49),
        Addon(name: 'Ice Cream Scoop', price: 1.49),
      ],
    ),
    Food(
      name: 'Lemonade',
      imagePath: 'assets/images/drink1.jpg',
      description: 'Refreshing homemade lemonade.',
      price: 1.99,
      category: FoodCategory.drinks,
      addons: [
        Addon(name: 'Mint Leaves', price: 0.29),
        Addon(name: 'Extra Ice', price: 0.00),
      ],
    ),
  ];

  Restaurant({
    required this.imagePath,
    required this.address,
    required this.rating,
    List<Food>? menu,
  }) : menu = menu ?? sampleMenu;

  // Add to cart
  void addToCart(Food food, Map<Addon, bool> selectedAddons) {
    CartItem newItem = CartItem(
      food: food,
      selectedAddons: selectedAddons,
    );
    cart.add(newItem);
    notifyListeners();
  }

  // Remove from cart
  void removeFromCart(CartItem cartItem) {
    cart.remove(cartItem);
    notifyListeners();
  }

  // Update cart item quantity
  void updateQuantity(CartItem cartItem, int newQuantity) {
    cartItem.quantity = newQuantity;
    notifyListeners();
  }

  // Get total price
  double getTotalPrice() {
    return cart.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  // Get total item count
  int getTotalItemCount() {
    return cart.fold(0, (sum, item) => sum + item.quantity);
  }

  // Get cart item count
  int getCartItemCount() {
    return cart.length;
  }

  // Clear cart
  void clearCart() {
    cart.clear();
    notifyListeners();
  }

  // Format double value into money
  String _formatPrice(double price) {
    return '\$${price.toStringAsFixed(2)}';
  }

  // Format addons
  String _formatAddons(Map<Addon, bool> selectedAddons) {
    List<String> addonNames = [];
    for (var entry in selectedAddons.entries) {
      if (entry.value) {
        addonNames.add(entry.key.name);
      }
    }
    return addonNames.isEmpty ? '' : 'Add-ons: ${addonNames.join(', ')}';
  }

  // Generate a receipt
  String displayCartReceipt() {
    final receipt = StringBuffer();
    receipt.writeln("Here's your receipt.");
    receipt.writeln();

    // Format the date to include up to seconds only
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    receipt.writeln(formattedDate);
    receipt.writeln();
    receipt.writeln("----------");

    for (final cartItem in cart) {
      receipt.writeln(
          "${cartItem.quantity} x ${cartItem.food.name} - ${_formatPrice(cartItem.food.price)}");
      if (cartItem.selectedAddons.isNotEmpty) {
        receipt.writeln("   ${_formatAddons(cartItem.selectedAddons)}");
      }
      receipt.writeln();
    }

    receipt.writeln("----------");
    receipt.writeln();
    receipt.writeln("Total Items: ${getTotalItemCount()}");
    receipt.writeln("Total Price: ${_formatPrice(getTotalPrice())}");

    return receipt.toString();
  }
}