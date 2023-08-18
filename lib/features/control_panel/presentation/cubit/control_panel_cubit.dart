import 'package:bloc/bloc.dart';
import 'package:mealmate/core/helper/cubit_status.dart';
import 'package:mealmate/core/usecase/usecase.dart';
import 'package:mealmate/features/control_panel/data/repository/control_panel_repository_implementation.dart';
import 'package:mealmate/features/control_panel/domain/usecase/index_user_recipes_usecase.dart';
import 'package:mealmate/features/recipe/data/models/recipe_model.dart';

part 'control_panel_state.dart';

class ControlPanelCubit extends Cubit<ControlPanelState> {
  ControlPanelCubit() : super(const ControlPanelState());

  final _indexUserRecipesUseCase =
      IndexUserRecipesUsecase(repository: ControlPanelRepoImpl());
  indexMyRecipes() async {
    emit(state.copyWith(status: CubitStatus.loading));
    final result = await _indexUserRecipesUseCase.call(NoParams());
    result.fold(
        (l) => emit(state.copyWith(status: CubitStatus.failure)),
        (r) => emit(
            state.copyWith(status: CubitStatus.success, recipes: r.data!)));
  }
}
