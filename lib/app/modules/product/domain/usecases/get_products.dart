import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProducts implements IUseCase<List<Product>, NoParams> {
  final IProductRepository repository;
  GetProducts({required this.repository});

  @override
  Future<Either<Failure, List<Product>>> call(NoParams params) {
    return repository.getProducts();
  }
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
