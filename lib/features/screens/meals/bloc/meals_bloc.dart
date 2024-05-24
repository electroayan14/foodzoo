import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:foodzoo/features/screens/meals/domain/model/food_by_categoryModel.dart';
import 'package:foodzoo/features/utils/enums/enums.dart';

import '../domain/meals_repository.dart';

part 'meals_event.dart';

part 'meals_state.dart';

class MealsBloc extends Bloc<MealsEvent, MealsState> {
  final MealsRepo _mealsRepo = MealsRepo();

  MealsBloc() : super(MealsState.initial()) {
    on<FetchAllMeals>(_onGetAllMeals);
    on<CartPressed>(_onAddedToCart);
  }

  Future<void> _onGetAllMeals(
      FetchAllMeals event, Emitter<MealsState> emit) async {
    try {
      emit(state.copyWith(stateStatus: StateStatus.loading));
      final response =
          await _mealsRepo.fetchFoodDataByCategory(event.categoryName);
      emit(state.copyWith(
          stateStatus: StateStatus.success, foodByCategoryModel: response));
    } catch (e) {
      emit(state.copyWith(
          stateStatus: StateStatus.failed, message: "No data found"));
    }
  }

  Future<void> _onAddedToCart(
      CartPressed event, Emitter<MealsState> emit) async {
    try {
      switch (event.isClicked) {
        case true:
          emit(state.copyWith(
              stateStatus: StateStatus.success,
              isClicked: false,
              clickedItem: null,selectedIndex: event.selectedIndex));
        case false:
          emit(state.copyWith(
              stateStatus: StateStatus.success,
              isClicked: true,
              clickedItem: event.clickedItem,selectedIndex: event.selectedIndex));
      }
    } catch (e) {
      emit(state.copyWith(stateStatus: StateStatus.failed));
    }
  }
}
