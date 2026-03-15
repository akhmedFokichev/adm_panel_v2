import 'package:equatable/equatable.dart';

/// События для AuthBloc
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

/// Событие входа с логином и паролем
class AuthLoginRequested extends AuthEvent {
  final String login;
  final String password;

  const AuthLoginRequested({
    required this.login,
    required this.password,
  });

  @override
  List<Object> get props => [login, password];
}

/// Событие выхода
class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}

/// Событие проверки авторизации
class AuthStatusChecked extends AuthEvent {
  const AuthStatusChecked();
}
