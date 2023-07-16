import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/helper/type_defs.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../store/data/models/index_ingredients_response_model.dart';
import '../../data/models/index_recipes_response_model.dart';
import '../../data/models/recipe_step_model.dart';
import '../repositories/recipe_repository.dart';

class AddRecipeUseCase implements UseCase<IndexRecipesResponseModel, AddRecipeParams> {
  final RecipeRepository repository;

  const AddRecipeUseCase({required this.repository});

  @override
  Future<Either<Failure, IndexRecipesResponseModel>> call(AddRecipeParams params) async {
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
  final List<RecipeStepModel> steps;
  final List<IngredientModel> ingredients;

  const AddRecipeParams({
    required this.name,
    required this.description,
    required this.preparationTime,
    required this.imageUrl,
    required this.typeId,
    required this.categoryId,
    required this.steps,
    required this.ingredients,
  });

  @override
  ParamsMap getParams() => {};

  @override //TODO:
  BodyMap getBody() => {
        "name": "Pasta",
        "description": "pasta pasta pasta pasta pasta pasta pasta pasta pasta.",
        "time": 25,
        "url": "http://food.programmer23.store/public/temp/97818791688765069121.png",
        "type_id": 1,
        "category_id": 3,
        "step": [
          {"name": "posdtato", "rank": 1, "description": "dsfsdfsd"},
          {"name": "sddsfsd", "rank": 2, "description": "dsfsd"}
        ],
        "ingredient": [
          {"id": 1, "quantity": 3, "unit_id": 1},
          {"id": 2, "quantity": 5, "unit_id": 1}
        ]
      };
}
