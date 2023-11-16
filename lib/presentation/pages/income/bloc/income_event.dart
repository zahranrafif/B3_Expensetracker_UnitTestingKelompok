part of 'income_bloc.dart';

abstract class IncomeEvent extends Equatable {
  const IncomeEvent();

  @override
  List<Object> get props => [];
}

class GetDataIncome extends IncomeEvent {}

class AddIncome extends IncomeEvent {
  final TransactionModel data;

  const AddIncome({
    required this.data
  });
}

class UpdateIncome extends IncomeEvent {
  final TransactionModel data;

  const UpdateIncome({
    required this.data
  });
}

class DeleteIncome extends IncomeEvent {
  final String id;

  const DeleteIncome({
    required this.id
  });
}