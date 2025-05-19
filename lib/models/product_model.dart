class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String seller;
  final String category;
  final String imageId;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.seller,
    required this.category,
    required this.imageId,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['_id'],
        name: json['name'],
        description: json['description'],
        price: (json['price'] as num).toDouble(),
        seller: json['seller'],
        category: json['category'],
        imageId: json['image_id'],
      );
}
