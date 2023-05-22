import 'package:bloc/bloc.dart';
import 'package:mealmate/features/auth/data/repositories/auth_repository_impl.dart';

import '../../../domain/entities/user.dart';
import '../../../domain/usecases/register_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase _registerUseCase =
      RegisterUseCase(authRepository: AuthRepositoryImplementaion());
  RegisterBloc() : super(const RegisterState()) {
    on<RegisterUserEvent>((RegisterUserEvent event, emit) async {
      emit(state.copyWith(status: RegisterStatus.loading));

      final result = await _registerUseCase.call(event.params);
      result.fold((l) => emit(state.copyWith(status: RegisterStatus.failed)),
          (r) {
        emit(state.copyWith(status: RegisterStatus.success, user: r));

      });
    });
  }
}
