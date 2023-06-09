// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'store_cubit.dart';

class StoreState {
  final CubitStatus indexStatus;
  final List<IngredientModel> ingredients;

  final CubitStatus showStatus;
  final IngredientModel? ingredient;

  final CubitStatus indexWishlistStatus;
  final List<WishlistItem> wishItems;

  final CubitStatus addToWishlistStatus;
  final CubitStatus removeFromWishlistStatus;

  const StoreState({
    this.indexStatus = CubitStatus.initial,
    this.ingredients = const [],
    this.showStatus = CubitStatus.initial,
    this.ingredient,
    this.indexWishlistStatus = CubitStatus.initial,
    this.wishItems = const [],
    this.addToWishlistStatus = CubitStatus.initial,
    this.removeFromWishlistStatus = CubitStatus.initial,
  });

  StoreState copyWith({
    CubitStatus? indexStatus,
    List<IngredientModel>? ingredients,
    CubitStatus? showStatus,
    IngredientModel? ingredient,
    CubitStatus? indexWishlistStatus,
    List<WishlistItem>? wishItems,
    CubitStatus? addToWishlistStatus,
    CubitStatus? removeFromWishlistStatus,
  }) {
    return StoreState(
      indexStatus: indexStatus ?? this.indexStatus,
      ingredients: ingredients ?? this.ingredients,
      showStatus: showStatus ?? this.showStatus,
      ingredient: ingredient ?? this.ingredient,
      indexWishlistStatus: indexWishlistStatus ?? this.indexWishlistStatus,
      wishItems: wishItems ?? this.wishItems,
      addToWishlistStatus: addToWishlistStatus ?? this.addToWishlistStatus,
      removeFromWishlistStatus: removeFromWishlistStatus ?? this.removeFromWishlistStatus,
    );
  }
}
