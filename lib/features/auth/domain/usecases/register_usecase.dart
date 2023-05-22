import 'package:dartz/dartz.dart';
import 'package:mealmate/core/error/failures.dart';
import 'package:mealmate/core/usecase/usecase.dart';
import 'package:mealmate/features/auth/data/models/user_model.dart';
import 'package:mealmate/features/auth/domain/repositories/auth_repository.dart';

import '../entities/user.dart';

class RegisterUseCase implements UseCase<User, RegitserUserParams> {
  final AuthRepository authRepository;

  RegisterUseCase({required this.authRepository});

  @override
  Future<Either<Failure, User>> call(RegitserUserParams body) async {
    return authRepository.registerUser(body: body.getBody());
  }
}

class RegitserUserParams implements UseCaseParams {
  final String email;
  final String password;
  final String userName;

  RegitserUserParams({
    required this.email,
    required this.userName,
    required this.password,
  });

  @override
  Map<String, dynamic> getBody() =>
      {"name": userName, "password": password, "email": email};

  @override
  Map<String, dynamic> getParams() {
    return {};
  }

  @override
  List<Object?> get props => throw UnimplementedError();

  @override
  bool? get stringify => throw UnimplementedError();
}
