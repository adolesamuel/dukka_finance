part of 'dashboard_state_notifier.dart';

class DashboardState {}

class InitialDashboardState extends DashboardState {}

class DashboardErrorState extends DashboardState {
  final Failure failure;

  DashboardErrorState(this.failure);
}

class DashboardDataState extends DashboardState {
  final DashboardData data;

  DashboardDataState(this.data);
}
