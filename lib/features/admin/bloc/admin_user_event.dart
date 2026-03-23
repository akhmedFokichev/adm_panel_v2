import 'package:equatable/equatable.dart';

abstract class AdminUserEvent extends Equatable {
  const AdminUserEvent();

  @override
  List<Object?> get props => [];
}

class CreateUserRequested extends AdminUserEvent {
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

class DeleteUserRequested extends AdminUserEvent {
  final int userId;

  const DeleteUserRequested(this.userId);

  @override
  List<Object?> get props => [userId];
}

class LoadProfileRequested extends AdminUserEvent {
  final int userId;

  const LoadProfileRequested(this.userId);

  @override
  List<Object?> get props => [userId];
}

class UpsertProfileRequested extends AdminUserEvent {
  final int userId;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? avatarUrl;

  const UpsertProfileRequested({
    required this.userId,
    this.firstName,
    this.lastName,
    this.phone,
    this.avatarUrl,
  });

  @override
  List<Object?> get props => [userId, firstName, lastName, phone, avatarUrl];
}

class DeleteProfileRequested extends AdminUserEvent {
  final int userId;

  const DeleteProfileRequested(this.userId);

  @override
  List<Object?> get props => [userId];
}
