import 'package:equatable/equatable.dart';

import '../../domain/entities/product.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;

  const ProductLoaded({required this.products}) : super();
}

class ProductError extends ProductState {
  final String message;

  const ProductError({required this.message}) : super();
}

class ProductCached extends ProductState {}
