import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yability_challenge/app/core/errors/exceptions.dart';
import 'package:yability_challenge/app/modules/product/data/datasources/product_hive_datasource_impl.dart';
import 'package:yability_challenge/app/modules/product/data/models/product_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHiveInterface extends Mock implements HiveInterface {}

class MockHiveBox extends Mock implements Box {}

void main() {
  late ProductHiveDataSourceImpl datasource;
  late MockHiveBox mockHiveBox;
  late MockHiveInterface mockHiveInterface;

  setUp(() async {
    mockHiveInterface = MockHiveInterface();
    mockHiveBox = MockHiveBox();
    datasource = ProductHiveDataSourceImpl(hive: mockHiveInterface);
  });

  group('getCachedProducts', () {
    final List jsonProductList = jsonDecode(fixture('products-list.json'));

    test(
      'should return a list products when there are ones in cache',
      () async {
        // arrange
        when(() => mockHiveInterface.openBox(any()))
            .thenAnswer((_) async => mockHiveBox);
        when(() => mockHiveBox.isEmpty).thenReturn(false);
        when(() => mockHiveBox.values).thenReturn(jsonProductList);
        // act
        final expected = jsonProductList
            .map((product) => ProductModel.fromJson(product))
            .toList();

        final result = await datasource.getCachedProducts();

        // assert
        expect(result, expected);
      },
    );

    test(
      'should throw a CacheExeption when there is not a cached value',
      () async {
        // arrange
        when(() => mockHiveInterface.openBox(any()))
            .thenAnswer((_) async => mockHiveBox);
        when(() => mockHiveBox.isEmpty).thenReturn(true);
        // act

        final call = datasource.getCachedProducts;

        // assert
        expect(() => call(), throwsA(isA<CacheException>()));
      },
    );
  });

  group('cacheProduct', () {
    final tProductModel = ProductModel(name: 'test', price: 1);
    test(
      'should call datasource to cache the data',
      () async {
        // arrange
        when(() => mockHiveInterface.openBox(any()))
            .thenAnswer((_) async => mockHiveBox);
        when(() => mockHiveBox.add(any())).thenAnswer((_) async => 1);
        // act
        await datasource.cacheProduct(tProductModel);
        // assert
        final expectedJsonProduct = jsonEncode(tProductModel.toJson());
        verify(() => mockHiveBox.add(expectedJsonProduct)).called(1);
      },
    );
  });
}
