import 'package:dartz/dartz.dart';

import '../errors/failures.dart';

abstract class IUseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}
