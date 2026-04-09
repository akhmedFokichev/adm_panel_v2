import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adm_panel_v2/core/di/injection_container.dart';
import 'package:adm_panel_v2/data/user/models/profile_models.dart';
import 'package:adm_panel_v2/data/user/services/user_service.dart';
import 'package:adm_panel_v2/features/admin/pages/profile/bloc/profile_page_event.dart';
import 'package:adm_panel_v2/features/admin/pages/profile/bloc/profile_page_state.dart';

class ProfilePageBloc extends Bloc<ProfilePageEvent, ProfilePageState> {
  final UserService _userService;

  ProfilePageBloc({UserService? userService})
      : _userService = userService ?? InjectionContainer().userService,
        super(const ProfilePageState()) {
    on<LoadProfileRequested>(_onLoadProfileRequested);
    on<UpsertProfileRequested>(_onUpsertProfileRequested);
    on<DeleteProfileRequested>(_onDeleteProfileRequested);
  }

  Future<void> _onLoadProfileRequested(
    LoadProfileRequested event,
    Emitter<ProfilePageState> emit,
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
    Emitter<ProfilePageState> emit,
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
    Emitter<ProfilePageState> emit,
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
