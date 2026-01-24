import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors (Brown/Coffee)
  static const Color primaryDark = Color(0xFF3D3028);
  static const Color primaryMedium = Color(0xFF6B5744);
  static const Color primaryLight = Color(0xFFA08C7A);
  
  // Accent Colors (Gold)
  static const Color accentGold = Color(0xFFD4A574);
  static const Color accentGoldDark = Color(0xFFB8935E);
  
  // Background Colors
  static const Color bgPrimary = Color(0xFFFAF8F5);
  static const Color bgSecondary = Color(0xFFF5F1ED);
  static const Color bgTertiary = Color(0xFFE8E0D8);
  
  // Success Colors
  static const Color successGreen = Color(0xFF2ECC71);
  static const Color successGreenDark = Color(0xFF27AE60);
  
  // Error Color
  static const Color errorRed = Color(0xFFE74C3C);
  
  // Payment Method Colors
  static const Color paymentBlue = Color(0xFF3498DB);
  static const Color paymentBlueDark = Color(0xFF2980B9);
  static const Color paymentRed = Color(0xFFE74C3C);
  static const Color paymentRedDark = Color(0xFFC0392B);
  static const Color paymentGreen = Color(0xFF27AE60);
  static const Color paymentGreenDark = Color(0xFF229954);
  static const Color paymentOrange = Color(0xFFE67E22);
  static const Color paymentOrangeDark = Color(0xFFD35400);
}

class AppGradients {
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [AppColors.accentGold, AppColors.accentGoldDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient darkGradient = LinearGradient(
    colors: [AppColors.primaryDark, AppColors.primaryMedium],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient successGradient = LinearGradient(
    colors: [AppColors.successGreen, AppColors.successGreenDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient coffeeGradient = LinearGradient(
    colors: [Color(0xFFD4A574), Color(0xFFB8935E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient drinksGradient = LinearGradient(
    colors: [Color(0xFFE8C4A8), Color(0xFFD9B399)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient snacksGradient = LinearGradient(
    colors: [Color(0xFFF5DCC8), Color(0xFFE8C9B3)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient dessertsGradient = LinearGradient(
    colors: [Color(0xFFC9A88A), Color(0xFFB89775)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient creditCardGradient = LinearGradient(
    colors: [AppColors.paymentBlue, AppColors.paymentBlueDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient vodafoneGradient = LinearGradient(
    colors: [AppColors.paymentRed, AppColors.paymentRedDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient etisalatGradient = LinearGradient(
    colors: [AppColors.paymentGreen, AppColors.paymentGreenDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient orangeGradient = LinearGradient(
    colors: [AppColors.paymentOrange, AppColors.paymentOrangeDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
