import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/cart_viewmodel.dart';
import '../services/product_service.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_constants.dart';

class BarcodeScannerScreen extends StatefulWidget {
  const BarcodeScannerScreen({Key? key}) : super(key: key);

  @override
  State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen>
    with SingleTickerProviderStateMixin {
  bool _isScanning = false;
  bool _scanSuccess = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _simulateScan() {
    setState(() {
      _isScanning = true;
    });

    // Simulate scanning delay
    Future.delayed(const Duration(milliseconds: 1500), () {
      final products = ProductService.getProductsByCategory('coffee');
      if (products.isNotEmpty) {
        final cartViewModel = Provider.of<CartViewModel>(context, listen: false);
        cartViewModel.addToCart(products[0]);

        setState(() {
          _scanSuccess = true;
        });

        Future.delayed(const Duration(milliseconds: 1500), () {
          Navigator.pop(context);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Simulated Camera View
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF2A2A2A), Color(0xFF1A1A1A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          
          // Scanning Frame
          if (!_scanSuccess)
            Center(
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(AppConstants.radiusXLarge),
                ),
                child: Stack(
                  children: [
                    // Corner Brackets
                    Positioned(
                      top: 0,
                      left: 0,
                      child: _buildCornerBracket(true, true),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: _buildCornerBracket(true, false),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: _buildCornerBracket(false, true),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: _buildCornerBracket(false, false),
                    ),
                    
                    // Scanning Line
                    if (_isScanning)
                      AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          return Positioned(
                            top: 250 * _animationController.value - 1,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 2,
                              color: AppColors.accentGold,
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
          
          // Success Indicator
          if (_scanSuccess)
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: AppColors.successGreen,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 60,
                ),
              ),
            ),
          
          // Close Button
          Positioned(
            top: MediaQuery.of(context).padding.top + AppConstants.spaceLG,
            right: AppConstants.spaceXL,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
          
          // Instructions
          Positioned(
            top: MediaQuery.of(context).size.height * 0.35,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
                  ),
                  child: const Icon(
                    Icons.qr_code_scanner,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(height: AppConstants.radiusLarge),
                Text(
                  _scanSuccess
                      ? 'Product Added!'
                      : _isScanning
                          ? 'Scanning...'
                          : 'Scan product barcode',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppConstants.spaceSM),
                Text(
                  _scanSuccess
                      ? 'Redirecting to cart...'
                      : 'Position the barcode in the frame',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          
          // Bottom Button
          Positioned(
            bottom: AppConstants.spaceXXL,
            left: AppConstants.spaceXL,
            right: AppConstants.spaceXL,
            child: GestureDetector(
              onTap: _scanSuccess ? null : _simulateScan,
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  gradient: _scanSuccess ? null : AppGradients.primaryGradient,
                  color: _scanSuccess ? Colors.grey : null,
                  borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
                ),
                child: Center(
                  child: Text(
                    _scanSuccess ? 'Added to Cart' : 'Tap to Simulate Scan',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCornerBracket(bool isTop, bool isLeft) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        border: Border(
          top: isTop
              ? const BorderSide(color: AppColors.accentGold, width: 4)
              : BorderSide.none,
          left: isLeft
              ? const BorderSide(color: AppColors.accentGold, width: 4)
              : BorderSide.none,
          bottom: !isTop
              ? const BorderSide(color: AppColors.accentGold, width: 4)
              : BorderSide.none,
          right: !isLeft
              ? const BorderSide(color: AppColors.accentGold, width: 4)
              : BorderSide.none,
        ),
        borderRadius: BorderRadius.only(
          topLeft: isTop && isLeft
              ? Radius.circular(AppConstants.radiusXLarge)
              : Radius.zero,
          topRight: isTop && !isLeft
              ? Radius.circular(AppConstants.radiusXLarge)
              : Radius.zero,
          bottomLeft: !isTop && isLeft
              ? Radius.circular(AppConstants.radiusXLarge)
              : Radius.zero,
          bottomRight: !isTop && !isLeft
              ? Radius.circular(AppConstants.radiusXLarge)
              : Radius.zero,
        ),
      ),
    );
  }
}
