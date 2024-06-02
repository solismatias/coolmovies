import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_repository/movies_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required MoviesRepository movieRepository,
  })  : _movieRepository = movieRepository,
        super(HomeInitial()) {
    on<HomeAllMoviesRequested>(_onMoviesRequested);
    on<HomeSortMoviewsRequested>(_onSortRequested);
  }
  final MoviesRepository _movieRepository;

  Future<void> _onMoviesRequested(
    event,
    emit,
  ) async {
    emit(state.copyWith(status: HomeMoviesStatus.loading));
    try {
      List<MovieModel> movies = await _movieRepository.getMovies();

      emit(state.copyWith(
        movies: movies,
        status: HomeMoviesStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(status: HomeMoviesStatus.failure));
    }
  }

  Future<void> _onSortRequested(
    event,
    emit,
  ) async {
    List<MovieModel> sortedList = List.from(state.movies);

    sortedList.sort(
      (a, b) {
        DateTime dateA = DateTime.parse(a.releaseDate!);
        DateTime dateB = DateTime.parse(b.releaseDate!);

        if (event.sortBy == 'oldest') {
          return dateA.compareTo(dateB);
        } else {
          return dateB.compareTo(dateA);
        }
      },
    );

    emit(state.copyWith(movies: sortedList, sortBy: event.sortBy));
  }
}
