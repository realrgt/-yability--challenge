import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_datasource.dart';

class ProductRepositoryImpl implements IProductRepository {
  final IProductLocalDataSource localDataSource;
  ProductRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final products = await localDataSource.getCachedProducts();
      return Right(products);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> addProduct(Product product) async {
    try {
      await localDataSource.cacheProduct(product);
      return const Right(unit);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }
}
