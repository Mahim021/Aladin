import 'package:grocery_shop/models/food.dart';

class CartItem {
  final Food food;
  final Map<Addon, bool> selectedAddons;
  int quantity;

  CartItem({
    required this.food,
    required this.selectedAddons,
    this.quantity = 1,
  });

  double get totalPrice {
    double addonsPrice = selectedAddons.entries
        .where((entry) => entry.value)
        .fold(0.0, (sum, entry) => sum + entry.key.price);
    return (food.price + addonsPrice) * quantity;
  }
}