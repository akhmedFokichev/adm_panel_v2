import 'package:equatable/equatable.dart';

abstract class ProfilePageEvent extends Equatable {
  const ProfilePageEvent();

  @override
  List<Object?> get props => [];
}

class LoadProfileRequested extends ProfilePageEvent {
  final int userId;

  const LoadProfileRequested(this.userId);

  @override
  List<Object?> get props => [userId];
}

class UpsertProfileRequested extends ProfilePageEvent {
  final int userId;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? avatarUrl;

  const UpsertProfileRequested({
    required this.userId,
    this.firstName,
    this.lastName,
    this.phone,
    this.avatarUrl,
  });

  @override
  List<Object?> get props => [userId, firstName, lastName, phone, avatarUrl];
}

class DeleteProfileRequested extends ProfilePageEvent {
  final int userId;

  const DeleteProfileRequested(this.userId);

  @override
  List<Object?> get props => [userId];
}
