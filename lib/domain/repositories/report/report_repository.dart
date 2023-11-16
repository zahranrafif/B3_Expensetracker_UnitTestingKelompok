import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetracker/domain/helpers/date_formatter.dart';
import 'package:expensetracker/domain/interactors/firebase/report/report_interactor.dart';
import 'package:expensetracker/domain/interactors/firebase/transaction/transaction_interactor.dart';
import 'package:expensetracker/domain/models/report/report_model.dart';
import 'package:expensetracker/domain/models/report/report_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportRepository{
  final ReportInteractor reportInteractor = ReportInteractor();
  final TransactionInteractor transactionInteractor = TransactionInteractor();
  final dateFormatter = DateFormatter();

  Future<ReportViewModel> getByRangeDate(String startDate, String endDate, Timestamp filterDate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try{

      List<ReportModel> dailyReports = [];
      final daysToGenerate = DateTime.parse(endDate).difference(DateTime.parse(startDate)).inDays;

      int maxIncome = 0;
      int maxOutcome = 0;
      int totalIncome = 0;
      int totalOutcome = 0;
      
      for(int i = 0; i <= daysToGenerate; i++){
        var thisDate = dateFormatter.dateFormatYMD(Timestamp.fromDate(DateTime.parse(startDate).add(Duration(days: i))));
        var resReportInteractor = await reportInteractor.getByDate(prefs.getString('uid')!, thisDate );

        if(resReportInteractor != null){
          ReportModel report = ReportModel(
            id: resReportInteractor.id, 
            date: resReportInteractor.date, 
            amount: resReportInteractor.amount, 
            income: resReportInteractor.income, 
            outcome: resReportInteractor.outcome, 
            userId: resReportInteractor.userId
          );
          dailyReports.add(report);

          if(maxIncome < resReportInteractor.income){
            maxIncome = resReportInteractor.income;
          }
          if(maxOutcome < resReportInteractor.outcome){
            maxOutcome = resReportInteractor.outcome;
          }

          totalIncome += resReportInteractor.income;
          totalOutcome += resReportInteractor.outcome;
        }else{
          ReportModel report = ReportModel(
            id: "", 
            date: thisDate, 
            amount: 0, 
            income: 0, 
            outcome: 0, 
            userId: prefs.getString('uid')!
          );
          dailyReports.add(report);
        }
      }

      return ReportViewModel(dailyReports: dailyReports, maxIncome: maxIncome, maxOutcome: maxOutcome, totalIncome: totalIncome, totalOutcome: totalOutcome);
    }catch(e){

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
    }

    return ReportViewModel(dailyReports: [], maxIncome: 0, maxOutcome: 0, totalIncome: 0, totalOutcome: 0);
  }

}