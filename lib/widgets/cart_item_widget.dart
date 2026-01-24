import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/cart_item.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_constants.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CartItemWidget({
    Key? key,
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spaceLG),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
        boxShadow: AppConstants.cardShadow,
      ),
      child: Row(
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
            child: CachedNetworkImage(
              imageUrl: item.product.imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                width: 80,
                height: 80,
                color: AppColors.bgSecondary,
                child: const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                width: 80,
                height: 80,
                color: AppColors.bgSecondary,
                child: const Icon(Icons.error),
              ),
            ),
          ),
          
          const SizedBox(width: AppConstants.spaceMD),
          
          // Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  style: const TextStyle(
                    color: AppColors.primaryDark,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppConstants.spaceXS),
                Text(
                  '\$${item.product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: AppColors.accentGold,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: AppConstants.spaceSM),
                
                // Quantity Controls
                Row(
                  children: [
                    GestureDetector(
                      onTap: onDecrement,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppColors.bgSecondary,
                          borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                        ),
                        child: Icon(
                          item.quantity == 1 ? Icons.delete : Icons.remove,
                          color: item.quantity == 1 
                              ? AppColors.errorRed 
                              : AppColors.primaryDark,
                          size: 18,
                        ),
                      ),
                    ),
                    
                    Container(
                      width: 40,
                      alignment: Alignment.center,
                      child: Text(
                        '${item.quantity}',
                        style: const TextStyle(
                          color: AppColors.primaryDark,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    
                    GestureDetector(
                      onTap: onIncrement,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          gradient: AppGradients.primaryGradient,
                          borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Total Price
          Text(
            '\$${item.totalPrice.toStringAsFixed(2)}',
            style: const TextStyle(
              color: AppColors.primaryDark,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
