import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adm_panel_v2/features/auth/bloc/auth_event.dart';
import 'package:adm_panel_v2/features/auth/bloc/auth_state.dart';
import 'package:adm_panel_v2/features/auth/services/auth_service.dart';
import 'package:adm_panel_v2/features/auth/models/auth_request.dart';
import 'package:adm_panel_v2/core/di/injection_container.dart';
import 'package:adm_panel_v2/core/storage/app_storage_service.dart';

/// BLoC для управления авторизацией
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;
  final AppStorageService _storageService;

  AuthBloc({AuthService? authService})
      : _authService = authService ?? InjectionContainer().authService,
        _storageService = InjectionContainer().storageService,
        super(const AuthInitial()) {
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthStatusChecked>(_onStatusChecked);
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      // Валидация
      if (event.login.isEmpty || event.password.isEmpty) {
        emit(const AuthError('Логин и пароль не могут быть пустыми'));
        return;
      }

      // Запрос к API
      final request = AuthRequest(
        login: event.login,
        password: event.password,
      );

      final response = await _authService.login(request);

      if (response.success && response.data != null) {
        final authData = response.data!;
        final token = authData.accessToken;
        if (token.isEmpty) {
          emit(const AuthError('Сервер не вернул accessToken'));
          return;
        }

        await _storageService.saveAuthToken(token);
        await _storageService.saveUserId(authData.user.id);
        await _storageService.saveUserName(
          authData.user.name ?? authData.user.email,
        );

        // Обновляем токен в API клиенте
        InjectionContainer().updateAuthToken(token);

        emit(AuthAuthenticated(
          token: token,
          userId: authData.user.id,
          username: authData.user.name ?? authData.user.email,
        ));
      } else {
        emit(AuthError(response.message ?? 'Ошибка авторизации'));
      }
    } catch (e) {
      emit(AuthError('Ошибка авторизации: ${e.toString()}'));
    }
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      // Отправляем запрос на выход (опционально)
      await _authService.logout();
      
      // Очищаем токен
      InjectionContainer().updateAuthToken(null);
      await _storageService.clearAuthData();

      emit(const AuthUnauthenticated());
    } catch (e) {
      // Даже если запрос не удался, выходим из системы локально
      InjectionContainer().updateAuthToken(null);
      await _storageService.clearAuthData();
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> _onStatusChecked(
    AuthStatusChecked event,
    Emitter<AuthState> emit,
  ) async {
    final token = _storageService.getAuthToken();
    final userId = _storageService.getUserId();
    final userName = _storageService.getUserName();

    if (token != null && token.isNotEmpty && userId != null && userName != null) {
      InjectionContainer().updateAuthToken(token);
      emit(AuthAuthenticated(token: token, userId: userId, username: userName));
      return;
    }

    emit(const AuthUnauthenticated());
  }
}
