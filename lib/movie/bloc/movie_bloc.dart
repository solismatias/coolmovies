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
}
