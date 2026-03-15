import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adm_panel_v2/features/auth/bloc/auth_event.dart';
import 'package:adm_panel_v2/features/auth/bloc/auth_state.dart';
import 'package:adm_panel_v2/features/auth/services/auth_service.dart';
import 'package:adm_panel_v2/features/auth/models/auth_request.dart';
import 'package:adm_panel_v2/core/di/injection_container.dart';

/// BLoC для управления авторизацией
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;

  AuthBloc({AuthService? authService})
      : _authService = authService ?? InjectionContainer().authService,
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
        
        // Обновляем токен в API клиенте
        InjectionContainer().updateAuthToken(authData.token);

        emit(AuthAuthenticated(
          token: authData.token,
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
      
      emit(const AuthUnauthenticated());
    } catch (e) {
      // Даже если запрос не удался, выходим из системы локально
      InjectionContainer().updateAuthToken(null);
      emit(const AuthUnauthenticated());
    }
  }

  void _onStatusChecked(
    AuthStatusChecked event,
    Emitter<AuthState> emit,
  ) {
    // В реальном приложении здесь будет проверка токена из хранилища
    // Пока возвращаем неавторизованное состояние
    emit(const AuthUnauthenticated());
  }
}
