import 'package:equatable/equatable.dart';

/// Состояния для AuthBloc
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

/// Начальное состояние (не авторизован)
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Состояние загрузки авторизации
class AuthLoading extends AuthState {
  const AuthLoading();
}

/// Состояние успешной авторизации
class AuthAuthenticated extends AuthState {
  final String token;
  final String userId;
  final String username;

  const AuthAuthenticated({
    required this.token,
    required this.userId,
    required this.username,
  });

  @override
  List<Object> get props => [token, userId, username];
}

/// Состояние неавторизованного пользователя
class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

/// Состояние ошибки авторизации
class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}
