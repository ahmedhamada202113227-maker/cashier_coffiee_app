import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/cart_viewmodel.dart';
import '../services/product_service.dart';
import '../widgets/category_card.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_constants.dart';
import 'product_list_screen.dart';
import 'barcode_scanner_screen.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _navigateToProducts(String categoryId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductListScreen(categoryId: categoryId),
      ),
    );
  }

  void _navigateToScanner() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BarcodeScannerScreen(),
      ),
    );
  }

  void _navigateToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CartScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = ProductService.getCategories();
    
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(AppConstants.spaceXL),
                  child: Column(
                    children: [
                      // Top Bar
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                AppConstants.welcomeMessage,
                                style: TextStyle(
                                  color: AppColors.primaryLight,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                AppConstants.appName,
                                style: TextStyle(
                                  color: AppColors.primaryDark,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Consumer<CartViewModel>(
                            builder: (context, cart, child) {
                              return GestureDetector(
                                onTap: _navigateToCart,
                                child: Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: AppConstants.cardShadow,
                                  ),
                                  child: Stack(
                                    children: [
                                      const Center(
                                        child: Icon(
                                          Icons.shopping_cart,
                                          color: AppColors.primaryMedium,
                                          size: 22,
                                        ),
                                      ),
                                      if (cart.itemCount > 0)
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
                                              minWidth: 20,
                                              minHeight: 20,
                                            ),
                                            child: Text(
                                              '${cart.itemCount}',
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
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: AppConstants.spaceXL),
                      
                      // Search Bar
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
                          boxShadow: AppConstants.cardShadow,
                        ),
                        child: TextField(
                          controller: _searchController,
                          decoration: const InputDecoration(
                            hintText: 'Search products...',
                            hintStyle: TextStyle(color: AppColors.primaryLight),
                            prefixIcon: Icon(
                              Icons.search,
                              color: AppColors.primaryLight,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(AppConstants.radiusLarge),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Categories Section
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.spaceXL,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Categories',
                          style: TextStyle(
                            color: AppColors.primaryDark,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: AppConstants.radiusLarge),
                        Expanded(
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: AppConstants.radiusLarge,
                              mainAxisSpacing: AppConstants.radiusLarge,
                              childAspectRatio: 1,
                            ),
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return CategoryCard(
                                category: categories[index],
                                onTap: () => _navigateToProducts(
                                  categories[index].id,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            // Floating Scan Button
            Positioned(
              bottom: AppConstants.spaceXL,
              right: AppConstants.spaceXL,
              child: GestureDetector(
                onTap: _navigateToScanner,
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    gradient: AppGradients.darkGradient,
                    borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
                    boxShadow: AppConstants.buttonShadow,
                  ),
                  child: const Icon(
                    Icons.qr_code_scanner,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
