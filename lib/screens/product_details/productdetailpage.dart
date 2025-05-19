// import 'package:flutter/material.dart';
// import '../cart/cart_page.dart';
// import './checkout_page.dart';
// import '../tryon/screens/View3DClothesPage.dart';
// import '../cart/cart_service.dart';

// class ProductDetailPage extends StatefulWidget {
//   final String name;
//   final String seller;
//   final String description;
//   final double price;
//   final List<String> sizes;
//   final String imagePath;

//   const ProductDetailPage({
//     super.key,
//     required this.name,
//     required this.seller,
//     required this.description,
//     required this.price,
//     required this.sizes,
//     required this.imagePath,
//   });

//   @override
//   State<ProductDetailPage> createState() => _ProductDetailPageState();
// }

// class _ProductDetailPageState extends State<ProductDetailPage> {
//   String? selectedSize;

//   void _showSizeAlert() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text("Please select a size."),
//         backgroundColor: Colors.redAccent,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: Text(widget.name),
//         backgroundColor: Colors.black,
//         foregroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             AspectRatio(
//               aspectRatio: 3 / 4,
//               child: Image.asset(widget.imagePath, fit: BoxFit.cover),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.name,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 6),
//                   Text(
//                     "Seller: ${widget.seller}",
//                     style: TextStyle(color: Colors.grey[400]),
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     widget.description,
//                     style: const TextStyle(color: Colors.white70),
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     "₹${widget.price.toStringAsFixed(2)}",
//                     style: const TextStyle(
//                       color: Colors.greenAccent,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 24),
//                   const Text(
//                     "Select Size:",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   Wrap(
//                     spacing: 12,
//                     children:
//                         widget.sizes.map((size) {
//                           final isSelected = selectedSize == size;
//                           return ChoiceChip(
//                             label: Text(
//                               size,
//                               style: TextStyle(
//                                 color: isSelected ? Colors.black : Colors.white,
//                               ),
//                             ),
//                             selected: isSelected,
//                             onSelected: (_) {
//                               setState(() {
//                                 selectedSize = size;
//                               });
//                             },
//                             selectedColor: Colors.white,
//                             backgroundColor: Colors.grey[800],
//                           );
//                         }).toList(),
//                   ),
//                   const SizedBox(height: 32),

//                   /// Add to Cart + Generate VTON
//                   Row(
//                     children: [
//                       Expanded(
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.lightBlue,
//                             foregroundColor: Colors.white,
//                             padding: const EdgeInsets.symmetric(vertical: 16),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),

//                           onPressed: () {
//                             if (selectedSize == null) {
//                               _showSizeAlert();
//                               return;
//                             }

//                             CartService.addToCart({
//                               "image": widget.imagePath,
//                               "brand": widget.seller,
//                               "title": widget.name,
//                               "desc": widget.description,
//                               "price": widget.price,
//                               "quantity": 1,
//                               "size": selectedSize,
//                             });

//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: Text("Added to cart"),
//                                 backgroundColor: Colors.green,
//                               ),
//                             );
//                           },
//                           child: const Text("Add to Cart"),
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.lightBlue,
//                             foregroundColor: Colors.white,
//                             padding: const EdgeInsets.symmetric(vertical: 16),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                           onPressed: () {
//                             if (selectedSize == null) {
//                               _showSizeAlert();
//                               return;
//                             }

//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => const View3DClothesPage(),
//                               ),
//                             );
//                           },
//                           child: const Text("Generate VTON"),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),

//                   /// Buy Now Button
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.lightBlue,
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       onPressed: () {
//                         if (selectedSize == null) {
//                           _showSizeAlert();
//                           return;
//                         }

//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder:
//                                 (context) => CheckoutPage(
//                                   productName: widget.name,
//                                   price: widget.price,
//                                   selectedSize: selectedSize!,
//                                 ),
//                           ),
//                         );
//                       },
//                       child: const Text("Buy Now"),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../cart/cart_page.dart';
import './checkout_page.dart';
import '../tryon/screens/View3DClothesPage.dart';
import '../cart/cart_service.dart';
import '../../services/api_service.dart';         // ← new import

class ProductDetailPage extends StatefulWidget {
  final String name;
  final String seller;
  final String description;
  final double price;
  final List<String> sizes;
  final String imageId;                       // ← now holds the API imageId

  const ProductDetailPage({
    super.key,
    required this.name,
    required this.seller,
    required this.description,
    required this.price,
    required this.sizes,
    required this.imageId,                     // ← renamed
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  String? selectedSize;

  void _showSizeAlert() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Please select a size."),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = ApiService.getImageUrl(widget.imageId);  // ← build URL

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Network-loaded product image
            AspectRatio(
              aspectRatio: 3 / 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (ctx, child, progress) {
                    if (progress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: progress.expectedTotalBytes != null
                            ? progress.cumulativeBytesLoaded /
                                progress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (ctx, err, stack) => const Center(
                    child:
                        Icon(Icons.broken_image, size: 60, color: Colors.white30),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Seller: ${widget.seller}",
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.description,
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "₹${widget.price.toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Select Size:",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 12,
                    children: widget.sizes.map((size) {
                      final isSelected = selectedSize == size;
                      return ChoiceChip(
                        label: Text(
                          size,
                          style: TextStyle(
                            color: isSelected ? Colors.black : Colors.white,
                          ),
                        ),
                        selected: isSelected,
                        onSelected: (_) {
                          setState(() {
                            selectedSize = size;
                          });
                        },
                        selectedColor: Colors.white,
                        backgroundColor: Colors.grey[800],
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 32),

                  // Add to Cart & Generate VTON
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            if (selectedSize == null) {
                              _showSizeAlert();
                              return;
                            }
                            // Store the imageUrl in the cart
                            CartService.addToCart({
                              "imageUrl": imageUrl,
                              "brand": widget.seller,
                              "title": widget.name,
                              "desc": widget.description,
                              "price": widget.price,
                              "quantity": 1,
                              "size": selectedSize,
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Added to cart"),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },
                          child: const Text("Add to Cart"),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            if (selectedSize == null) {
                              _showSizeAlert();
                              return;
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const View3DClothesPage(),
                              ),
                            );
                          },
                          child: const Text("Generate VTON"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Buy Now Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (selectedSize == null) {
                          _showSizeAlert();
                          return;
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckoutPage(
                              productName: widget.name,
                              price: widget.price,
                              selectedSize: selectedSize!,
                            ),
                          ),
                        );
                      },
                      child: const Text("Buy Now"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
