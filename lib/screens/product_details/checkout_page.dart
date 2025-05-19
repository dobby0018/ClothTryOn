import 'package:flutter/material.dart';

class CheckoutPage extends StatelessWidget {
  final String productName;
  final double price;
  final String selectedSize;

  const CheckoutPage({
    super.key,
    required this.productName,
    required this.price,
    required this.selectedSize,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Checkout'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),

            // Product Details
            Text(
              'Product: $productName',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            Text(
              'Size: $selectedSize',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            Text(
              'Price: ₹${price.toStringAsFixed(2)}',
              style: TextStyle(color: Colors.greenAccent, fontSize: 18),
            ),

            Spacer(),

            // Place Order Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder:
                        (_) => AlertDialog(
                          title: Text('Order Confirmed!'),
                          content: Text(
                            'Your order for $productName (Size: $selectedSize) has been placed successfully.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(
                                  context,
                                ).popUntil((route) => route.isFirst);
                              },
                              child: Text('OK'),
                            ),
                          ],
                        ),
                  );
                },
                child: Text("Place Order"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
