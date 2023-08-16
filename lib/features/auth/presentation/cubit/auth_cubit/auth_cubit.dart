import 'package:bloc/bloc.dart';
import 'package:mealmate/core/usecase/usecase.dart';
import 'package:mealmate/features/auth/domain/usecases/refresh_token_usecase.dart';

import '../../../data/models/user_model.dart';
import '../../../data/repositories/auth_repository_impl.dart';
import '../../../domain/usecases/change_password_usecase.dart';
import '../../../domain/usecases/check_otp_code.dart';
import '../../../domain/usecases/login_usecase.dart';
import '../../../domain/usecases/register_usecase.dart';
import '../../../domain/usecases/send_otp_code.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final _login = LoginUseCase(repository: AuthRepositoryImpl());
  final _register = RegisterUseCase(repository: AuthRepositoryImpl());
  final _sendOtpCode = SendOtpCodeUseCase(repository: AuthRepositoryImpl());
  final _checkOtpCode = CheckOtpCodeUseCase(repository: AuthRepositoryImpl());
  final _changePassword =
      ChangePasswordUseCase(repository: AuthRepositoryImpl());
  final _refreshTokenUseCase =
      RefreshTokenUseCase(repository: AuthRepositoryImpl());
  AuthCubit() : super(const AuthState());
  refreshToken() async {
    final result = await _refreshTokenUseCase.call(NoParams());
    result.fold((l) => emit(state.copyWith(status: AuthStatus.unAthenticated)),
        (r) {
      emit(state.copyWith(
        status: AuthStatus.success,
      ));
    });
  }

  login(LoginUserParams params) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final result = await _login.call(params);

    result.fold(
      (l) => emit(state.copyWith(status: AuthStatus.failed)),
      (r) => emit(state.copyWith(status: AuthStatus.success, user: r.data)),
    );
  }

  register(RegisterUserParams params) async {
    emit(state.copyWith(
      status: AuthStatus.loading,
    ));

    final result = await _register.call(params);

    result.fold(
      (l) => emit(state.copyWith(status: AuthStatus.failed)),
      (r) => emit(state.copyWith(
          status: AuthStatus.success,
          user: r.data,
          token: r.data!.tokenInfo!.token!)),
    );
  }

  sendOtpCode(String email) async {
    emit(state.copyWith(
      status: AuthStatus.loading,
    ));

    final result = await _sendOtpCode.call(SendOtpParams(email: email));

    result.fold(
      (l) => emit(state.copyWith(status: AuthStatus.failed)),
      (r) => emit(
          state.copyWith(status: AuthStatus.resend, token: r.data!.token!)),
    );
  }

  checkOtpCode(String code, bool isRegister) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final result = await _checkOtpCode
        .call(CheckOtpParams(code: code, isRegister: isRegister));

    result.fold(
      (l) => emit(state.copyWith(status: AuthStatus.failed)),
      (r) => emit(state.copyWith(
          status: AuthStatus.success, token: isRegister ? '' : r.data!.token!)),
    );
  }

  changePassword(String newPassword) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final result =
        await _changePassword(ChangePasswordParams(newPassword: newPassword));

    result.fold(
      (l) => emit(state.copyWith(status: AuthStatus.failed)),
      (r) => emit(state.copyWith(status: AuthStatus.success)),
    );
  }
}
