import 'package:flutter/material.dart';
import 'package:grocery_shop/pages/cart_page.dart';
import 'package:grocery_shop/models/restaurant.dart';
import 'package:provider/provider.dart';

class MySliverAppBar extends StatelessWidget {
  final Widget child;
  final Widget title;

  const MySliverAppBar({super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 340,
      collapsedHeight: 120,
      floating: false,
      pinned: true,
      actions: [
        // cart button
        IconButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(
                builder: (context) => CartPage(
                  restaurant: Provider.of<Restaurant>(context, listen: false),
                ),
              ),
            );
          },
          icon: const Icon(Icons.shopping_cart),
        ), // IconButton
      ],
      backgroundColor: Theme.of(context).colorScheme.background,
      foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: const Text("Sunset Diner"),
      flexibleSpace: FlexibleSpaceBar(
        background: child,
        title: title,
        centerTitle: true,
        titlePadding: const EdgeInsets.only(left: 0, right: 0, top: 0),
        expandedTitleScale: 1,
      ), // FlexibleSpaceBar
    ); // SliverAppBar
  }
}
