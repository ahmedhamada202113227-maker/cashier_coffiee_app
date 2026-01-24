import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/cart_viewmodel.dart';
import '../services/product_service.dart';
import '../widgets/product_card.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_constants.dart';
import 'cart_screen.dart';

class ProductListScreen extends StatelessWidget {
  final String categoryId;

  const ProductListScreen({
    Key? key,
    required this.categoryId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = ProductService.getProductsByCategory(categoryId);
    final cartViewModel = Provider.of<CartViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          categoryId.toUpperCase(),
          style: const TextStyle(
            color: AppColors.primaryDark,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.shopping_cart,
                  color: AppColors.primaryDark,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ),
                  );
                },
              ),
              if (cartViewModel.itemCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.accentGold,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: Text(
                      '${cartViewModel.itemCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: AppConstants.spaceSM),
        ],
      ),
      body: products.isEmpty
          ? const Center(
              child: Text(
                'No products available',
                style: TextStyle(
                  color: AppColors.primaryLight,
                  fontSize: 16,
                ),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(AppConstants.spaceXL),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: AppConstants.radiusLarge,
                mainAxisSpacing: AppConstants.radiusLarge,
                childAspectRatio: 0.75,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(
                  product: product,
                  onAddToCart: () {
                    cartViewModel.addToCart(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${product.name} added to cart'),
                        duration: const Duration(seconds: 1),
                        backgroundColor: AppColors.successGreen,
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
