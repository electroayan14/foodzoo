import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:foodzoo/features/dashboard/model/food_model.dart';
import 'package:foodzoo/features/dashboard/repository/dashboard_repo.dart';
import 'package:foodzoo/features/utils/enums/enums.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, FoodDashboardState> {
  final DashboardRepo _dashboardRepository = DashboardRepo();

  DashboardBloc() : super(FoodDashboardState.initial()) {
    on<FetchPost>(_onFetchPost);
  }

  Future<void> _onFetchPost(
      FetchPost event, Emitter<FoodDashboardState> emit) async {
    try {
      if (event.searchQuery == '') {
        emit(state.copyWith(stateStatus: StateStatus.loading));
        final posts = await _dashboardRepository.fetchFoodData();
        emit(state.copyWith(
            stateStatus: StateStatus.success,
            foodModel: posts,
            categories: null,
            searchQuery: null,
            message: ''));
      } else if (event.searchQuery != 'no value') {
        var items = event.categories
            .where((item) => item.strCategory
                .toString()
                .toLowerCase()
                .trim()
                .contains(event.searchQuery??''.toLowerCase().trim()))
            .toList();
        if (items.isNotEmpty) {
          emit(state.copyWith(
              stateStatus: StateStatus.success,
              foodModel: null,
              categories: items,
              searchQuery: event.searchQuery,
              message: ''));
        } else {
          emit(state.copyWith(
              stateStatus: StateStatus.success,
              foodModel: null,
              categories: [],
              searchQuery: event.searchQuery,
              message: 'No product found'));
        }
      } else {
        emit(state.copyWith(
            stateStatus: StateStatus.success,
            foodModel: null,
            categories: event.categories,
            searchQuery: event.searchQuery,
            message: ''));
      }
    } catch (e) {
      emit(state.copyWith(stateStatus: StateStatus.failed));
    }
  }
}
