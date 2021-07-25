import 'package:digit_to_word/digit_to_word.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';

class ProductListWidget extends StatelessWidget {
  final List<Product> products;
  const ProductListWidget({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ListTile(
          title: Text(product.name),
          subtitle: Text(
            '${product.price} MT - ${numberSpeller(product.price).toUpperCase()} MZN',
          ),
        );
      },
    );
  }

  String numberSpeller(double value) {
    return DigitToWord.translate(value.toInt(), withDashes: false);
  }
}
