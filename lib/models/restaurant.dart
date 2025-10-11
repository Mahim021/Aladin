import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'food.dart';
import 'cart_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class Restaurant extends ChangeNotifier {
  final String imagePath;
  final String address;
  final double rating;
  final List<Food> menu;
  List<CartItem> cart = [];
  String? _userId;

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

  // Set current user and load their cart from Firestore
  Future<void> setUser(String? userId) async {
    _userId = userId;
    await _loadCart();
    await _loadCartFromFirestore();
    notifyListeners();
  }

  // Save cart to shared preferences
  Future<void> _saveCart() async {
    if (_userId == null) return;
    final prefs = await SharedPreferences.getInstance();
  final cartJson = jsonEncode(cart.map((item) => cartItemToMap(item)).toList());
    await prefs.setString('cart_${_userId}', cartJson);
  }

  // Load cart from shared preferences
  Future<void> _loadCart() async {
    if (_userId == null) return;
    final prefs = await SharedPreferences.getInstance();
    final cartJson = prefs.getString('cart_${_userId}');
    if (cartJson != null) {
      final List decoded = jsonDecode(cartJson);
      cart = decoded.map<CartItem>((item) => _cartItemFromMap(item)).toList();
    } else {
      cart = [];
    }
  }

  // Save cart to Firestore
  Future<void> _saveCartToFirestore() async {
    if (_userId == null) return;
  final cartData = cart.map((item) => cartItemToMap(item)).toList();
    await FirebaseFirestore.instance.collection('carts').doc(_userId).set({
      'items': cartData,
    });
  }

  // Load cart from Firestore
  Future<void> _loadCartFromFirestore() async {
    if (_userId == null) return;
    final doc = await FirebaseFirestore.instance.collection('carts').doc(_userId).get();
    if (doc.exists && doc.data()?['items'] != null) {
      final List decoded = doc.data()!['items'];
      cart = decoded.map<CartItem>((item) => _cartItemFromMap(item)).toList();
    }
  }

  // Clear cart in Firestore
  Future<void> _clearCartInFirestore() async {
    if (_userId == null) return;
    await FirebaseFirestore.instance.collection('carts').doc(_userId).delete();
  }

  // Clear cart from memory, local storage, and Firestore
  Future<void> clearCart() async {
    cart.clear();
    await _saveCart();
    await _clearCartInFirestore();
    notifyListeners();
  }

  // Remove cart from storage only (on logout)
  Future<void> clearCartStorage() async {
    if (_userId == null) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('cart_${_userId}');
  }

  // Convert CartItem to Map for storage
  Map<String, dynamic> cartItemToMap(CartItem item) {
    return {
      'foodName': item.food.name,
      'foodPrice': item.food.price,
      'foodCategory': item.food.category.index,
      'foodImagePath': item.food.imagePath,
      'foodDescription': item.food.description,
      'quantity': item.quantity,
      'selectedAddons': item.selectedAddons.map((addon, selected) => MapEntry(addon.name, selected)),
    };
  }

  // Convert Map to CartItem
  CartItem _cartItemFromMap(Map item) {
    final food = Food(
      name: item['foodName'],
      imagePath: item['foodImagePath'],
      description: item['foodDescription'],
      price: item['foodPrice'],
      category: FoodCategory.values[item['foodCategory']],
      addons: [], // Addons not needed for cart display
    );
    final selectedAddons = <Addon, bool>{};
    if (item['selectedAddons'] != null) {
      (item['selectedAddons'] as Map<String, dynamic>).forEach((name, selected) {
        selectedAddons[Addon(name: name, price: 0)] = selected;
      });
    }
    return CartItem(food: food, selectedAddons: selectedAddons, quantity: item['quantity']);
  }

  // Add to cart
  Future<void> addToCart(Food food, Map<Addon, bool> selectedAddons) async {
    CartItem newItem = CartItem(
      food: food,
      selectedAddons: selectedAddons,
    );
    cart.add(newItem);
    await _saveCart();
    await _saveCartToFirestore();
    notifyListeners();
  }

  // Remove from cart
  Future<void> removeFromCart(CartItem cartItem) async {
    cart.remove(cartItem);
    await _saveCart();
    await _saveCartToFirestore();
    notifyListeners();
  }

  // Update cart item quantity
  Future<void> updateQuantity(CartItem cartItem, int newQuantity) async {
    cartItem.quantity = newQuantity;
    await _saveCart();
    await _saveCartToFirestore();
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