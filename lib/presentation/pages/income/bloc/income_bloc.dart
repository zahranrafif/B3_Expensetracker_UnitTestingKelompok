import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:expensetracker/domain/models/transaction/transaction_model.dart';
import 'package:expensetracker/domain/repositories/income/income_repository.dart';
import 'package:expensetracker/presentation/pages/dashboard/bloc/dashboard_bloc.dart';

part 'income_event.dart';
part 'income_state.dart';

class IncomeBloc extends Bloc<IncomeEvent, IncomeState> {
  IncomeBloc() : super(IncomeInitial()) {

    IncomeRepository incomeRepository = IncomeRepository();

    on<IncomeEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetDataIncome>((event, emit) async {
      try {
        emit(IncomeLoading());
        final response = await incomeRepository.get();
          
        emit(IncomeLoaded(data: response));
      } catch (e) {
        emit(IncomeError(error: e.toString()));
      }
    });

    on<AddIncome>((event, emit) async {
      try {
        await incomeRepository.add(event.data);
        emit(IncomeAdded());
      } catch (e) {
        emit(IncomeError(error: e.toString()));
      }
    });

    on<UpdateIncome>((event, emit) async {
      try {
        await incomeRepository.edit(event.data);
        emit(IncomeUpdated());
      } catch (e) {
        emit(IncomeError(error: e.toString()));
      }
    });

    on<DeleteIncome>((event, emit) async {
      try {
        await incomeRepository.delete(event.id);
        emit(IncomeDeleted());
      } catch (e) {
        emit(IncomeError(error: e.toString()));
      }
    });
  }
}
