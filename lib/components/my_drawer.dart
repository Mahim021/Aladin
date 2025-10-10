import "package:flutter/material.dart";
import "package:grocery_shop/components/my_drawer_tile.dart";
import "package:grocery_shop/pages/setting_page.dart";
import "package:grocery_shop/pages/home_page.dart";
import "package:grocery_shop/pages/cart_page.dart";
import "package:grocery_shop/models/restaurant.dart";
import "package:provider/provider.dart";

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

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

          // cart list tile
          MyDrawerTile(
            text: "C A R T",
            icon: Icons.shopping_cart,
            onTap: () {
              print('Cart button pressed');
              Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(
                  builder: (context) => CartPage(
                    restaurant: Provider.of<Restaurant>(context, listen: false),
                  ),
                ),
              );
            },
          ),

          // logout list tile
          MyDrawerTile(text: "L O G O U T", icon: Icons.logout, onTap: () {}),
        ],
      ),
    );
  }
}
