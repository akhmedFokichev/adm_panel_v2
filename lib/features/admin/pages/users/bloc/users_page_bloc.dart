import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adm_panel_v2/core/di/injection_container.dart';
import 'package:adm_panel_v2/data/user/models/user_models.dart';
import 'package:adm_panel_v2/data/user/services/user_service.dart';
import 'package:adm_panel_v2/features/admin/pages/users/bloc/users_page_event.dart';
import 'package:adm_panel_v2/features/admin/pages/users/bloc/users_page_state.dart';

class UsersPageBloc extends Bloc<UsersPageEvent, UsersPageState> {
  final UserService _userService;

  UsersPageBloc({UserService? userService})
      : _userService = userService ?? InjectionContainer().userService,
        super(const UsersPageState()) {
    on<LoadUsersRequested>(_onLoadUsersRequested);
    on<CreateUserRequested>(_onCreateUserRequested);
    on<DeleteUserRequested>(_onDeleteUserRequested);
  }

  Future<void> _onLoadUsersRequested(
    LoadUsersRequested event,
    Emitter<UsersPageState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearError: true));

    final response = await _userService.getUsers();
    if (response.success && response.data != null) {
      emit(
        state.copyWith(
          isLoading: false,
          users: response.data!,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        isLoading: false,
        error: response.message ?? 'Не удалось загрузить пользователей',
      ),
    );
  }

  Future<void> _onCreateUserRequested(
    CreateUserRequested event,
    Emitter<UsersPageState> emit,
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
          users: [response.data!, ...state.users.where((u) => u.id != response.data!.id)],
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
    Emitter<UsersPageState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearError: true, clearSuccess: true));

    final response = await _userService.deleteUser(event.userId);
    if (response.success) {
      emit(
        state.copyWith(
          isLoading: false,
          successMessage: 'Пользователь удален',
          clearCreatedUser: true,
          users: state.users.where((u) => u.id != event.userId).toList(),
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
}
