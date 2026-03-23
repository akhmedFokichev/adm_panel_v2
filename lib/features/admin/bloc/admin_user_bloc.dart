import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adm_panel_v2/core/di/injection_container.dart';
import 'package:adm_panel_v2/features/admin/bloc/admin_user_event.dart';
import 'package:adm_panel_v2/features/admin/bloc/admin_user_state.dart';
import 'package:adm_panel_v2/features/user/models/profile_models.dart';
import 'package:adm_panel_v2/features/user/models/user_models.dart';
import 'package:adm_panel_v2/features/user/services/user_service.dart';

class AdminUserBloc extends Bloc<AdminUserEvent, AdminUserState> {
  final UserService _userService;

  AdminUserBloc({UserService? userService})
      : _userService = userService ?? InjectionContainer().userService,
        super(const AdminUserState()) {
    on<CreateUserRequested>(_onCreateUserRequested);
    on<DeleteUserRequested>(_onDeleteUserRequested);
    on<LoadProfileRequested>(_onLoadProfileRequested);
    on<UpsertProfileRequested>(_onUpsertProfileRequested);
    on<DeleteProfileRequested>(_onDeleteProfileRequested);
  }

  Future<void> _onCreateUserRequested(
    CreateUserRequested event,
    Emitter<AdminUserState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearError: true, clearSuccess: true));

    final request = CreateUserRequest(
      login: event.login,
      password: event.password,
      role: event.role,
    );
    final response = await _userService.createUser(request);

    if (response.success && response.data != null) {
      emit(
        state.copyWith(
          isLoading: false,
          createdUser: response.data,
          successMessage: 'Пользователь создан',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        isLoading: false,
        error: response.message ?? 'Не удалось создать пользователя',
      ),
    );
  }

  Future<void> _onDeleteUserRequested(
    DeleteUserRequested event,
    Emitter<AdminUserState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearError: true, clearSuccess: true));

    final response = await _userService.deleteUser(event.userId);
    if (response.success) {
      emit(
        state.copyWith(
          isLoading: false,
          successMessage: 'Пользователь удален',
          clearCreatedUser: true,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        isLoading: false,
        error: response.message ?? 'Не удалось удалить пользователя',
      ),
    );
  }

  Future<void> _onLoadProfileRequested(
    LoadProfileRequested event,
    Emitter<AdminUserState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearError: true, clearSuccess: true));

    final response = await _userService.getProfile(event.userId);
    if (response.success && response.data != null) {
      emit(
        state.copyWith(
          isLoading: false,
          profile: response.data,
          successMessage: 'Профиль загружен',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        isLoading: false,
        error: response.message ?? 'Не удалось загрузить профиль',
      ),
    );
  }

  Future<void> _onUpsertProfileRequested(
    UpsertProfileRequested event,
    Emitter<AdminUserState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearError: true, clearSuccess: true));

    final request = UpsertUserProfileRequest(
      firstName: _normalizeNullable(event.firstName),
      lastName: _normalizeNullable(event.lastName),
      phone: _normalizeNullable(event.phone),
      avatarUrl: _normalizeNullable(event.avatarUrl),
    );

    final response = await _userService.upsertProfile(event.userId, request);
    if (response.success && response.data != null) {
      emit(
        state.copyWith(
          isLoading: false,
          profile: response.data,
          successMessage: 'Профиль обновлен',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        isLoading: false,
        error: response.message ?? 'Не удалось сохранить профиль',
      ),
    );
  }

  Future<void> _onDeleteProfileRequested(
    DeleteProfileRequested event,
    Emitter<AdminUserState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearError: true, clearSuccess: true));

    final response = await _userService.deleteProfile(event.userId);
    if (response.success) {
      emit(
        state.copyWith(
          isLoading: false,
          successMessage: 'Профиль удален',
          clearProfile: true,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        isLoading: false,
        error: response.message ?? 'Не удалось удалить профиль',
      ),
    );
  }

  String? _normalizeNullable(String? value) {
    if (value == null) {
      return null;
    }
    final normalized = value.trim();
    if (normalized.isEmpty) {
      return null;
    }
    return normalized;
  }
}
