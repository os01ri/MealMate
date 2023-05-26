import 'package:dartz/dartz.dart';
import 'package:mealmate/core/error/failures.dart';
import 'package:mealmate/core/usecase/usecase.dart';
import 'package:mealmate/features/store/data/models/ingredient_model.dart';
import 'package:mealmate/features/store/domain/repositories/store_repository.dart';

class IndexIngredientsUseCase implements UseCase<IngredientModelResponse, IndexIngredientsParams> {
  final StoreRepository storeRepository;

  IndexIngredientsUseCase({required this.storeRepository});

  @override
  Future<Either<Failure, IngredientModelResponse>> call(IndexIngredientsParams params) async {
    return storeRepository.indexIngredients(params: params.getParams());
  }
}

class IndexIngredientsParams implements UseCaseParams {
  final int? perPage;
  final int? page;

  IndexIngredientsParams({
    this.perPage,
    this.page,
  });

  @override
  Map<String, dynamic> getParams() {
    return {
      if (page != null) "page": page.toString(),
      if (perPage != null) "perPage": perPage.toString(),
    };
  }

  @override
  Map<String, dynamic> getBody() => {};
}
