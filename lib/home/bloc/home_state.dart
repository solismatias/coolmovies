part of 'home_bloc.dart';

enum HomeMoviesStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  const HomeState({
    this.movies = const [],
    this.status = HomeMoviesStatus.initial,
  });
  final List movies;
  final HomeMoviesStatus status;

  @override
  List<Object> get props => [movies, status];

  HomeState copyWith({
    List? movies,
    HomeMoviesStatus? status,
  }) {
    return HomeState(
      movies: movies ?? this.movies,
      status: status ?? this.status,
    );
  }
}

class HomeInitial extends HomeState {}
