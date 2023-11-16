part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();
  
  @override
  List<Object> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardError extends DashboardState {
  final String error;

  const DashboardError({
    required this.error
  });

  @override
  List<Object> get props => [error];
}

class DashboardLoading extends DashboardState {}
class DashboardLoaded extends DashboardState {
  final DashboardModel data;

  const DashboardLoaded({
    required this.data
  });

  @override
  List<Object> get props => [data];
}
