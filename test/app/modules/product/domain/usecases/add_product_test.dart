import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yability_challenge/app/modules/product/domain/entities/product.dart';
import 'package:yability_challenge/app/modules/product/domain/repositories/product_repository.dart';
import 'package:yability_challenge/app/modules/product/domain/usecases/add_product.dart';

class MockProductRepository extends Mock implements IProductRepository {}

void main() {
  late AddProduct usecase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    usecase = AddProduct(repository: mockProductRepository);
  });

  final newProduct = Product(name: 'fake-name', price: 10.0);

  test(
    'should call repository to add a new product',
    () async {
      // arrange
      when(() => mockProductRepository.addProduct(newProduct))
          .thenAnswer((_) async => const Right(unit));
      // act
      final either = await usecase(Params(product: newProduct));
      final result = either.fold((l) => null, (r) => r);
      // assert
      expect(result, equals(unit));
      verify(() => mockProductRepository.addProduct(newProduct)).called(1);
    },
  );
}
