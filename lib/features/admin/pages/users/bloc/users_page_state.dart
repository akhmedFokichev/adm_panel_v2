import 'package:equatable/equatable.dart';
import 'package:adm_panel_v2/data/user/models/user_models.dart';

class UsersPageState extends Equatable {
  final bool isLoading;
  final String? error;
  final String? successMessage;
  final UserModel? createdUser;

  const UsersPageState({
    this.isLoading = false,
    this.error,
    this.successMessage,
    this.createdUser,
  });

  UsersPageState copyWith({
    bool? isLoading,
    String? error,
    bool clearError = false,
    String? successMessage,
    bool clearSuccess = false,
    UserModel? createdUser,
    bool clearCreatedUser = false,
  }) {
    return UsersPageState(
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      successMessage: clearSuccess ? null : (successMessage ?? this.successMessage),
      createdUser: clearCreatedUser ? null : (createdUser ?? this.createdUser),
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        successMessage,
        createdUser,
      ];
}
