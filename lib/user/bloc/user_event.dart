part of 'user_bloc.dart';

class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserCurrentDataRequested extends UserEvent {
  const UserCurrentDataRequested();
}
