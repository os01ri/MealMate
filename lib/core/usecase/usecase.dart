import 'package:dartz/dartz.dart';

import '../error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class UseCaseParams {
  Map<String, dynamic> getBody() => {};

  Map<String, dynamic> getParams() => {};
}

class NoParams implements UseCaseParams {
  @override
  Map<String, dynamic> getBody() => {};

  @override
  Map<String, dynamic> getParams() => {};
}
