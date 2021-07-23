import '../models/product_model.dart';

abstract class IProductHiveDataSource {
  Future<void> cacheProduct(ProductModel product);
  Future<List<ProductModel>> getCachedProducts();
}
