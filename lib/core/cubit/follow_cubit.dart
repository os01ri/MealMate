import 'package:bloc/bloc.dart';
import 'package:mealmate/core/helper/cubit_status.dart';

import '../../features/recipe/data/repositories/recipe_repository_impl.dart';
import '../../features/recipe/domain/usecases/follow_user_usecase.dart';
import '../../features/recipe/domain/usecases/unfollow_user_usecase.dart';

part 'follow_state.dart';

class FollowCubit extends Cubit<FollowState> {
  final _follow = FollowUserUseCase(repository: RecipeRepositoryImpl());
  final _unFollow = UnFollowUserUseCase(repository: RecipeRepositoryImpl());

  FollowCubit() : super(const FollowState());

  followUser(int userId) async {
    emit(state.copyWith(followStatus: CubitStatus.loading));
    final result = await _follow.call(userId);
    result.fold((l) => emit(state.copyWith(followStatus: CubitStatus.failure)),
        (r) => emit(state.copyWith(followStatus: CubitStatus.success)));
  }

  unFollowUser(int userId) async {
    emit(state.copyWith(followStatus: CubitStatus.loading));
    final result = await _unFollow.call(userId);
    result.fold((l) => emit(state.copyWith(followStatus: CubitStatus.failure)),
        (r) => emit(state.copyWith(followStatus: CubitStatus.success)));
  }
}
