import 'package:dartz/dartz.dart';
import 'package:mealmate/features/store/data/models/cart_item_model.dart';
import 'package:mealmate/features/store/data/models/index_ingredients_response_model.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/helper/type_defs.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/index_recipes_response_model.dart';
import '../../data/models/recipe_step_model.dart';
import '../repositories/recipe_repository.dart';

class AddRecipeUseCase
    implements UseCase<IndexRecipesResponseModel, AddRecipeParams> {
  final RecipeRepository repository;

  const AddRecipeUseCase({required this.repository});

  @override
  Future<Either<Failure, IndexRecipesResponseModel>> call(
      AddRecipeParams params) async {
    return repository.indexRecipes(params: params.getParams());
  }
}

class AddRecipeParams implements UseCaseParams {
  final String name;
  final String description;
  final int preparationTime;
  final String imageUrl;
  final int typeId;
  final int categoryId;
  final int feeds;
  final List<RecipeStepModel> steps;
  final List<IngredientModel> ingredients;
  const AddRecipeParams(
      {required this.name,
      required this.description,
      required this.preparationTime,
      required this.imageUrl,
      required this.typeId,
      required this.categoryId,
      required this.steps,
      required this.ingredients,
      required this.feeds});

  @override
  ParamsMap getParams() => {};

  @override //TODO:
  BodyMap getBody() => {
        "name": name,
        "description": description,
        "time": preparationTime,
        "feeds": 1,
        "url": imageUrl,
        "type_id": typeId,
        "category_id": categoryId,
        "step": steps,
        "ingredient": ingredients.map(
            (e) => CartItemModel(model: e, unitId: e.unit!.id!, quantity: 6))
      };
}
