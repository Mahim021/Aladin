class Food{
  final String name;
  final String imagePath;
  final String description;
  final double price;
  final FoodCategory category;
  final List<Addon> addons;
 

  Food({
    required this.name,
    required this.imagePath,
    required this.description,
  });
}

enum FoodCategory {
  burger,
  salads,
  sides,
  desserts,
  drinks,
}

class Addon{
  final String name;
  final double price;

  Addon({
    required this.name,
    required this.price,
  });
}