import '../../domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required String name,
    required double price,
  }) : super(name: name, price: price);

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'],
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
    };
  }
}
