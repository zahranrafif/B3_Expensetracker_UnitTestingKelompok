import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expensetracker/domain/models/dashboard/dashboard_model.dart';
import 'package:expensetracker/domain/repositories/transaction/transaction_repository.dart';
import 'package:expensetracker/domain/repositories/user/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    final userRepository = UserRepository();
    final transactionRepository = TransactionRepository();

    on<DashboardEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetDataDashboard>((event, emit) async {
      try {
        emit(DashboardLoading());

        final user = await userRepository.get();  
        if(user == null){
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.clear();
        }

        final latestTransactions = await transactionRepository.getLatest();

        final response = DashboardModel(user: user, latestTransactions: latestTransactions);

        emit(DashboardLoaded(data: response));
        
      } catch (e) {
        emit(DashboardError(error: e.toString()));
      }
    });
  }
}
