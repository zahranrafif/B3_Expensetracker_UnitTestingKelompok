part of 'report_bloc.dart';

abstract class ReportState extends Equatable {
  const ReportState();
  
  @override
  List<Object> get props => [];
}

class ReportInitial extends ReportState {}

class ReportLoading extends ReportState {}
class ReportLoaded extends ReportState {
  final ReportViewModel data;

  const ReportLoaded({
    required this.data
  });

  @override
  List<Object> get props => [data];
}
class ReportError extends ReportState {
  final String error;

  const ReportError({
    required this.error
  });

  @override
  List<Object> get props => [error];
}
