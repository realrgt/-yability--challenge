import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../data/models/product_model.dart';

@immutable
abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class GetCachedProducts extends ProductEvent {}

class CacheProduct extends ProductEvent {
  final ProductModel product;

  const CacheProduct(this.product) : super();
}
