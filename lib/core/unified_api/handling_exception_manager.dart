import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:mealmate/dependency_injection.dart';
import 'package:mealmate/features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';

import '../error/exceptions.dart';
import '../error/failures.dart';
import '../extensions/colorful_logging_extension.dart';

mixin HandlingExceptionManager {
  Future<Either<Failure, T>> wrapHandling<T>({
    required Future<Right<Failure, T>> Function() tryCall,
  }) async {
    try {
      final right = await tryCall();
      return right;
    } on UnauthenticatedException catch (e) {
      log("<<UnauthenticatedException>>".logRed);
      serviceLocator<AuthCubit>().refreshToken();
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
