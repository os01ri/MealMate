import 'package:bloc/bloc.dart';

import '../../../../../../core/helper/cubit_status.dart';
import '../../../../../../core/usecase/usecase.dart';
import '../../../../auth/data/models/user_model.dart';
import '../../../../recipe/data/models/recipe_model.dart';
import '../../../data/repositories/control_panel_repository_impl.dart';
import '../../../domain/usecases/get_user_info_usecase.dart';
import '../../../domain/usecases/index_followers_usecase.dart';
import '../../../domain/usecases/index_followings_usecase.dart';
import '../../../domain/usecases/index_user_recipes_usecase.dart';
import '../../../domain/usecases/update_user_info_usecase.dart';

part 'control_panel_state.dart';

class ControlPanelCubit extends Cubit<ControlPanelState> {
  final _indexUserRecipesUseCase = IndexUserRecipesUsecase(repository: ControlPanelRepositoryImpl());
  final _getUserInfo = GetUserInfoUseCase(repository: ControlPanelRepositoryImpl());
  final _updateUserInfo = UpdateUserInfoUseCase(repository: ControlPanelRepositoryImpl());
  final _indexFollowers = IndexFollowersUsecase(repository: ControlPanelRepositoryImpl());
  final _indexFollowings = IndexFollowingsUsecase(repository: ControlPanelRepositoryImpl());

  ControlPanelCubit() : super(const ControlPanelState());

  indexMyRecipes() async {
    emit(state.copyWith(recipesStatus: CubitStatus.loading));

    final result = await _indexUserRecipesUseCase(NoParams());

    result.fold(
      (l) => emit(state.copyWith(recipesStatus: CubitStatus.failure)),
      (r) => emit(state.copyWith(recipesStatus: CubitStatus.success, recipes: r.data!)),
    );
  }

  indexFollowers() async {
    emit(state.copyWith(followersStatus: CubitStatus.loading));

    final result = await _indexFollowers(NoParams());

    result.fold(
      (l) => indexFollowers,
      (r) {
        emit(state.copyWith(followers: r.data!));
        __indexFollowings();
      },
    );
  }

  __indexFollowings() async {
    final result = await _indexFollowings(NoParams());

    result.fold(
      (l) => emit(state.copyWith(followersStatus: CubitStatus.failure)),
      (r) => emit(state.copyWith(followersStatus: CubitStatus.success, followings: r.data!)),
    );
  }

  updateUserInfo(UpdateUserInfoParams params) async {
    emit(state.copyWith(updateUserInfoStatus: CubitStatus.loading));

    final result = await _updateUserInfo(params);

    result.fold(
      (l) => emit(state.copyWith(updateUserInfoStatus: CubitStatus.failure)),
      (r) => emit(state.copyWith(updateUserInfoStatus: CubitStatus.success)),
    );

    emit(state.copyWith(updateUserInfoStatus: CubitStatus.initial));
  }

  getUserInfo() async {
    emit(state.copyWith(getUserInfoStatus: CubitStatus.loading));

    final result = await _getUserInfo(NoParams());

    result.fold(
      (l) => emit(state.copyWith(getUserInfoStatus: CubitStatus.failure)),
      (r) => emit(state.copyWith(getUserInfoStatus: CubitStatus.success, user: r.data!)),
    );
  }

  void setUser(UserModel user) {
    emit(state.copyWith(user: user, getUserInfoStatus: CubitStatus.success));
  }

  void dontGetUserInfo() {
    emit(state.copyWith(getUserInfoStatus: CubitStatus.initial));
  }
}
