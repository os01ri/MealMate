import 'package:dartz/dartz.dart';
import 'package:mealmate/dependency_injection.dart';
import 'package:mealmate/features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../welcoming/data/model/refresh_token_model.dart';
import '../repositories/auth_repository.dart';

class RefreshTokenUseCase
    implements UseCase<RefreshTokenResponseModel, NoParams> {
  final AuthRepository repository;

  const RefreshTokenUseCase({required this.repository});

  @override
  Future<Either<Failure, RefreshTokenResponseModel>> call(NoParams body) async {
    return repository.refreshToken(body: {
      'refreshtoken':
          serviceLocator<AuthCubit>().state.user!.tokenInfo!.refreshToken!
    });
  }
}
