import 'package:equatable/equatable.dart';

abstract class UsersPageEvent extends Equatable {
  const UsersPageEvent();

  @override
  List<Object?> get props => [];
}

class LoadUsersRequested extends UsersPageEvent {
  const LoadUsersRequested();
}

class CreateUserRequested extends UsersPageEvent {
  final String login;
  final String password;
  final int? role;

  const CreateUserRequested({
    required this.login,
    required this.password,
    this.role,
  });

  @override
  List<Object?> get props => [login, password, role];
}

class DeleteUserRequested extends UsersPageEvent {
  final int userId;

  const DeleteUserRequested(this.userId);

  @override
  List<Object?> get props => [userId];
}
