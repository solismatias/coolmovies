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