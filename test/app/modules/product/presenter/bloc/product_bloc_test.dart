import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yability_challenge/app/core/errors/failures.dart';
import 'package:yability_challenge/app/modules/product/domain/entities/product.dart';
import 'package:yability_challenge/app/modules/product/domain/usecases/add_product.dart';
import 'package:yability_challenge/app/modules/product/domain/usecases/get_products.dart';
import 'package:yability_challenge/app/modules/product/presenter/bloc/bloc.dart';

class MockGetProducts extends Mock implements GetProducts {}

class MockAddProduct extends Mock implements AddProduct {}

void main() {
  late ProductBloc bloc;
  late MockGetProducts mockGetProducts;
  late MockAddProduct mockAddProduct;

  setUp(() {
    mockGetProducts = MockGetProducts();
    mockAddProduct = MockAddProduct();
    bloc = ProductBloc(
      getProducts: mockGetProducts,
      addProduct: mockAddProduct,
    );

    registerFallbackValue(NoParams());
  });

  test('initialState should be ProductInitial', () {
    // assert
    expect(bloc.state, equals(ProductInitial()));
  });

  group('getProducts', () {
    final tProductsLits = [
      Product(name: 'banana', price: 1.0),
      Product(name: 'mango', price: 12.0),
      Product(name: 'cake', price: 6.0),
    ];

    test(
      'should get data for the getProducts usecase',
      () async {
        // arrange
        when(() => mockGetProducts(any()))
            .thenAnswer((_) async => Right(tProductsLits));
        // act
        bloc.add(GetCachedProducts());
        await untilCalled(() => mockGetProducts(any()));
        // assert
        verify(() => mockGetProducts(NoParams())).called(1);
      },
    );

    blocTest(
      'should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(() => mockGetProducts(any()))
            .thenAnswer((_) async => Right(tProductsLits));
        return bloc;
      },
      act: (ProductBloc bloc) => bloc.add(GetCachedProducts()),
      expect: () => [
        ProductInitial(),
        ProductLoading(),
        ProductLoaded(products: tProductsLits),
      ],
    );

    blocTest(
      'should emit [Loading, Error] when getting data fails',
      build: () {
        when(() => mockGetProducts(any()))
            .thenAnswer((_) async => Left(CacheFailure()));
        return bloc;
      },
      act: (ProductBloc bloc) => bloc.add(GetCachedProducts()),
      expect: () => [
        ProductInitial(),
        ProductLoading(),
        const ProductError(message: cacheFailureMessage),
      ],
    );
  });
}
