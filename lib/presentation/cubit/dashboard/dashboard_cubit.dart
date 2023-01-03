import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siak_mobile/domain/entities/dashboard.dart';
import 'package:siak_mobile/domain/usecases/get_dashboard.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final GetDashboard _getDashboard;

  DashboardCubit(this._getDashboard) : super(DashboardLoading());

  void fetchData() async {
    emit(DashboardLoading());

    Future.delayed(const Duration(seconds: 1), () async {
      final result = await _getDashboard.execute();

      result.fold(
        (failure) {
          emit(DashboardError(failure.message));
        },
        (dashboard) {
          emit(DashboardHasData(dashboard));
        },
      );
    });
  }
}
