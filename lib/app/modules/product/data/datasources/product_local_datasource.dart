import 'package:yability_challenge/app/modules/product/domain/entities/product.dart';

abstract class IProductLocalDataSource {
  Future<void> cacheProduct(Product product);
  Future<List<Product>> getCachedProducts();
}
