import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class AddProduct implements IUseCase<Unit, Params> {
  final IProductRepository repository;
  AddProduct({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(Params params) {
    return repository.addProduct(params.product);
  }
}

class Params extends Equatable {
  final Product product;
  const Params({required this.product});

  @override
  List<Object> get props => [product];
}
