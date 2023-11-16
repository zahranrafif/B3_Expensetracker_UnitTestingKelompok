part of 'income_bloc.dart';

abstract class IncomeState extends Equatable {
  const IncomeState();
  
  @override
  List<Object> get props => [];
}

class IncomeInitial extends IncomeState {}

class IncomeError extends IncomeState {
  final String error;

  const IncomeError({
    required this.error
  });

  @override
  List<Object> get props => [error];
}

class IncomeLoading extends IncomeState {}
class IncomeLoaded extends IncomeState {
  final List<TransactionModel> data;

  const IncomeLoaded({
    required this.data
  });

  @override
  List<Object> get props => [data];
}

class IncomeAdded extends IncomeState {}
class IncomeUpdated extends IncomeState {}
class IncomeDeleted extends IncomeState {}