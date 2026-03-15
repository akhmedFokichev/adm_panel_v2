import 'package:equatable/equatable.dart';

/// Состояния для SplashBloc
abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

/// Начальное состояние загрузки
class SplashInitial extends SplashState {
  const SplashInitial();
}

/// Состояние загрузки
class SplashLoading extends SplashState {
  final double? progress;

  const SplashLoading({this.progress});

  @override
  List<Object> get props => [progress ?? 0.0];
}

/// Состояние завершения загрузки
class SplashLoaded extends SplashState {
  const SplashLoaded();
}

/// Состояние ошибки
class SplashError extends SplashState {
  final String message;

  const SplashError(this.message);

  @override
  List<Object> get props => [message];
}
