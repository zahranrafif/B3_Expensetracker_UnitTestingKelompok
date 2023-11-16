import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:expensetracker/domain/models/transaction/transaction_model.dart';

class TransactionInteractor {

  Future<List<TransactionModel>> get(String userId) async {

    List<TransactionModel> res = [];

    try{
      debugPrint('-- going to get trx');
      
      final data = await FirebaseFirestore.instance.collection('transactions')
      .where('user_id', isEqualTo:userId)
      .get();

      for(var item in data.docs){
        TransactionModel transaction = TransactionModel(
          amount: item.data()['amount'],
          description: item.data()['description'],
          id: item.id,
          isIncome: item.data()['is_income'],
          trxDate: item.data()['trx_date'],
          userId: item.data()['user_id']
        );

        res.add(transaction);
      }
    }on FirebaseException catch(e){
      debugPrint(' -- failed get transactions: ${e.message}');
    }

    return res;
  }

  Future<List<TransactionModel>> getByIsIncome(String userId, bool isIncome) async {

    List<TransactionModel> res = [];

    try{
      debugPrint('-- going to get trx');
      
      final data = await FirebaseFirestore.instance.collection('transactions')
      .where('user_id', isEqualTo:userId)
      .where('is_income', isEqualTo:isIncome)
      .orderBy('trx_date', descending: true)
      .get();

      for(var item in data.docs){
        TransactionModel transaction = TransactionModel(
          amount: item.data()['amount'],
          description: item.data()['description'],
          id: item.id,
          isIncome: item.data()['is_income'],
          trxDate: item.data()['trx_date'],
          userId: item.data()['user_id']
        );

        res.add(transaction);
      }
    }on FirebaseException catch(e){
      debugPrint(' -- failed get transactions: ${e.message}');
    }

    return res;
  }

  Future<List<TransactionModel>> getLatest(String userId) async {

    List<TransactionModel> res = [];

    try{
      debugPrint('-- going to get latest trx');
      
      final data = await FirebaseFirestore.instance.collection('transactions')
      .where('user_id', isEqualTo:userId)
      .orderBy('trx_date', descending: true)
      .limit(5).get();

      for(var item in data.docs){
        TransactionModel transaction = TransactionModel(
          amount: item.data()['amount'],
          description: item.data()['description'],
          id: item.id,
          isIncome: item.data()['is_income'],
          trxDate: item.data()['trx_date'],
          userId: item.data()['user_id']
        );

        res.add(transaction);
      }
    }on FirebaseException catch(e){
      debugPrint(' -- failed get latest transaction: ${e.message}');
    }

    return res;
  }

  Future<TransactionModel?> getById(String id) async {

    try{
      
      final data = await FirebaseFirestore.instance.collection('transactions')
      .doc(id)
      .get();

      if(data.exists){
        TransactionModel transaction = TransactionModel(
          amount: data.data()!['amount'],
          description: data.data()!['description'],
          id: data.id,
          isIncome: data.data()!['is_income'],
          trxDate: data.data()!['trx_date'],
          userId: data.data()!['user_id']
        );

        return transaction;
      }
    }on FirebaseException catch(e){
      debugPrint(' -- failed get transactions: ${e.message}');
    }

    return null;
  }

  Future<List<TransactionModel>> getByDate(String userId, Timestamp date) async {

    List<TransactionModel> res = [];

    try{
      
      final data = await FirebaseFirestore.instance.collection('transactions')
      .where('user_id', isEqualTo:userId)
      .where('trx_date', isGreaterThanOrEqualTo:date)
      .where('trx_date', isLessThan:Timestamp.fromDate(date.toDate().add(const Duration(days: 1))))
      .orderBy('trx_date', descending: true)
      .limit(5).get();

      for(var item in data.docs){
        TransactionModel transaction = TransactionModel(
          amount: item.data()['amount'],
          description: item.data()['description'],
          id: item.id,
          isIncome: item.data()['is_income'],
          trxDate: item.data()['trx_date'],
          userId: item.data()['user_id']
        );

        res.add(transaction);
      }
    }on FirebaseException catch(e){
      debugPrint(' -- failed get latest transaction: ${e.message}');
    }

    return res;
  }

  Future add(Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance.collection('transactions')
      .doc()
      .set(data);
    } on FirebaseException catch (e) {
      debugPrint('code : ${e.code}');
      debugPrint('message : ${e.message}');
    }
  }

  Future update(String id, Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance.collection('transactions')
      .doc(id)
      .update(data);
    } on FirebaseException catch (e) {
      debugPrint('code : ${e.code}');
      debugPrint('message : ${e.message}');
    }
  }

  Future delete(String id) async {
    try {
      await FirebaseFirestore.instance.collection('transactions')
      .doc(id)
      .delete();
    } on FirebaseException catch (e) {
      debugPrint('code : ${e.code}');
      debugPrint('message : ${e.message}');
    }
  }
}