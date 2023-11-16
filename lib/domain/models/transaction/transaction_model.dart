// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  late final String id;
  late final String userId;
  late final int amount;
  late final bool isIncome;
  late final Timestamp trxDate;
  late final String description;
  TransactionModel({
    required this.id,
    required this.userId,
    required this.amount,
    required this.isIncome,
    required this.trxDate,
    required this.description,
  });

  TransactionModel copyWith({
    String? id,
    String? userId,
    int? amount,
    bool? isIncome,
    Timestamp? trxDate,
    String? description,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      amount: amount ?? this.amount,
      isIncome: isIncome ?? this.isIncome,
      trxDate: trxDate ?? this.trxDate,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'amount': amount,
      'isIncome': isIncome,
      'trxDate': trxDate,
      'description': description,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] as String,
      userId: map['userId'] as String,
      amount: map['amount'] as int,
      isIncome: map['isIncome'] as bool,
      trxDate: map['trxDate'] as Timestamp,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TransactionModel(id: $id, userId: $userId, amount: $amount, isIncome: $isIncome, trxDate: $trxDate, description: $description)';
  }

  @override
  bool operator ==(covariant TransactionModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.amount == amount &&
        other.isIncome == isIncome &&
        other.trxDate == trxDate &&
        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        amount.hashCode ^
        isIncome.hashCode ^
        trxDate.hashCode ^
        description.hashCode;
  }
}
