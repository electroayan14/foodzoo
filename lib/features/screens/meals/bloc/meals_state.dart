part of 'meals_bloc.dart';

class MealsState extends Equatable {
  final StateStatus stateStatus;
  final FoodByCategoryModel? foodByCategoryModel;
  final bool isClicked;
  final String message;
  final Meals? clickedItem;
  final int selectedIndex;

  const MealsState(this.stateStatus, this.foodByCategoryModel, this.isClicked,
      this.message, this.clickedItem, this.selectedIndex);

  static MealsState initial() =>
      const MealsState(StateStatus.loading, null, false, '', null, -1);

  MealsState copyWith(
          {StateStatus? stateStatus,
          FoodByCategoryModel? foodByCategoryModel,
          bool? isClicked,
          String? message,
          Meals? clickedItem,
          int? selectedIndex}) =>
      MealsState(
          stateStatus ?? this.stateStatus,
          foodByCategoryModel ?? this.foodByCategoryModel,
          isClicked ?? this.isClicked,
          message ?? this.message,
          clickedItem ?? this.clickedItem,
          selectedIndex ?? this.selectedIndex);

  @override
  List<Object?> get props =>
      [stateStatus, foodByCategoryModel, isClicked, message, clickedItem,selectedIndex];
}
