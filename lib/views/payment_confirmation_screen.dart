import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../viewmodels/cart_viewmodel.dart';
import '../services/product_service.dart';
import '../widgets/custom_button.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_constants.dart';

class PaymentConfirmationScreen extends StatelessWidget {
  const PaymentConfirmationScreen({Key? key}) : super(key: key);

  String _getPaymentMethodName(String methodId) {
    final methods = ProductService.getPaymentMethods();
    final method = methods.firstWhere(
      (m) => m.id == methodId,
      orElse: () => methods[0],
    );
    return method.name;
  }

  String _generateTransactionId() {
    return 'TXN${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}';
  }

  @override
  Widget build(BuildContext context) {
    final currentDate = DateFormat('MMMM dd, yyyy - HH:mm').format(DateTime.now());
    
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Consumer<CartViewModel>(
          builder: (context, cart, child) {
            final items = List.from(cart.items);
            final subtotal = cart.subtotal;
            final tax = cart.tax;
            final total = cart.total;
            final paymentMethod = cart.selectedPaymentMethod ?? '';
            
            return Container(
              decoration: const BoxDecoration(
                gradient: AppGradients.successGradient,
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    // Success Header
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppConstants.spaceXXXL,
                      ),
                      child: Column(
                        children: [
                          TweenAnimationBuilder(
                            tween: Tween<double>(begin: 0, end: 1),
                            duration: const Duration(milliseconds: 500),
                            builder: (context, double value, child) {
                              return Transform.scale(
                                scale: value,
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.check_circle,
                                    color: AppColors.successGreen,
                                    size: 60,
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: AppConstants.spaceXL),
                          const Text(
                            'Payment Successful!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: AppConstants.spaceSM),
                          const Text(
                            'Your transaction has been completed',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Receipt
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(AppConstants.radiusXXLarge),
                          ),
                        ),
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(AppConstants.spaceXL),
                          child: Column(
                            children: [
                              // Receipt Header
                              const Text(
                                'Receipt',
                                style: TextStyle(
                                  color: AppColors.primaryDark,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: AppConstants.spaceSM),
                              Text(
                                currentDate,
                                style: const TextStyle(
                                  color: AppColors.primaryLight,
                                  fontSize: 13,
                                ),
                              ),
                              
                              const SizedBox(height: AppConstants.spaceXL),
                              
                              // Order Summary
                              Container(
                                padding: const EdgeInsets.all(
                                  AppConstants.radiusLarge,
                                ),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      AppColors.bgPrimary,
                                      AppColors.bgSecondary,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    AppConstants.radiusLarge,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Order Summary',
                                      style: TextStyle(
                                        color: AppColors.primaryDark,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: AppConstants.radiusLarge),
                                    
                                    // Items List
                                    ...items.map((item) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: AppConstants.spaceMD,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    item.product.name,
                                                    style: const TextStyle(
                                                      color: AppColors.primaryDark,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 2),
                                                  Text(
                                                    'Qty: ${item.quantity}',
                                                    style: const TextStyle(
                                                      color: AppColors.primaryLight,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              '\$${item.totalPrice.toStringAsFixed(2)}',
                                              style: const TextStyle(
                                                color: AppColors.primaryDark,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                    
                                    Container(
                                      height: 1,
                                      margin: const EdgeInsets.symmetric(
                                        vertical: AppConstants.spaceMD,
                                      ),
                                      color: AppColors.accentGold.withOpacity(0.3),
                                    ),
                                    
                                    // Price Breakdown
                                    _buildPriceRow(
                                      'Subtotal',
                                      '\$${subtotal.toStringAsFixed(2)}',
                                    ),
                                    const SizedBox(height: AppConstants.spaceSM),
                                    _buildPriceRow(
                                      'Tax (10%)',
                                      '\$${tax.toStringAsFixed(2)}',
                                    ),
                                    
                                    Container(
                                      height: 1,
                                      margin: const EdgeInsets.symmetric(
                                        vertical: AppConstants.spaceMD,
                                      ),
                                      color: AppColors.accentGold.withOpacity(0.3),
                                    ),
                                    
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Total Paid',
                                          style: TextStyle(
                                            color: AppColors.primaryDark,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '\$${total.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                            color: AppColors.successGreen,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              
                              const SizedBox(height: AppConstants.radiusLarge),
                              
                              // Payment Method
                              Container(
                                padding: const EdgeInsets.all(
                                  AppConstants.radiusLarge,
                                ),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      AppColors.bgPrimary,
                                      AppColors.bgSecondary,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    AppConstants.radiusLarge,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Payment Method',
                                      style: TextStyle(
                                        color: AppColors.primaryMedium,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      _getPaymentMethodName(paymentMethod),
                                      style: const TextStyle(
                                        color: AppColors.primaryDark,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              const SizedBox(height: AppConstants.spaceXL),
                              
                              // Transaction ID
                              Column(
                                children: [
                                  const Text(
                                    'Transaction ID',
                                    style: TextStyle(
                                      color: AppColors.primaryLight,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _generateTransactionId(),
                                    style: const TextStyle(
                                      color: AppColors.primaryMedium,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ],
                              ),
                              
                              const SizedBox(height: AppConstants.spaceXXL),
                              
                              // Buttons
                              CustomButton(
                                text: 'Download Receipt',
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Receipt download functionality would be implemented here',
                                      ),
                                      backgroundColor: AppColors.primaryDark,
                                    ),
                                  );
                                },
                                backgroundColor: Colors.white,
                                textColor: AppColors.primaryDark,
                                width: double.infinity,
                                icon: const Icon(
                                  Icons.download,
                                  color: AppColors.primaryDark,
                                ),
                              ),
                              
                              const SizedBox(height: AppConstants.radiusLarge),
                              
                              CustomButton(
                                text: 'Done',
                                onPressed: () {
                                  cart.clearCart();
                                  Navigator.of(context).popUntil(
                                    (route) => route.isFirst,
                                  );
                                },
                                gradient: AppGradients.successGradient,
                                width: double.infinity,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.primaryMedium,
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.primaryDark,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
