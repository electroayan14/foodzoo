part of 'dashboard_bloc.dart';

class FoodDashboardState extends Equatable {
  final StateStatus stateStatus;
  final FoodModel? foodModel;
  final List<Categories>? categories;
  final String searchQuery;
  final String message;

  const FoodDashboardState(this.stateStatus, this.foodModel, this.categories,
      this.searchQuery, this.message);

  static FoodDashboardState initial() => const FoodDashboardState(
      StateStatus.loading, null, <Categories>[], '', '');

  FoodDashboardState copyWith(
          {StateStatus? stateStatus,
          FoodModel? foodModel,
          List<Categories>? categories,
          String? searchQuery,
          String? message}) =>
      FoodDashboardState(
          stateStatus ?? this.stateStatus,
          foodModel ?? this.foodModel,
          categories ?? this.categories,
          searchQuery ?? this.searchQuery,
          message ?? this.message);

  @override
  List<Object?> get props =>
      [stateStatus, foodModel, categories, searchQuery, message];
}
