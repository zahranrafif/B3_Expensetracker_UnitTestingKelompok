import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:expensetracker/domain/models/user/user_model.dart';

class UserInteractor {

  Future<UserModel?> get(String uid, email) async {
    try{

      final data = await FirebaseFirestore.instance.collection('users')
      .where('uid', isEqualTo: uid)
      .limit(1).get();

      if(data.docs.isNotEmpty){

        UserModel res = UserModel(
          id: data.docs[0].id, 
          uid: data.docs[0].data()['uid'], 
          name: data.docs[0].data()['name'], 
          balance: data.docs[0].data()['balance'],
          email: email
        );

        return res;      
      }

    } on FirebaseException catch (e){
      debugPrint('-- error message : ${e.message}');
      return null;
    }
  } 

  Future add(Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance.collection('users')
      .doc()
      .set(data);
    } on FirebaseException catch (e) {
      debugPrint('code : ${e.code}');
      debugPrint('message : ${e.message}');
    }
  }

  Future update(String id, Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance.collection('users')
      .doc(id)
      .update(data);
    } on FirebaseException catch (e) {
      debugPrint('code : ${e.code}');
      debugPrint('message : ${e.message}');
    }
  }

  Future delete(String id) async {
    try {
      await FirebaseFirestore.instance.collection('users')
      .doc(id)
      .delete();
    } on FirebaseException catch (e) {
      debugPrint('code : ${e.code}');
      debugPrint('message : ${e.message}');
    }
  }

}