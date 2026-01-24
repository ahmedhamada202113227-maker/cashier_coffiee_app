import 'package:flutter/material.dart';

class PaymentMethod {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  final Gradient gradient;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.gradient,
  });
}
