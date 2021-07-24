import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/add_product.dart';
import '../../domain/usecases/get_products.dart';
import 'bloc.dart';

const cacheFailureMessage = 'Failed to cache data.';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProducts;
  final AddProduct addProduct;

  ProductBloc({
    required this.getProducts,
    required this.addProduct,
  }) : super(ProductInitial());

  @override
  Stream<ProductState> mapEventToState(event) async* {
    if (event is GetCachedProducts) {
      yield ProductInitial();
      yield ProductLoading();
      final failureOrProducts = await getProducts(NoParams());
      yield failureOrProducts.fold(
        (failure) => const ProductError(message: cacheFailureMessage),
        (productsList) => ProductLoaded(products: productsList),
      );
    }
  }
}
