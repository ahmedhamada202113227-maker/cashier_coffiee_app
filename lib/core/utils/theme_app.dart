   
  import 'package:cashier_app/core/utils/colors_app.dart';
import 'package:flutter/material.dart';

abstract class ThemeApp {
  static ThemeData get lightTheme => ThemeData(
        primaryColor: Colors.brown,
        scaffoldBackgroundColor: ColorsApp.errorRed,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.brown,
          foregroundColor: Colors.white,
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.brown,
          textTheme: ButtonTextTheme.primary,
        ),
      );
   

  }
       