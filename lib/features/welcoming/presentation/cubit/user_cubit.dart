import 'package:bloc/bloc.dart';

import '../../../../core/helper/cubit_status.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../auth/data/models/user_model.dart';
import '../../data/repositories/user_info_repository_impl.dart';
import '../../domain/usecases/get_user_info_usecase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final _getUserInfo = GetUserInfoUseCase(repository: UserInfoRepositoryImpl());

  UserCubit() : super(const UserState());

  getUserInfo() async {
    emit(state.copyWith(userInfoStatus: CubitStatus.loading));

    final result = await _getUserInfo(NoParams());

    result.fold(
      (l) => emit(state.copyWith(userInfoStatus: CubitStatus.failure)),
      (r) => emit(state.copyWith(userInfoStatus: CubitStatus.success, user: r.data!)),
    );
  }

  void setUser(UserModel user) {
    emit(state.copyWith(user: user, userInfoStatus: CubitStatus.success));
  }
}
