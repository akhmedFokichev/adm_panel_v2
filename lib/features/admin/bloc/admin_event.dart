import 'package:equatable/equatable.dart';
import 'package:adm_panel_v2/features/admin/bloc/admin_state.dart';

abstract class AdminEvent extends Equatable {
  const AdminEvent();

  @override
  List<Object?> get props => [];
}

class AdminSectionSelected extends AdminEvent {
  final AdminSection section;

  const AdminSectionSelected(this.section);

  @override
  List<Object?> get props => [section];
}
