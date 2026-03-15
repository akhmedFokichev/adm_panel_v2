import 'package:equatable/equatable.dart';

/// События для SplashBloc
abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object> get props => [];
}

/// Событие начала загрузки
class SplashStarted extends SplashEvent {
  const SplashStarted();
}

/// Событие завершения загрузки
class SplashCompleted extends SplashEvent {
  const SplashCompleted();
}
