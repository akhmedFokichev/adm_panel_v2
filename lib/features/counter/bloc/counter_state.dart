import 'package:equatable/equatable.dart';

/// Состояния для CounterBloc
abstract class CounterState extends Equatable {
  const CounterState();

  @override
  List<Object> get props => [];
}

/// Начальное состояние счетчика
class CounterInitial extends CounterState {
  const CounterInitial();
}

/// Состояние загрузки
class CounterLoading extends CounterState {
  const CounterLoading();
}

/// Состояние с данными счетчика
class CounterLoaded extends CounterState {
  final int value;

  const CounterLoaded(this.value);

  @override
  List<Object> get props => [value];
}

/// Состояние ошибки
class CounterError extends CounterState {
  final String message;

  const CounterError(this.message);

  @override
  List<Object> get props => [message];
}
