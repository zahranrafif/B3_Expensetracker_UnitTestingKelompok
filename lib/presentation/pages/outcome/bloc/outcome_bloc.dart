import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:expensetracker/domain/models/transaction/transaction_model.dart';
import 'package:expensetracker/domain/repositories/outcome/outcome_repository.dart';
import 'package:expensetracker/presentation/pages/dashboard/bloc/dashboard_bloc.dart';

part 'outcome_event.dart';
part 'outcome_state.dart';

class OutcomeBloc extends Bloc<OutcomeEvent, OutcomeState> {
  OutcomeBloc() : super(OutcomeInitial()) {

    OutcomeRepository outcomeRepository = OutcomeRepository();

    on<OutcomeEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetDataOutcome>((event, emit) async {
      try {
        emit(OutcomeLoading());
        final response = await outcomeRepository.get();
          
        emit(OutcomeLoaded(data: response));
      } catch (e) {
        emit(OutcomeError(error: e.toString()));
      }
    });

    on<AddOutcome>((event, emit) async {
      try {
        await outcomeRepository.add(event.data);
        emit(OutcomeAdded());
      } catch (e) {
        emit(OutcomeError(error: e.toString()));
      }
    });

    on<UpdateOutcome>((event, emit) async {
      try {
        await outcomeRepository.edit(event.data);
        emit(OutcomeUpdated());
      } catch (e) {
        emit(OutcomeError(error: e.toString()));
      }
    });

    on<DeleteOutcome>((event, emit) async {
      try {
        await outcomeRepository.delete(event.id);
        emit(OutcomeDeleted());
      } catch (e) {
        emit(OutcomeError(error: e.toString()));
      }
    });
  }
}
