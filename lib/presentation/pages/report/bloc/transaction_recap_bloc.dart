import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:expensetracker/domain/models/transaction/transaction_model.dart';
import 'package:expensetracker/domain/repositories/transaction/transaction_repository.dart';

part 'transaction_recap_event.dart';
part 'transaction_recap_state.dart';

class TransactionRecapBloc extends Bloc<TransactionRecapEvent, TransactionRecapState> {
  TransactionRecapBloc() : super(TransactionRecapInitial()) {
    final transactionRepository = TransactionRepository();

    on<TransactionRecapEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetDataTransactionRecap>((event, emit) async {
      // TODO: implement event handler
      try {
        emit(TransactionRecapLoading());
        
        final response = await transactionRepository.getByDate(event.filterDate);
          
        emit(TransactionRecapLoaded(data: response));
      } catch (e) {
        emit(TransactionRecapError(error: e.toString()));
      }
    });
  }
}
