import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maori_health/presentation/dashboard/bloc/dashboard_event.dart';
import 'package:maori_health/presentation/dashboard/bloc/dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(const DashboardState()) {
    on<DashboardLoaded>(_onLoaded);
  }

  Future<void> _onLoaded(
    DashboardLoaded event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(status: DashboardStatus.loading));
    // TODO: Fetch dashboard data via repository
    emit(state.copyWith(status: DashboardStatus.loaded));
  }
}
