part of 'meals_bloc.dart';

abstract class MealsEvent extends Equatable {
  const MealsEvent();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class FetchAllMeals extends MealsEvent {
  final String categoryName;

  const FetchAllMeals(this.categoryName);
}

class CartPressed extends MealsEvent {
  final bool isClicked;
  final Meals clickedItem;
  final int selectedIndex;

  const CartPressed(this.isClicked, this.clickedItem,this.selectedIndex);
}
