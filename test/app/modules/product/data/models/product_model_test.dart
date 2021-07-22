import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:yability_challenge/app/modules/product/data/models/product_model.dart';
import 'package:yability_challenge/app/modules/product/domain/entities/product.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tProductModel = ProductModel(name: 'fake-name', price: 1.0);
  final tProductsList = [
    ProductModel(name: 'beans', price: 1.0),
    ProductModel(name: 'meat', price: 10.0),
    ProductModel(name: 'banana', price: 3),
  ];

  test(
    'should be a subclass of Product entity',
    () async {
      // assert
      expect(tProductModel, isA<Product>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model when called',
      () async {
        // arrange
        final List jsonMapList = jsonDecode(fixture('products-list.json'));

        // act
        final result = jsonMapList
            .map((jsonMap) => ProductModel.fromJson(jsonMap))
            .toList();
        // assert
        expect(result, equals(tProductsList));
      },
    );
  });
  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // arrange
        final expectedMap = {
          'name': 'fake-name',
          'price': 1.0,
        };
        // act
        final result = tProductModel.toJson();
        // assert
        expect(result, equals(expectedMap));
      },
    );
  });
}
