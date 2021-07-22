import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/product.dart';

abstract class IProductRepository {
  Future<Either<Failure, Product>> addProduct(Product product);
  Future<Either<Failure, List<Product>>> getProducts();
}
