import 'package:dartz/dartz.dart';
import 'package:mealmate/core/helper/type_defs.dart';

import '../error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class UseCaseParams {
  BodyMap getBody() => {};

  ParamsMap getParams() => {};
}

class NoParams implements UseCaseParams {
  @override
  BodyMap getBody() => {};

  @override
  ParamsMap getParams() => {};
}
