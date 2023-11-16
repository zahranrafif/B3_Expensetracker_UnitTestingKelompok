part of 'outcome_bloc.dart';

abstract class OutcomeEvent extends Equatable {
  const OutcomeEvent();

  @override
  List<Object> get props => [];
}

class GetDataOutcome extends OutcomeEvent {}

class AddOutcome extends OutcomeEvent {
  final TransactionModel data;

  const AddOutcome({
    required this.data
  });
}

class UpdateOutcome extends OutcomeEvent {
  final TransactionModel data;

  const UpdateOutcome({
    required this.data
  });
}

class DeleteOutcome extends OutcomeEvent {
  final String id;

  const DeleteOutcome({
    required this.id
  });
}