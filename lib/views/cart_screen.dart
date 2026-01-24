import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/cart_viewmodel.dart';
import '../widgets/cart_item_widget.dart';
import '../widgets/custom_button.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_constants.dart';
import 'payment_method_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Shopping Cart',
          style: TextStyle(
            color: AppColors.primaryDark,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Consumer<CartViewModel>(
        builder: (context, cart, child) {
          if (!cart.hasItems) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: AppColors.bgSecondary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.shopping_cart_outlined,
                      size: 48,
                      color: AppColors.primaryLight,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spaceXL),
                  const Text(
                    'Your cart is empty',
                    style: TextStyle(
                      color: AppColors.primaryDark,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spaceSM),
                  const Text(
                    'Add some items to get started',
                    style: TextStyle(
                      color: AppColors.primaryLight,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              // Cart Items List
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(AppConstants.spaceXL),
                  itemCount: cart.items.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: AppConstants.radiusLarge),
                  itemBuilder: (context, index) {
                    final item = cart.items[index];
                    return CartItemWidget(
                      item: item,
                      onIncrement: () =>
                          cart.incrementQuantity(item.product.id),
                      onDecrement: () =>
                          cart.decrementQuantity(item.product.id),
                    );
                  },
                ),
              ),
              
              // Bottom Summary
              Container(
                padding: const EdgeInsets.all(AppConstants.spaceXL),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppConstants.radiusXXLarge),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Price Summary
                    Container(
                      padding: const EdgeInsets.all(AppConstants.radiusLarge),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.bgSecondary, AppColors.bgTertiary],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(
                          AppConstants.radiusLarge,
                        ),
                      ),
                      child: Column(
                        children: [
                          _buildPriceRow(
                            'Subtotal',
                            '\$${cart.subtotal.toStringAsFixed(2)}',
                            false,
                          ),
                          const SizedBox(height: AppConstants.spaceSM),
                          _buildPriceRow(
                            'Tax (10%)',
                            '\$${cart.tax.toStringAsFixed(2)}',
                            false,
                          ),
                          const SizedBox(height: AppConstants.spaceMD),
                          Container(
                            height: 1,
                            color: AppColors.accentGold.withOpacity(0.3),
                          ),
                          const SizedBox(height: AppConstants.spaceMD),
                          _buildPriceRow(
                            'Total',
                            '\$${cart.total.toStringAsFixed(2)}',
                            true,
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: AppConstants.radiusLarge),
                    
                    // Checkout Button
                    CustomButton(
                      text: 'Proceed to Payment',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PaymentMethodScreen(),
                          ),
                        );
                      },
                      gradient: AppGradients.darkGradient,
                      width: double.infinity,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, bool isBold) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isBold ? AppColors.primaryDark : AppColors.primaryMedium,
            fontSize: isBold ? 16 : 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: isBold ? AppColors.accentGold : AppColors.primaryDark,
            fontSize: isBold ? 18 : 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
