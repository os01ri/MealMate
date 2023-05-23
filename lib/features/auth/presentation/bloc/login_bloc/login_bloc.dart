import 'package:bloc/bloc.dart';
import 'package:mealmate/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mealmate/features/auth/domain/usecases/login_usecase.dart';

import '../../../domain/entities/user.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    final LoginUseCase _loginUseCase =
        LoginUseCase(authRepository: AuthRepositoryImplementaion());
    on<LoginUserEvent>((event, emit) async {
      emit(state.copyWith(status: LoginStatus.loading));
      final result = await _loginUseCase.call(event.body);
      result.fold((l) => emit(state.copyWith(status: LoginStatus.failed)), (r) {
        emit(state.copyWith(status: LoginStatus.success, user: r));
      });
    });
  }
}
