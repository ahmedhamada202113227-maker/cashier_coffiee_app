import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/product.dart';
import '../core/constants/app_constants.dart';

class CartViewModel extends ChangeNotifier {
  final List<CartItem> _items = [];
  String? _selectedPaymentMethod;

  List<CartItem> get items => _items;
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);
  
  double get subtotal => _items.fold(
    0.0, 
    (sum, item) => sum + item.totalPrice,
  );
  
  double get tax => subtotal * AppConstants.taxRate;
  double get total => subtotal + tax;
  
  String? get selectedPaymentMethod => _selectedPaymentMethod;
  bool get hasItems => _items.isNotEmpty;

  // Add product to cart
  void addToCart(Product product) {
    final existingIndex = _items.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingIndex >= 0) {
      _items[existingIndex].incrementQuantity();
    } else {
      _items.add(CartItem(product: product));
    }
    notifyListeners();
  }

  // Update quantity
  void updateQuantity(String productId, int quantity) {
    final index = _items.indexWhere(
      (item) => item.product.id == productId,
    );

    if (index >= 0) {
      if (quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index].quantity = quantity;
      }
      notifyListeners();
    }
  }

  // Increment quantity
  void incrementQuantity(String productId) {
    final index = _items.indexWhere(
      (item) => item.product.id == productId,
    );

    if (index >= 0) {
      _items[index].incrementQuantity();
      notifyListeners();
    }
  }

  // Decrement quantity
  void decrementQuantity(String productId) {
    final index = _items.indexWhere(
      (item) => item.product.id == productId,
    );

    if (index >= 0) {
      if (_items[index].quantity == 1) {
        _items.removeAt(index);
      } else {
        _items[index].decrementQuantity();
      }
      notifyListeners();
    }
  }

  // Remove item from cart
  void removeItem(String productId) {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  // Clear cart
  void clearCart() {
    _items.clear();
    _selectedPaymentMethod = null;
    notifyListeners();
  }

  // Set payment method
  void setPaymentMethod(String method) {
    _selectedPaymentMethod = method;
    notifyListeners();
  }

  // Complete payment
  void completePayment() {
    // In a real app, this would process the payment
    // For now, we just clear the cart
    clearCart();
  }
}
