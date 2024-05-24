part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();
}

//ignore:must_be_immutable
class FetchPost extends DashboardEvent {
  String? searchQuery;
  List<Categories> categories;

  FetchPost(this.searchQuery, this.categories);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
