part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({this.movies = const []});
  final List movies;

  @override
  List<Object> get props => [movies];

  HomeState copyWith({
    List? movies,
  }) {
    return HomeState(
      movies: movies ?? this.movies,
    );
  }
}

class HomeInitial extends HomeState {}
