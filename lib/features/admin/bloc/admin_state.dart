import 'package:equatable/equatable.dart';

enum AdminSection {
  home,
  designSystem,
  users,
  profile,
  cases,
  faq,
  items,
  addCases,
}

class AdminState extends Equatable {
  final AdminSection selectedSection;

  const AdminState({
    this.selectedSection = AdminSection.home,
  });

  AdminState copyWith({
    AdminSection? selectedSection,
  }) {
    return AdminState(
      selectedSection: selectedSection ?? this.selectedSection,
    );
  }

  @override
  List<Object?> get props => [selectedSection];
}
