import 'package:bloc/bloc.dart';
import 'package:mealmate/features/profile/domain/usecase/show_user_info_usecase.dart';

import '../../../../core/helper/cubit_status.dart';
import '../../data/model/show_user_model.dart';
import '../../data/repository/profile_repo_impl.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState());
  final showUserUsecase = ShowUserInfoUseCase(repository: ProfileRepoImpl());
  showUser(int id) async {
    emit(state.copyWith(showUserStatus: CubitStatus.loading));
    final result = await showUserUsecase.call(id);
    result.fold(
        (l) => emit(state.copyWith(showUserStatus: CubitStatus.failure)),
        (r) => emit(state.copyWith(
            user: r.user!, showUserStatus: CubitStatus.success)));
  }
}
