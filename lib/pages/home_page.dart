import 'package:flutter/material.dart';
import 'package:grocery_shop/components/my_tab_bar.dart';
import 'package:grocery_shop/components/my_current_location.dart';
import 'package:grocery_shop/components/my_description_box.dart';
import 'package:grocery_shop/components/my_drawer.dart';
import 'package:grocery_shop/components/my_silver_app_bar.dart';
import 'package:grocery_shop/models/food.dart';
import 'package:grocery_shop/pages/food_page.dart';
import 'package:grocery_shop/models/restaurant.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // tab controller
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: FoodCategory.values.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Food> _filterMenuByCategory(FoodCategory category, List<Food> fullMenu) {
    return fullMenu.where((food) => food.category == category).toList();
  }

List<Widget> getFoodInThisCategory(List<Food> fullMenu){
  return FoodCategory.values.map((category) {
    final foodsInCategory = _filterMenuByCategory(category, fullMenu);
    return ListView.builder(
      itemCount: foodsInCategory.length,
      itemBuilder: (context, index) {
        final food = foodsInCategory[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FoodPage(
                    food: food,
                    restaurant: Provider.of<Restaurant>(context, listen: false),
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(food.name, style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 2),
                        Text('৳${food.price.toStringAsFixed(2)} BDT', style: Theme.of(context).textTheme.bodyMedium),
                        const SizedBox(height: 6),
                        Text(food.description, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[700])),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(food.imagePath, width: 80, height: 80, fit: BoxFit.cover),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }).toList();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      drawer: const MyDrawer(),
      body: Consumer<Restaurant>(
        builder: (context, restaurant, child) {
          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              MySliverAppBar(
                title: MyTabBar(tabController: _tabController),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    Divider(
                      indent: 25,
                      endIndent: 25,
                      color: Theme.of(context).colorScheme.secondary,
                    ), // Divider

                    // switch
                    MyCurrentLocation(),

                    // description box
                    const MyDescriptionBox(),
                    
                    const SizedBox(height: 60), // Reduced space to prevent icon overlap
                  ],
                ), // Column
              ), // MySliverAppBar
            ],
            body: Consumer<Restaurant>(
              builder: (context, restaurant, child) {
                return TabBarView(
                  controller: _tabController,
                  children: getFoodInThisCategory(restaurant.menu),
                );
              },
            ), // TabBarView
          ); // NestedScrollView
        },
      ), // Consumer
    ); // Scaffold
  }
  
}