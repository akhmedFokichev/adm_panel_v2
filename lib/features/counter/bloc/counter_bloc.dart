import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adm_panel_v2/features/counter/bloc/counter_event.dart';
import 'package:adm_panel_v2/features/counter/bloc/counter_state.dart';

/// BLoC для управления счетчиком
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterInitial()) {
    on<CounterIncremented>(_onIncremented);
    on<CounterDecremented>(_onDecremented);
    on<CounterReset>(_onReset);
  }

  void _onIncremented(
    CounterIncremented event,
    Emitter<CounterState> emit,
  ) {
    final currentValue = state is CounterLoaded
        ? (state as CounterLoaded).value
        : 0;

    emit(CounterLoaded(currentValue + 1));
  }

  void _onDecremented(
    CounterDecremented event,
    Emitter<CounterState> emit,
  ) {
    final currentValue = state is CounterLoaded
        ? (state as CounterLoaded).value
        : 0;

    if (currentValue > 0) {
      emit(CounterLoaded(currentValue - 1));
    }
  }

  void _onReset(
    CounterReset event,
    Emitter<CounterState> emit,
  ) {
    emit(const CounterLoaded(0));
  }
}
