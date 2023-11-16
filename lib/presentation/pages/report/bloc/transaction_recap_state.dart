part of 'transaction_recap_bloc.dart';

abstract class TransactionRecapState extends Equatable {
  const TransactionRecapState();
  
  @override
  List<Object> get props => [];
}

class TransactionRecapInitial extends TransactionRecapState {}

class TransactionRecapLoading extends TransactionRecapState {}
class TransactionRecapLoaded extends TransactionRecapState {
  final List<TransactionModel> data;

  const TransactionRecapLoaded({
    required this.data
  });

  @override
  List<Object> get props => [data];
}
class TransactionRecapError extends TransactionRecapState {
  final String error;

  const TransactionRecapError({
    required this.error
  });

  @override
  List<Object> get props => [error];
}
