part of 'user_bloc.dart';

enum UserStatus { initial, loading, success, failure }

class UserState extends Equatable {
  const UserState({
    this.user = UserModel.empty,
    this.status = UserStatus.initial,
  });

  final UserModel user;
  final UserStatus status;

  @override
  List<Object> get props => [user, status];

  UserState copyWith({
    UserModel? user,
    UserStatus? status,
  }) {
    return UserState(
      user: user ?? this.user,
      status: status ?? this.status,
    );
  }
}

class UserInitial extends UserState {}
