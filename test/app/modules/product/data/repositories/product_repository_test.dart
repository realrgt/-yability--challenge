import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yability_challenge/app/core/errors/exceptions.dart';
import 'package:yability_challenge/app/core/errors/failures.dart';
import 'package:yability_challenge/app/modules/product/data/datasources/product_local_datasource.dart';
import 'package:yability_challenge/app/modules/product/data/models/product_model.dart';
import 'package:yability_challenge/app/modules/product/data/repositories/product_repository.dart';

class MockProductLocalDataSource extends Mock
    implements IProductLocalDataSource {}

void main() {
  late ProductRepositoryImpl repository;
  late MockProductLocalDataSource mockProductLocalDataSource;

  setUp(() {
    mockProductLocalDataSource = MockProductLocalDataSource();
    repository = ProductRepositoryImpl(
      localDataSource: mockProductLocalDataSource,
    );
  });

  group('getProducts', () {
    final tProduct = ProductModel(name: 'fake-name', price: 1.0);
    final tProductsList = [
      ProductModel(name: 'banana', price: 10.0),
      ProductModel(name: 'sweet', price: 1.0),
    ];

    test(
      'should return a list of products when datasource has cached data',
      () async {
        // arrange
        when(() => mockProductLocalDataSource.getCachedProducts())
            .thenAnswer((_) async => tProductsList);
        // act
        final result = await repository.getProducts();
        // assert
        verify(() => mockProductLocalDataSource.getCachedProducts()).called(1);
        expect(result, equals(Right(tProductsList)));
      },
    );

    test(
      'should return a CacheFailure when cache data is not present',
      () async {
        // arrange
        when(() => mockProductLocalDataSource.getCachedProducts())
            .thenThrow(CacheException());
        // act
        final result = await repository.getProducts();
        // assert
        expect(result, equals(Left(CacheFailure())));
      },
    );
  });

  group('addProduct', () {});
}
