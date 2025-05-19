class CartService {
  static final List<Map<String, dynamic>> _cartItems = [];

  static List<Map<String, dynamic>> get cartItems => _cartItems;

  static void addToCart(Map<String, dynamic> item) {
    _cartItems.add(item);
  }

  static void clearCart() {
    _cartItems.clear();
  }

  static double get totalAmount => _cartItems.fold(
    0,
    (sum, item) => sum + (item["price"] * item["quantity"]),
  );
}
