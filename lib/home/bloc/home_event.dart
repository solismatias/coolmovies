part of 'home_bloc.dart';

class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeAllMoviesRequested extends HomeEvent {
  const HomeAllMoviesRequested();
}

class HomeSortMoviewsRequested extends HomeEvent {
  const HomeSortMoviewsRequested({required this.sortBy});

  final String sortBy;
}
