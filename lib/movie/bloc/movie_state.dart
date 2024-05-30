part of 'movie_bloc.dart';

enum MovieStatus { initial, loading, success, failure }

class MovieState extends Equatable {
  const MovieState({
    this.movie = MovieModel.empty,
    this.status = MovieStatus.initial,
    this.reviewStatus = MovieStatus.initial,
    this.reviewSubmitStatus = MovieStatus.initial,
    this.reviews = const [],
  });
  final MovieModel movie;
  final MovieStatus status;
  final MovieStatus reviewStatus;
  final MovieStatus reviewSubmitStatus;
  final List<ReviewModel> reviews;

  @override
  List<Object> get props => [movie, status, reviewStatus, reviews, reviewSubmitStatus];

  MovieState copyWith({
    MovieModel? movie,
    MovieStatus? status,
    MovieStatus? reviewStatus,
    MovieStatus? reviewSubmitStatus,
    List<ReviewModel>? reviews,
  }) {
    return MovieState(
      movie: movie ?? this.movie,
      status: status ?? this.status,
      reviewStatus: reviewStatus ?? this.reviewStatus,
      reviewSubmitStatus: reviewSubmitStatus ?? this.reviewSubmitStatus,
      reviews: reviews ?? this.reviews,
    );
  }
}

class HomeInitial extends MovieState {}
