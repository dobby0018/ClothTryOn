// import 'package:flutter/material.dart';
// import '../product_details/productdetailpage.dart';

// class HomeTab extends StatefulWidget {
//   const HomeTab({super.key});

//   @override
//   State<HomeTab> createState() => _HomeTabState();
// }

// class _HomeTabState extends State<HomeTab> {
//   String selectedCategory = 'All';

//   // Sample product data
//   final List<Map<String, dynamic>> products = [
//     {
//       'name': 'Louis Vuitton ',
//       'description': 'Exclusive party wear red dress.',
//       'price': 4999.0,
//       'imagePath': 'assets/images/product1.jpg',
//       'seller': 'Louis Vuitton Official India',
//     },
//     {
//       'name': 'Nike',
//       'description': 'Premium dry-fit sports t-shirt.',
//       'price': 2999.0,
//       'imagePath': 'assets/images/product2.jpg',
//       'seller': 'Nike Official Store',
//     },
//     {
//       'name': 'Gap',
//       'description': 'Casual cotton hoodie for all seasons.',
//       'price': 1899.0,
//       'imagePath': 'assets/images/product3.jpg',
//       'seller': 'GAP India',
//     },
//     {
//       'name': 'Chanel',
//       'description': 'Elegant pink designer dress.',
//       'price': 7999.0,
//       'imagePath': 'assets/images/product4.jpg',
//       'seller': 'Chanel India',
//     },
//     {
//       'name': 'Tommy Hilfiger',
//       'description': 'Stylish denim jacket for men.',
//       'price': 3499.0,
//       'imagePath': 'assets/images/product5.jpg',
//       'seller': 'Tommy Hilfiger India',
//     },
//     {
//       'name': 'Gucci',
//       'description': 'Casual t-shirt for men.',
//       'price': 9999.0,
//       'imagePath': 'assets/images/product6.jpg',
//       'seller': 'Gucci India',
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Search Bar
//             Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: TextField(
//                 style: const TextStyle(color: Colors.white),
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Colors.grey[900],
//                   hintText: 'Search "Dresses"',
//                   hintStyle: const TextStyle(color: Colors.white54),
//                   prefixIcon: const Icon(Icons.search, color: Colors.white),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//             ),

//             // Category Tabs with selection highlight
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children:
//                     ['All', 'Men', 'Women', 'Kids'].map((category) {
//                       final bool isSelected = selectedCategory == category;
//                       return GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             selectedCategory = category;
//                           });
//                         },
//                         child: AnimatedContainer(
//                           duration: const Duration(milliseconds: 200),
//                           padding: const EdgeInsets.symmetric(
//                             vertical: 6,
//                             horizontal: 14,
//                           ),
//                           decoration: BoxDecoration(
//                             color:
//                                 isSelected ? Colors.white : Colors.transparent,
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Text(
//                             category,
//                             style: TextStyle(
//                               color: isSelected ? Colors.black : Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       );
//                     }).toList(),
//               ),
//             ),

//             const SizedBox(height: 10),

//             // Products Grid
//             Expanded(
//               child: GridView.builder(
//                 padding: const EdgeInsets.all(12.0),
//                 itemCount: products.length,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   mainAxisSpacing: 12,
//                   crossAxisSpacing: 12,
//                   childAspectRatio: 0.65,
//                 ),
//                 itemBuilder: (context, index) {
//                   final product = products[index];
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder:
//                               (context) => ProductDetailPage(
//                                 name: product['name'],
//                                 seller: product['seller'],
//                                 description: product['description'],
//                                 price: product['price'],
//                                 sizes: ['S', 'M', 'L', 'XL'],
//                                 imagePath: product['imagePath'],
//                               ),
//                         ),
//                       );
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.grey[900],
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Product Image
//                           Expanded(
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: const BorderRadius.vertical(
//                                   top: Radius.circular(12),
//                                 ),
//                                 image: DecorationImage(
//                                   image: AssetImage(product['imagePath']),
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           // Product Info
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   product['name'],
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 Text(
//                                   product['description'],
//                                   style: const TextStyle(
//                                     color: Colors.white54,
//                                     fontSize: 12,
//                                   ),
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 Text(
//                                   "₹${product['price'].toStringAsFixed(0)}",
//                                   style: const TextStyle(
//                                     color: Colors.greenAccent,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../product_details/productdetailpage.dart';
import '../../models/product_model.dart';
import '../../services/api_service.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late Future<List<Product>> _futureProducts;

  @override
  void initState() {
    super.initState();
    _futureProducts = ApiService.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: FutureBuilder<List<Product>>(
          future: _futureProducts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }
            final products = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // (Search bar & category tabs here if you want)
                const SizedBox(height: 10),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(12.0),
                    itemCount: products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.65,
                    ),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailPage(
                                name: product.name,
                                seller: product.seller,
                                description: product.description,
                                price: product.price,
                                sizes: ['S', 'M', 'L', 'XL'],
                                // Pass the network image URL
                                imageId: product.imageId,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Product Image from network
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12),
                                  ),
                                  child: Image.network(
                                    ApiService.getImageUrl(product.imageId),
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                        const Icon(Icons.broken_image, color: Colors.white30),
                                  ),
                                ),
                              ),
                              // Product Info
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      product.description,
                                      style: const TextStyle(
                                          color: Colors.white54, fontSize: 12),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "₹${product.price.toStringAsFixed(0)}",
                                      style: const TextStyle(
                                          color: Colors.greenAccent),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
