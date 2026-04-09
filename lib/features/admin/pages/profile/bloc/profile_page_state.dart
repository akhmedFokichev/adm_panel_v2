import 'package:equatable/equatable.dart';
import 'package:adm_panel_v2/data/user/models/profile_models.dart';

class ProfilePageState extends Equatable {
  final bool isLoading;
  final String? error;
  final String? successMessage;
  final UserProfileModel? profile;

  const ProfilePageState({
    this.isLoading = false,
    this.error,
    this.successMessage,
    this.profile,
  });

  ProfilePageState copyWith({
    bool? isLoading,
    String? error,
    bool clearError = false,
    String? successMessage,
    bool clearSuccess = false,
    UserProfileModel? profile,
    bool clearProfile = false,
  }) {
    return ProfilePageState(
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      successMessage: clearSuccess ? null : (successMessage ?? this.successMessage),
      profile: clearProfile ? null : (profile ?? this.profile),
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        successMessage,
        profile,
      ];
}
