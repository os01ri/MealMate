import 'package:dartz/dartz.dart';
import 'package:mealmate/core/models/no_response_model.dart';
import 'package:mealmate/features/store/data/models/cart_item_model.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/helper/type_defs.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/recipe_step_model.dart';
import '../repositories/recipe_repository.dart';

class AddRecipeUseCase implements UseCase<NoResponse, AddRecipeParams> {
  final RecipeRepository repository;

  const AddRecipeUseCase({required this.repository});

  @override
  Future<Either<Failure, NoResponse>> call(AddRecipeParams params) async {
    return repository.addRecipe(recipe: params.getBody());
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
  final List<CartItemModel> ingredients;
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
  BodyMap getBody() {
    return {
      "name": name,
      "description": description,
      "time": preparationTime,
      "feeds": 1,
      "url": imageUrl,
      "type_id": typeId,
      "category_id": categoryId,
      "step": steps,
      "ingredient": ingredients
          .map((e) => {
                'id': e.model!.id,
                'quantity': e.quantity,
                'unit_id': e.model!.unit!.id
              })
          .toList()
    };
  }
}
