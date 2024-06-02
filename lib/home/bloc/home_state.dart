part of 'home_bloc.dart';

enum HomeMoviesStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  const HomeState({
    this.movies = const [],
    this.status = HomeMoviesStatus.initial,
    this.sortBy = 'newest',
  });
  final List movies;
  final HomeMoviesStatus status;
  final String sortBy;

  @override
  List<Object> get props => [movies, status, sortBy];

  HomeState copyWith({
    List? movies,
    HomeMoviesStatus? status,
    String? sortBy,
  }) {
    return HomeState(
      movies: movies ?? this.movies,
      status: status ?? this.status,
      sortBy: sortBy ?? this.sortBy,
    );
  }
}

class HomeInitial extends HomeState {}
