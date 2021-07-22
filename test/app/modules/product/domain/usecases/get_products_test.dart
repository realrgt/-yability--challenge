import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yability_challenge/app/modules/product/domain/entities/product.dart';
import 'package:yability_challenge/app/modules/product/domain/repositories/product_repository.dart';
import 'package:yability_challenge/app/modules/product/domain/usecases/get_products.dart';

class MockProductRepository extends Mock implements IProductRepository {}

void main() {
  late GetProducts usecase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    usecase = GetProducts(repository: mockProductRepository);
  });

  final tProductsList = [
    Product(name: 'fake-name', price: 100.2),
    Product(name: 'fake-name2', price: 5),
  ];

  test(
    'should get a list of products from the repository when called',
    () async {
      // arrange
      when(() => mockProductRepository.getProducts()).thenAnswer((_) async => Right(tProductsList));
      // act
      final result = await usecase(NoParams());
      // assert
      expect(result, equals(Right(tProductsList)));
      verify(() => mockProductRepository.getProducts()).called(1);
    },
  );
}
