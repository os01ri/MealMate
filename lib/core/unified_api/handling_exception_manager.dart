import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:mealmate/core/extensions/colorful_logging_extension.dart';

import '../error/exceptions.dart';
import '../error/failures.dart';

mixin HandlingExceptionManager {
  Future<Either<Failure, T>> wrapHandling<T>({
    required Future<Right<Failure, T>> Function() tryCall,
  }) async {
    try {
      final right = await tryCall();
      return right;
    } on UnauthenticatedException catch (e) {
      log("<<UnauthenticatedException>>".logRed);
      return Left(UnauthenticatedFailure(e.message));
    } on ValidationException catch (e) {
      log("<<validateRegister>>".logRed);
      return Left(ValidationFailure(e.message));
    } on ServerException catch (e) {
      log("<< ServerException >> ".logRed);
      return Left(ServerFailure(e.message));
    } catch (e) {
      log("<< catch >> error is $e".logRed);
      return const Left(ServerFailure('something went wrong'));
    }
  }
}
