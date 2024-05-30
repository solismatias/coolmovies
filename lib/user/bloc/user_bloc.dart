import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_repository/movies_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({
    required MoviesRepository movieRepository,
  })  : _movieRepository = movieRepository,
        super(UserInitial()) {
    on<UserCurrentDataRequested>(_onCurrentUserRequested);
  }

  final MoviesRepository _movieRepository;

  _onCurrentUserRequested(event, emit) async {
    emit(state.copyWith(status: UserStatus.loading));
    // delay time to apreciate initial screen
    await Future.delayed(const Duration(seconds: 1));
    try {
      UserModel currentUser = await _movieRepository.getCurrentUser();
      emit(state.copyWith(
        user: currentUser,
        status: UserStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: UserStatus.failure,
      ));
    }
  }
}
