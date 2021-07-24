import 'package:flutter_modular/flutter_modular.dart';

import 'data/datasources/product_hive_datasource.dart';
import 'data/datasources/product_hive_datasource_impl.dart';
import 'data/repositories/product_repository.dart';
import 'domain/repositories/product_repository.dart';
import 'domain/usecases/add_product.dart';
import 'domain/usecases/get_products.dart';
import 'presenter/bloc/bloc.dart';
import 'presenter/pages/product_home_page.dart';

class ProductModule extends Module {
  @override
  List<Bind> get binds => [
        //? Blocs
        Bind.factory(
          (i) => ProductBloc(getProducts: i(), addProduct: i()),
        ),

        //? Usecases
        Bind.lazySingleton((i) => GetProducts(repository: i())),
        Bind.lazySingleton((i) => AddProduct(repository: i())),

        //? Repositories
        Bind.lazySingleton<IProductRepository>(
          (i) => ProductRepositoryImpl(localDataSource: i()),
        ),

        //? Datasources
        Bind.lazySingleton<IProductHiveDataSource>(
          (i) => ProductHiveDataSourceImpl(hive: i()),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => const ProductHomePage()),
      ];
}
