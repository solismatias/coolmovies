import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_repository/movies_repository.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc({
    required MoviesRepository movieRepository,
  })  : _movieRepository = movieRepository,
        super(HomeInitial()) {
    on<MovieDataRequested>(_onMovieRequested);
    on<MovieReviewsRequested>(_onReviewsRequested);
    on<MovieReviewsSubmitPressed>(_onReviewsSubmitPressed);
    on<MovieReviewsDeletePressed>(_onReviewsDeletePressed);
    on<MovieReviewsSyncRequested>(_onSyncRequested);
  }
  final MoviesRepository _movieRepository;

  Future<void> _onMovieRequested(
    event,
    emit,
  ) async {
    emit(state.copyWith(status: MovieStatus.loading));
    try {
      MovieModel movie = await _movieRepository.getMovie(event.id);

      emit(state.copyWith(
        movie: movie,
        status: MovieStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(status: MovieStatus.failure));
    }
  }

  Future<void> _onReviewsRequested(
    event,
    emit,
  ) async {
    emit(state.copyWith(reviewStatus: MovieStatus.loading));
    try {
      List<ReviewModel> reviews = await _movieRepository.getMovieReviews(event.id, forceReload: event.forceReload);

      emit(state.copyWith(
        reviews: reviews,
        reviewStatus: MovieStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(reviewStatus: MovieStatus.failure));
    }
  }

  _onReviewsSubmitPressed(event, emit) async {
    emit(state.copyWith(reviewSubmitStatus: MovieStatus.loading));

    bool isSuccessful = await _movieRepository.createMovieReview(event.review);
    emit(state.copyWith(reviewSubmitStatus: isSuccessful ? MovieStatus.success : MovieStatus.failure));

    if (!isSuccessful) {
      add(const MovieReviewsSyncRequested());
    }
  }

  void _onSyncRequested(event, emit) {
    Timer.periodic(const Duration(seconds: 5), (timer) async {
      bool isConnected = await _movieRepository.isConnected();
      if (isConnected) {
        timer.cancel();
        bool success = await _movieRepository.retryFailedReviews();
        emit(state.copyWith(syncSuccess: success));
      }
    });
  }

  _onReviewsDeletePressed(event, emit) async {
    emit(state.copyWith(reviewDeleteStatus: MovieStatus.loading));

    bool isSuccessful = await _movieRepository.deleteMovieReview(event.reviewId);
    emit(state.copyWith(reviewDeleteStatus: isSuccessful ? MovieStatus.success : MovieStatus.failure));
  }
}
