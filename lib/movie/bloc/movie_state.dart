part of 'movie_bloc.dart';

enum MovieStatus { initial, loading, success, failure }

class MovieState extends Equatable {
  const MovieState({
    this.movie = MovieModel.empty,
    this.status = MovieStatus.initial,
    this.reviewStatus = MovieStatus.initial,
    this.reviewSubmitStatus = MovieStatus.initial,
    this.reviewDeleteStatus = MovieStatus.initial,
    this.reviews = const [],
    this.syncSuccess = false,
  });
  final MovieModel movie;
  final MovieStatus status;
  final MovieStatus reviewStatus;
  final MovieStatus reviewSubmitStatus;
  final MovieStatus reviewDeleteStatus;
  final List<ReviewModel> reviews;
  final bool syncSuccess;

  @override
  List<Object> get props => [
        movie,
        status,
        reviewStatus,
        reviews,
        reviewSubmitStatus,
        reviewDeleteStatus,
        syncSuccess,
      ];

  MovieState copyWith({
    MovieModel? movie,
    MovieStatus? status,
    MovieStatus? reviewStatus,
    MovieStatus? reviewSubmitStatus,
    MovieStatus? reviewDeleteStatus,
    List<ReviewModel>? reviews,
    bool? syncSuccess,
  }) {
    return MovieState(
      movie: movie ?? this.movie,
      status: status ?? this.status,
      reviewStatus: reviewStatus ?? this.reviewStatus,
      reviewSubmitStatus: reviewSubmitStatus ?? this.reviewSubmitStatus,
      reviewDeleteStatus: reviewDeleteStatus ?? this.reviewDeleteStatus,
      reviews: reviews ?? this.reviews,
      syncSuccess: syncSuccess ?? this.syncSuccess,
    );
  }
}

class HomeInitial extends MovieState {}
