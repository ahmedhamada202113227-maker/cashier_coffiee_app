import 'package:flutter/material.dart';
import '../core/constants/app_constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Gradient? gradient;
  final Color? backgroundColor;
  final Color? textColor;
  final bool enabled;
  final double? width;
  final double? height;
  final Widget? icon;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.gradient,
    this.backgroundColor,
    this.textColor = Colors.white,
    this.enabled = true,
    this.width,
    this.height = 56,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onPressed : null,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: enabled ? gradient : null,
          color: enabled ? backgroundColor : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
          boxShadow: enabled ? AppConstants.buttonShadow : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon!,
              const SizedBox(width: AppConstants.spaceSM),
            ],
            Text(
              text,
              style: TextStyle(
                color: enabled ? textColor : Colors.grey.shade600,
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
