import '../models/product.dart';
import '../models/category.dart';
import '../models/payment_method.dart';
import '../core/constants/app_images.dart';
import '../core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ProductService {
  // Get all categories
  static List<Category> getCategories() {
    return [
      Category(
        id: 'coffee',
        name: 'Coffee',
        icon: Icons.coffee,
        gradient: AppGradients.coffeeGradient,
      ),
      Category(
        id: 'drinks',
        name: 'Drinks',
        icon: Icons.local_drink,
        gradient: AppGradients.drinksGradient,
      ),
      Category(
        id: 'snacks',
        name: 'Snacks',
        icon: Icons.bakery_dining,
        gradient: AppGradients.snacksGradient,
      ),
      Category(
        id: 'desserts',
        name: 'Desserts',
        icon: Icons.icecream,
        gradient: AppGradients.dessertsGradient,
      ),
    ];
  }

  // Get products by category
  static List<Product> getProductsByCategory(String categoryId) {
    final allProducts = _getAllProducts();
    return allProducts.where((product) => product.category == categoryId).toList();
  }

  // Get all products
  static List<Product> _getAllProducts() {
    return [
      // Coffee Products
      Product(
        id: 'coffee-1',
        name: 'Cappuccino',
        price: 4.50,
        imageUrl: AppImages.cappuccino,
        category: 'coffee',
      ),
      Product(
        id: 'coffee-2',
        name: 'Latte',
        price: 4.00,
        imageUrl: AppImages.coffeeCup,
        category: 'coffee',
      ),
      Product(
        id: 'coffee-3',
        name: 'Espresso',
        price: 3.00,
        imageUrl: AppImages.espresso,
        category: 'coffee',
      ),
      Product(
        id: 'coffee-4',
        name: 'Americano',
        price: 3.50,
        imageUrl: AppImages.coffeeCup,
        category: 'coffee',
      ),
      Product(
        id: 'coffee-5',
        name: 'Mocha',
        price: 5.00,
        imageUrl: AppImages.cappuccino,
        category: 'coffee',
      ),
      Product(
        id: 'coffee-6',
        name: 'Macchiato',
        price: 4.25,
        imageUrl: AppImages.espresso,
        category: 'coffee',
      ),
      
      // Drinks
      Product(
        id: 'drink-1',
        name: 'Orange Juice',
        price: 3.50,
        imageUrl: AppImages.freshJuice,
        category: 'drinks',
      ),
      Product(
        id: 'drink-2',
        name: 'Smoothie',
        price: 5.50,
        imageUrl: AppImages.freshJuice,
        category: 'drinks',
      ),
      
      // Snacks
      Product(
        id: 'snack-1',
        name: 'Croissant',
        price: 3.00,
        imageUrl: AppImages.croissant,
        category: 'snacks',
      ),
      Product(
        id: 'snack-2',
        name: 'Muffin',
        price: 2.50,
        imageUrl: AppImages.croissant,
        category: 'snacks',
      ),
      
      // Desserts
      Product(
        id: 'dessert-1',
        name: 'Chocolate Cake',
        price: 6.00,
        imageUrl: AppImages.chocolateCake,
        category: 'desserts',
      ),
      Product(
        id: 'dessert-2',
        name: 'Tiramisu',
        price: 7.00,
        imageUrl: AppImages.chocolateCake,
        category: 'desserts',
      ),
    ];
  }

  // Get payment methods
  static List<PaymentMethod> getPaymentMethods() {
    return [
      PaymentMethod(
        id: 'credit-card',
        name: 'Credit Card',
        description: 'Visa / Mastercard',
        icon: Icons.credit_card,
        gradient: AppGradients.creditCardGradient,
      ),
      PaymentMethod(
        id: 'vodafone-cash',
        name: 'Vodafone Cash',
        description: 'Mobile wallet',
        icon: Icons.phone_android,
        gradient: AppGradients.vodafoneGradient,
      ),
      PaymentMethod(
        id: 'etisalat-cash',
        name: 'Etisalat Cash',
        description: 'Mobile wallet',
        icon: Icons.phone_android,
        gradient: AppGradients.etisalatGradient,
      ),
      PaymentMethod(
        id: 'orange-cash',
        name: 'Orange Cash',
        description: 'Mobile wallet',
        icon: Icons.phone_android,
        gradient: AppGradients.orangeGradient,
      ),
    ];
  }

  // Search products
  static List<Product> searchProducts(String query) {
    if (query.isEmpty) return [];
    final allProducts = _getAllProducts();
    return allProducts
        .where((product) => 
            product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
