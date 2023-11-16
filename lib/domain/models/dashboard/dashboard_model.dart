// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:expensetracker/domain/models/transaction/transaction_model.dart';
import 'package:expensetracker/domain/models/user/user_model.dart';

class DashboardModel {
  final UserModel? user;
  final List<TransactionModel> latestTransactions;
  DashboardModel({
    required this.user,
    required this.latestTransactions,
  });

  DashboardModel copyWith({
    UserModel? user,
    List<TransactionModel>? latestTransactions,
  }) {
    return DashboardModel(
      user: user ?? this.user,
      latestTransactions: latestTransactions ?? this.latestTransactions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user?.toMap(),
      'latestTransactions': latestTransactions.map((x) => x.toMap()).toList(),
    };
  }

  factory DashboardModel.fromMap(Map<String, dynamic> map) {
    return DashboardModel(
      user: map['user'] != null ? UserModel.fromMap(map['user'] as Map<String,dynamic>) : null,
      latestTransactions: List<TransactionModel>.from((map['latestTransactions'] as List<int>).map<TransactionModel>((x) => TransactionModel.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory DashboardModel.fromJson(String source) => DashboardModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DashboardModel(user: $user, latestTransactions: $latestTransactions)';

  @override
  bool operator ==(covariant DashboardModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.user == user &&
      listEquals(other.latestTransactions, latestTransactions);
  }

  @override
  int get hashCode => user.hashCode ^ latestTransactions.hashCode;
}
