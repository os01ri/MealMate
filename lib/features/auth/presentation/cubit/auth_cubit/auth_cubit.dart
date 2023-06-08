import 'package:bloc/bloc.dart';
import 'package:mealmate/features/auth/data/models/login_response_model.dart';
import 'package:mealmate/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mealmate/features/auth/domain/usecases/login_usecase.dart';
import 'package:mealmate/features/auth/domain/usecases/register_usecase.dart';
import 'package:mealmate/features/auth/domain/usecases/send_password_email_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final _login = LoginUseCase(repository: AuthRepositoryImpl());
  final _register = RegisterUseCase(repository: AuthRepositoryImpl());

  AuthCubit() : super(const AuthState());

  login(LoginUserParams params) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final result = await _login.call(params);

    result.fold(
      (l) => emit(state.copyWith(status: AuthStatus.failed)),
      (r) => emit(state.copyWith(status: AuthStatus.success, user: r.data)),
    );
  }

  register(RegisterUserParams params) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final result = await _register.call(params);

    result.fold(
      (l) => emit(state.copyWith(status: AuthStatus.failed)),
      (r) => emit(state.copyWith(status: AuthStatus.success, user: r.data)),
    );
  }
}
