part of 'outcome_bloc.dart';

abstract class OutcomeState extends Equatable {
  const OutcomeState();
  
  @override
  List<Object> get props => [];
}

class OutcomeInitial extends OutcomeState {}

class OutcomeError extends OutcomeState {
  final String error;

  const OutcomeError({
    required this.error
  });

  @override
  List<Object> get props => [error];
}

class OutcomeLoading extends OutcomeState {}
class OutcomeLoaded extends OutcomeState {
  final List<TransactionModel> data;

  const OutcomeLoaded({
    required this.data
  });

  @override
  List<Object> get props => [data];
}

class OutcomeAdded extends OutcomeState {}
class OutcomeUpdated extends OutcomeState {}
class OutcomeDeleted extends OutcomeState {}