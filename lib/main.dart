import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/cart_viewmodel.dart';
import 'views/home_screen.dart';
import 'core/constants/app_colors.dart';

void main() {
  runApp(
    DevicePreview(
      isToolbarVisible: false,
      enabled: !false,
      builder: (context) => const CashierApp(),
    ),
    );
}

class CashierApp extends StatelessWidget {
  const CashierApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => CartViewModel())],
      child: MaterialApp(
        title: 'Cashier Point',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColors.primaryDark,
          scaffoldBackgroundColor: AppColors.bgPrimary,
          fontFamily: 'Inter',
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.accentGold,
            primary: AppColors.primaryDark,
          ),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
