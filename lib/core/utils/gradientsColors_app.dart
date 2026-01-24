

import 'package:cashier_app/core/utils/colors_app.dart';
import 'package:flutter/material.dart';

abstract class GradientsApp {
  // Primary Gold Gradient (for buttons, accents)
  static const primaryGradient = LinearGradient(
    colors: [ColorsApp.accentGold, ColorsApp.accentGoldDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Dark Gradient (for primary buttons)
  static const darkGradient = LinearGradient(
    colors: [ColorsApp.primaryDark, ColorsApp.primaryMedium],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Success Gradient (for payment confirmation)
  static const successGradient = LinearGradient(
    colors: [ColorsApp.successGreen, ColorsApp.successGreenDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Background Gradient
  static const bgGradient = LinearGradient(
    colors: [Colors.white, ColorsApp.bgPrimary],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Category Gradients
  static const coffeeGradient = LinearGradient(
    colors: [Color(0xFFD4A574), Color(0xFFB8935E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const drinksGradient = LinearGradient(
    colors: [Color(0xFFE8C4A8), Color(0xFFD9B399)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const snacksGradient = LinearGradient(
    colors: [Color(0xFFF5DCC8), Color(0xFFE8C9B3)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const dessertsGradient = LinearGradient(
    colors: [Color(0xFFC9A88A), Color(0xFFB89775)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Payment Method Gradients
  static const creditCardGradient = LinearGradient(
    colors: [ColorsApp.paymentBlue, ColorsApp.paymentBlueDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const vodafoneGradient = LinearGradient(
    colors: [ColorsApp.paymentRed, ColorsApp.paymentRedDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const etisalatGradient = LinearGradient(
    colors: [ColorsApp.paymentGreen, ColorsApp.paymentGreenDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const orangeGradient = LinearGradient(
    colors: [ColorsApp.paymentOrange, ColorsApp.paymentOrangeDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
