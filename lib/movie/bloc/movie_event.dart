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
  const MovieReviewsRequested({required this.id});

  final String id;
}

class MovieReviewsSubmitPressed extends MovieEvent {
  const MovieReviewsSubmitPressed({required this.review});

  final ReviewModel review;
}
