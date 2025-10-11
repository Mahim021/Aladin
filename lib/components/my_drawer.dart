import "package:flutter/material.dart";
import "package:grocery_shop/components/my_drawer_tile.dart";
import 'package:grocery_shop/services/auth/auth_gate.dart';
import "package:grocery_shop/pages/setting_page.dart";
import "package:grocery_shop/pages/home_page.dart";
import "package:grocery_shop/services/auth/auth_service.dart";
import "package:grocery_shop/pages/cart_page.dart";
import 'package:grocery_shop/pages/order_history_page.dart';
import 'package:provider/provider.dart';
import 'package:grocery_shop/models/restaurant.dart';
// restaurant provider no longer needed here

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout(BuildContext context) async {
    final authService = AuthService();
    // Clear cart storage for current user
    final restaurant = Provider.of<Restaurant>(context, listen: false);
    await restaurant.clearCartStorage();
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Icon(
              Icons.lock_open_rounded,
              size: 80,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Divider(color: Theme.of(context).colorScheme.secondary),
          ),

          // home list tile
          MyDrawerTile(
            text: "H O M E",
            icon: Icons.home,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),

          //settings list tile
          MyDrawerTile(
            text: "S E T T I N G S",
            icon: Icons.settings,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),

          // order history list tile
          MyDrawerTile(
            text: "O R D E R   H I S T O R Y",
            icon: Icons.history,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OrderHistoryPage()),
              );
            },
          ),

          // cart list tile
          MyDrawerTile(
            text: "C A R T",
            icon: Icons.shopping_cart,
            onTap: () {
              print('Cart button pressed');
              Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(
                  builder: (context) => const CartPage(),
                ),
              );
            },
          ),

          const Spacer(), 

          // logout list tile
          MyDrawerTile(
            text: "L O G O U T",
            icon: Icons.logout,
            onTap: () {
              logout(context);
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),

          const SizedBox(height: 25,)
        ],
      ),
    );
  }
}
