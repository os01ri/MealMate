import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/helper/type_defs.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/show_ingredient_response_model.dart';
import '../repositories/store_repository.dart';

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
  ParamsMap getParams() => {};

  @override
  BodyMap getBody() => {};
}
