part of 'transaction_recap_bloc.dart';

abstract class TransactionRecapEvent extends Equatable {
  const TransactionRecapEvent();

  @override
  List<Object> get props => [];
}

class GetDataTransactionRecap extends TransactionRecapEvent {
  final Timestamp filterDate;

  const GetDataTransactionRecap({
    required this.filterDate,
  });
}