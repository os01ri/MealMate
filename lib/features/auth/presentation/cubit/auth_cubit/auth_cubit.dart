import 'package:bloc/bloc.dart';
import 'package:mealmate/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mealmate/features/auth/domain/entities/user.dart';
import 'package:mealmate/features/auth/domain/usecases/login_usecase.dart';
import 'package:mealmate/features/auth/domain/usecases/register_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase _login = LoginUseCase(authRepository: AuthRepositoryImpl());
  final RegisterUseCase _register = RegisterUseCase(authRepository: AuthRepositoryImpl());

  AuthCubit() : super(const AuthState());

  login(LoginUserParams params) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final result = await _login.call(params);

    result.fold(
      (l) => emit(state.copyWith(status: AuthStatus.failed)),
      (r) => emit(state.copyWith(status: AuthStatus.success, user: r)),
    );
  }

  register(RegisterUserParams params) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final result = await _register.call(params);

    result.fold(
      (l) => emit(state.copyWith(status: AuthStatus.failed)),
      (r) => emit(state.copyWith(status: AuthStatus.success, user: r)),
    );
  }
}
