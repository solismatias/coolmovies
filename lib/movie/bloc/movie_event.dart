part of 'movie_bloc.dart';

class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class MovieDataRequested extends MovieEvent {
  const MovieDataRequested({required this.id});

  final String id;
}

class MovieReviewsRequested extends MovieEvent {
  const MovieReviewsRequested({required this.id, this.forceReload = true});

  final String id;
  final bool forceReload;
}

class MovieReviewsSubmitPressed extends MovieEvent {
  const MovieReviewsSubmitPressed({required this.review});

  final ReviewModel review;
}

class MovieReviewsDeletePressed extends MovieEvent {
  const MovieReviewsDeletePressed({required this.reviewId});

  final String reviewId;
}
