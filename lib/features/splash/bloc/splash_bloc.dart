import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adm_panel_v2/core/di/injection_container.dart';
import 'package:adm_panel_v2/core/storage/app_storage_service.dart';
import 'package:adm_panel_v2/data/user/services/user_service.dart';
import 'package:adm_panel_v2/features/splash/bloc/splash_event.dart';
import 'package:adm_panel_v2/features/splash/bloc/splash_state.dart';

/// BLoC для управления экраном загрузки
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  late final AppStorageService _storageService;
  late final UserService _userService;

  SplashBloc() : super(const SplashInitial()) {
    _storageService = InjectionContainer().storageService;
    _userService = InjectionContainer().userService;
    on<SplashStarted>(_onStarted);
    on<SplashCompleted>(_onCompleted);
  }

  Future<void> _onStarted(
    SplashStarted event,
    Emitter<SplashState> emit,
  ) async {
    emit(const SplashLoading());

    for (int i = 0; i <= 70; i += 10) {
      await Future.delayed(const Duration(milliseconds: 200));
      emit(SplashLoading(progress: i / 100));
    }

    try {
      final token = _storageService.getAuthToken();
      if (token == null || token.isEmpty) {
        emit(const SplashLoaded(isAuthenticated: false));
        return;
      }

      InjectionContainer().updateAuthToken(token);
      emit(const SplashLoading(progress: 0.85));

      final meResponse = await _userService.me();
      emit(const SplashLoading(progress: 1.0));

      if (meResponse.success &&
          meResponse.data != null &&
          meResponse.data!.authorized) {
        emit(const SplashLoaded(isAuthenticated: true));
        return;
      }

      await _storageService.clearAuthData();
      InjectionContainer().updateAuthToken(null);
      emit(const SplashLoaded(isAuthenticated: false));
    } catch (_) {
      await _storageService.clearAuthData();
      InjectionContainer().updateAuthToken(null);
      emit(const SplashLoaded(isAuthenticated: false));
    }
  }

  void _onCompleted(
    SplashCompleted event,
    Emitter<SplashState> emit,
  ) {
    emit(const SplashLoaded(isAuthenticated: false));
  }
}
