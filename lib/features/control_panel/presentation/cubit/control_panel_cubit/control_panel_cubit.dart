import 'package:bloc/bloc.dart';

import '../../../../../../core/helper/cubit_status.dart';
import '../../../../../../core/usecase/usecase.dart';
import '../../../../recipe/data/models/recipe_model.dart';
import '../../../data/repositories/control_panel_repository_impl.dart';
import '../../../domain/usecases/index_user_recipes_usecase.dart';

part 'control_panel_state.dart';

class ControlPanelCubit extends Cubit<ControlPanelState> {
  ControlPanelCubit() : super(const ControlPanelState());

  final _indexUserRecipesUseCase = IndexUserRecipesUsecase(repository: ControlPanelRepositoryImpl());
  indexMyRecipes() async {
    emit(state.copyWith(status: CubitStatus.loading));
    final result = await _indexUserRecipesUseCase(NoParams());
    result.fold((l) => emit(state.copyWith(status: CubitStatus.failure)),
        (r) => emit(state.copyWith(status: CubitStatus.success, recipes: r.data!)));
  }
}
