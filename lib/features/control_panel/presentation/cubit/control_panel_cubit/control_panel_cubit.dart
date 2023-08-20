import 'package:bloc/bloc.dart';
import 'package:mealmate/core/ui/toaster.dart';
import 'package:mealmate/features/control_panel/data/models/restrictions_response_model.dart';
import 'package:mealmate/features/control_panel/domain/usecases/add_restriction_usecase.dart';
import 'package:mealmate/features/control_panel/domain/usecases/delete_restriction_usecase.dart';
import 'package:mealmate/features/control_panel/domain/usecases/index_restrictions_usecase.dart';
import 'package:mealmate/features/store/data/repositories/store_repository_impl.dart';
import 'package:mealmate/features/store/domain/usecases/index_ingredients_usecase.dart';

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
  final _indexUserRecipesUseCase =
      IndexUserRecipesUsecase(repository: ControlPanelRepositoryImpl());
  final _getUserInfo =
      GetUserInfoUseCase(repository: ControlPanelRepositoryImpl());
  final _updateUserInfo =
      UpdateUserInfoUseCase(repository: ControlPanelRepositoryImpl());
  final _indexFollowers =
      IndexFollowersUsecase(repository: ControlPanelRepositoryImpl());
  final _indexFollowings =
      IndexFollowingsUsecase(repository: ControlPanelRepositoryImpl());
  final _indexRestrictions =
      IndexRestrictionsUsecase(repository: ControlPanelRepositoryImpl());
  final _addRestriction =
      AddRestrictionUsecase(repository: ControlPanelRepositoryImpl());
  final _deleteRestriction =
      DeleteRestrictionUsecase(repository: ControlPanelRepositoryImpl());
  ControlPanelCubit() : super(const ControlPanelState());
  final _indexIngredientsUseCase =
      IndexIngredientsUseCase(repository: StoreRepositoryImpl());
  indexIngredients() async {
    emit(state.copyWith(indexRestrictionsStatus: CubitStatus.loading));

    final result =
        await _indexIngredientsUseCase.call(const IndexIngredientsParams());

    result.fold(
      (l) => emit(state.copyWith(indexRestrictionsStatus: CubitStatus.failure)),
      (r) => emit(state.copyWith(
          indexRestrictionsStatus: CubitStatus.success,
          restrictions: r.data!
              .map((e) => RestrictionModel(
                  id: e.id,
                  hash: e.hash,
                  name: e.name,
                  price: e.price,
                  priceBy: e.priceBy,
                  url: e.url))
              .toList())),
    );
  }

  indexMyRecipes() async {
    emit(state.copyWith(recipesStatus: CubitStatus.loading));

    final result = await _indexUserRecipesUseCase(NoParams());

    result.fold(
      (l) => emit(state.copyWith(recipesStatus: CubitStatus.failure)),
      (r) => emit(
          state.copyWith(recipesStatus: CubitStatus.success, recipes: r.data!)),
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
      (r) => emit(state.copyWith(
          followersStatus: CubitStatus.success, followings: r.data!)),
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
      (r) => emit(state.copyWith(
          getUserInfoStatus: CubitStatus.success, user: r.data!)),
    );
  }

  void setUser(UserModel user) {
    emit(state.copyWith(user: user, getUserInfoStatus: CubitStatus.success));
  }

  void dontGetUserInfo() {
    emit(state.copyWith(getUserInfoStatus: CubitStatus.initial));
  }

  indexRestrictions() async {
    emit(state.copyWith(indexRestrictionsStatus: CubitStatus.loading));
    final result = await _indexRestrictions.call(NoParams());
    result.fold(
        (l) =>
            emit(state.copyWith(indexRestrictionsStatus: CubitStatus.failure)),
        (r) => emit(state.copyWith(
            indexRestrictionsStatus: CubitStatus.success,
            restrictions: r.data!)));
  }

  addRestriction(int id) async {
    Toaster.showLoading();
    final result = await _addRestriction.call(AddRestrictionParams(id: id));
    result.fold((l) => Toaster.closeLoading(), (r) {
      Toaster.closeLoading();
    });
  }

  deleteRestriction(int id) async {
    Toaster.showLoading();
    final result =
        await _deleteRestriction.call(DeleteRestrictionParams(id: id));
    result.fold((l) {
      Toaster.closeLoading();
    }, (r) {
      Toaster.closeLoading();
      emit(state.copyWith(
          restrictions: List.of(state.restrictions)
            ..removeWhere((element) => element.id == id)));
    });
  }
}
