// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ReportModel {
  late final String id;
  late final String date;
  late final int amount;
  late final int income;
  late final int outcome;
  late final String userId;
  ReportModel({
    required this.id,
    required this.date,
    required this.amount,
    required this.income,
    required this.outcome,
    required this.userId,
  });

  ReportModel copyWith({
    String? id,
    String? date,
    int? amount,
    int? income,
    int? outcome,
    String? userId,
  }) {
    return ReportModel(
      id: id ?? this.id,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      income: income ?? this.income,
      outcome: outcome ?? this.outcome,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date,
      'amount': amount,
      'income': income,
      'outcome': outcome,
      'userId': userId,
    };
  }

  factory ReportModel.fromMap(Map<String, dynamic> map) {
    return ReportModel(
      id: map['id'] as String,
      date: map['date'] as String,
      amount: map['amount'] as int,
      income: map['income'] as int,
      outcome: map['outcome'] as int,
      userId: map['userId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReportModel.fromJson(String source) => ReportModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReportModel(id: $id, date: $date, amount: $amount, income: $income, outcome: $outcome, userId: $userId)';
  }

  @override
  bool operator ==(covariant ReportModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.date == date &&
      other.amount == amount &&
      other.income == income &&
      other.outcome == outcome &&
      other.userId == userId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      date.hashCode ^
      amount.hashCode ^
      income.hashCode ^
      outcome.hashCode ^
      userId.hashCode;
  }
}
