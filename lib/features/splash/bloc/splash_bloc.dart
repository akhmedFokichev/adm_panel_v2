import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adm_panel_v2/features/splash/bloc/splash_event.dart';
import 'package:adm_panel_v2/features/splash/bloc/splash_state.dart';

/// BLoC для управления экраном загрузки
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashInitial()) {
    on<SplashStarted>(_onStarted);
    on<SplashCompleted>(_onCompleted);
  }

  Future<void> _onStarted(
    SplashStarted event,
    Emitter<SplashState> emit,
  ) async {
    emit(const SplashLoading());

    // Имитация загрузки данных
    // В реальном приложении здесь может быть:
    // - Проверка авторизации
    // - Загрузка конфигурации
    // - Инициализация сервисов
    // - Проверка обновлений

    for (int i = 0; i <= 100; i += 10) {
      await Future.delayed(const Duration(milliseconds: 200));
      emit(SplashLoading(progress: i / 100));
    }

    // После завершения загрузки переходим в загруженное состояние
    emit(const SplashLoaded());
  }

  void _onCompleted(
    SplashCompleted event,
    Emitter<SplashState> emit,
  ) {
    emit(const SplashLoaded());
  }
}
