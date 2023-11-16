import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetracker/domain/interactors/firebase/transaction/transaction_interactor.dart';
import 'package:expensetracker/domain/models/transaction/transaction_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionRepository {
  final transactionInteractor = TransactionInteractor();
  
  Future<List<TransactionModel>> getByDate(Timestamp date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try{
      return await transactionInteractor.getByDate(prefs.getString('uid')!, date); 
    }catch(e){

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
    }

    return [];
  }

  Future<List<TransactionModel>> getLatest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try{
      return await transactionInteractor.getLatest(prefs.getString('uid')!); 
    }catch(e){

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
    }

    return [];
  }
}