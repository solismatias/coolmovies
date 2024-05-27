part of 'movie_bloc.dart';

enum MovieStatus { initial, loading, success, failure }

class MovieState extends Equatable {
  const MovieState({
    this.movie = MovieModel.empty,
    this.status = MovieStatus.initial,
  });
  final MovieModel movie;
  final MovieStatus status;

  @override
  List<Object> get props => [movie, status];

  MovieState copyWith({
    MovieModel? movie,
    MovieStatus? status,
  }) {
    return MovieState(
      movie: movie ?? this.movie,
      status: status ?? this.status,
    );
  }
}

class HomeInitial extends MovieState {}
