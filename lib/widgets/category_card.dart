import 'package:flutter/material.dart';
import '../models/category.dart';
import '../core/constants/app_constants.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;

  const CategoryCard({
    Key? key,
    required this.category,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: category.gradient,
          borderRadius: BorderRadius.circular(AppConstants.radiusXLarge),
          boxShadow: AppConstants.cardShadow,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
              ),
              child: Icon(
                category.icon,
                size: AppConstants.iconLarge,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: AppConstants.spaceMD),
            Text(
              category.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
