import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/cart_viewmodel.dart';
import '../services/product_service.dart';
import '../widgets/custom_button.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_constants.dart';
import 'payment_confirmation_screen.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paymentMethods = ProductService.getPaymentMethods();
    
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
          'Payment Method',
          style: TextStyle(
            color: AppColors.primaryDark,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Consumer<CartViewModel>(
        builder: (context, cart, child) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppConstants.spaceXL),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Select your preferred payment method',
                        style: TextStyle(
                          color: AppColors.primaryMedium,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: AppConstants.spaceXL),
                      
                      // Payment Methods List
                      ...paymentMethods.map((method) {
                        final isSelected = cart.selectedPaymentMethod == method.id;
                        return Padding(
                          padding: const EdgeInsets.only(
                            bottom: AppConstants.radiusLarge,
                          ),
                          child: GestureDetector(
                            onTap: () => cart.setPaymentMethod(method.id),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  AppConstants.radiusLarge,
                                ),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color: AppColors.accentGold
                                              .withOpacity(0.3),
                                          blurRadius: 16,
                                          offset: const Offset(0, 4),
                                        ),
                                      ]
                                    : AppConstants.cardShadow,
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(
                                  AppConstants.radiusLarge,
                                ),
                                decoration: BoxDecoration(
                                  gradient: method.gradient,
                                  borderRadius: BorderRadius.circular(
                                    AppConstants.radiusLarge,
                                  ),
                                  border: isSelected
                                      ? Border.all(
                                          color: AppColors.accentGold,
                                          width: 3,
                                        )
                                      : null,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 56,
                                      height: 56,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(
                                          isSelected ? 0.3 : 0.2,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          AppConstants.radiusMedium,
                                        ),
                                      ),
                                      child: Icon(
                                        method.icon,
                                        color: Colors.white,
                                        size: 28,
                                      ),
                                    ),
                                    const SizedBox(width: AppConstants.radiusLarge),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            method.name,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            method.description,
                                            style: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.8),
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.transparent,
                                      ),
                                      child: isSelected
                                          ? Container(
                                              margin: const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                gradient: method.gradient,
                                              ),
                                            )
                                          : null,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      
                      const SizedBox(height: AppConstants.spaceLG),
                      
                      // Info Box
                      Container(
                        padding: const EdgeInsets.all(AppConstants.radiusLarge),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFFF9F0), AppColors.bgSecondary],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(
                            AppConstants.radiusLarge,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: AppColors.accentGold,
                                borderRadius: BorderRadius.circular(
                                  AppConstants.radiusSmall,
                                ),
                              ),
                              child: const Icon(
                                Icons.info_outline,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: AppConstants.spaceMD),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Secure Payment',
                                    style: TextStyle(
                                      color: AppColors.primaryDark,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'All transactions are encrypted and secure. Your payment information is never stored.',
                                    style: TextStyle(
                                      color: AppColors.primaryMedium,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Bottom Button
              Container(
                padding: const EdgeInsets.all(AppConstants.spaceXL),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: CustomButton(
                  text: cart.selectedPaymentMethod != null
                      ? 'Confirm Payment'
                      : 'Select Payment Method',
                  onPressed: () {
                    if (cart.selectedPaymentMethod != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const PaymentConfirmationScreen(),
                        ),
                      );
                    }
                  },
                  gradient: AppGradients.successGradient,
                  width: double.infinity,
                  enabled: cart.selectedPaymentMethod != null,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
