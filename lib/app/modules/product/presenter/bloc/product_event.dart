import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/product.dart';

@immutable
abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class GetCachedProducts extends ProductEvent {}

class CacheProduct extends ProductEvent {
  final Product product;

  const CacheProduct(this.product) : super();
}
