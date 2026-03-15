import 'package:equatable/equatable.dart';

/// События для CounterBloc
abstract class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object> get props => [];
}

/// Событие увеличения счетчика
class CounterIncremented extends CounterEvent {
  const CounterIncremented();
}

/// Событие уменьшения счетчика
class CounterDecremented extends CounterEvent {
  const CounterDecremented();
}

/// Событие сброса счетчика
class CounterReset extends CounterEvent {
  const CounterReset();
}
