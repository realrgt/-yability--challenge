import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/product_model.dart';
import 'product_hive_datasource.dart';

const cacheProducts = 'CACHED_PRODUCTS';

class ProductHiveDataSourceImpl implements IProductHiveDataSource {
  final HiveInterface hive;
  ProductHiveDataSourceImpl({required this.hive}) {
    _init();
  }

  _init() async {
    final dir = await getApplicationDocumentsDirectory();
    hive.initFlutter(dir.path);
  }

  @override
  Future<List<ProductModel>> getCachedProducts() async {
    var box = await hive.openBox('db');
    if (box.isEmpty) throw CacheException();
    final List products = await box.get(cacheProducts);
    return products.map((product) => ProductModel.fromJson(product)).toList();
  }

  @override
  Future<void> cacheProduct(ProductModel product) async {
    var box = await hive.openBox('db');
    var productMap = jsonEncode(product.toJson());
    await box.add(productMap);
  }
}
