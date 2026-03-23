import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adm_panel_v2/features/admin/bloc/admin_event.dart';
import 'package:adm_panel_v2/features/admin/bloc/admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc() : super(const AdminState()) {
    on<AdminSectionSelected>(_onSectionSelected);
  }

  void _onSectionSelected(
    AdminSectionSelected event,
    Emitter<AdminState> emit,
  ) {
    emit(state.copyWith(selectedSection: event.section));
  }
}
