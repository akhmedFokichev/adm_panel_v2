import 'package:equatable/equatable.dart';
import 'package:adm_panel_v2/features/user/models/profile_models.dart';
import 'package:adm_panel_v2/features/user/models/user_models.dart';

class AdminUserState extends Equatable {
  final bool isLoading;
  final String? error;
  final String? successMessage;
  final UserModel? createdUser;
  final UserProfileModel? profile;

  const AdminUserState({
    this.isLoading = false,
    this.error,
    this.successMessage,
    this.createdUser,
    this.profile,
  });

  AdminUserState copyWith({
    bool? isLoading,
    String? error,
    bool clearError = false,
    String? successMessage,
    bool clearSuccess = false,
    UserModel? createdUser,
    bool clearCreatedUser = false,
    UserProfileModel? profile,
    bool clearProfile = false,
  }) {
    return AdminUserState(
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      successMessage:
          clearSuccess ? null : (successMessage ?? this.successMessage),
      createdUser:
          clearCreatedUser ? null : (createdUser ?? this.createdUser),
      profile: clearProfile ? null : (profile ?? this.profile),
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        successMessage,
        createdUser,
        profile,
      ];
}
