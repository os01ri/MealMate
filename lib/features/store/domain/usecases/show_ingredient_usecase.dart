import 'package:dartz/dartz.dart';
import 'package:mealmate/core/error/failures.dart';
import 'package:mealmate/core/usecase/usecase.dart';
import 'package:mealmate/features/store/data/models/show_ingredient_response_model.dart';
import 'package:mealmate/features/store/domain/repositories/store_repository.dart';

class ShowIngredientUseCase implements UseCase<ShowIngredientResponseModel, ShowIngredientParams> {
  final StoreRepository repository;

  ShowIngredientUseCase({required this.repository});

  @override
  Future<Either<Failure, ShowIngredientResponseModel>> call(ShowIngredientParams params) async {
    return repository.showIngredient(id: params.id);
  }
}

class ShowIngredientParams implements UseCaseParams {
  final String id;

  const ShowIngredientParams({required this.id});

  @override
  Map<String, dynamic> getParams() => {};

  @override
  Map<String, dynamic> getBody() => {};
}
