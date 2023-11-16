// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'report_bloc.dart';

abstract class ReportEvent extends Equatable {
  const ReportEvent();

  @override
  List<Object> get props => [];
}

class GetDataReport extends ReportEvent {
  final String startDate;
  final String endDate;
  final Timestamp filterDate;

  const GetDataReport({
    required this.startDate,
    required this.endDate,
    required this.filterDate,
  });
}
