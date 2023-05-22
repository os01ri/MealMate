// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'store_cubit.dart';

class StoreState {
  final CubitStatus status;
  final List<IngredientModel> ingredients;
  const StoreState({
    this.status = CubitStatus.initial,
    this.ingredients = const [],
  });

  StoreState copyWith({
    CubitStatus? status,
    List<IngredientModel>? ingredients,
  }) {
    return StoreState(
      status: status ?? this.status,
      ingredients: ingredients ?? this.ingredients,
    );
  }
}
