// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:expensetracker/domain/models/report/report_model.dart';
import 'package:expensetracker/domain/models/transaction/transaction_model.dart';

class ReportViewModel {
  late final List<ReportModel> dailyReports;
  late final int maxIncome;
  late final int maxOutcome;
  late final int totalIncome;
  late final int totalOutcome;
  ReportViewModel({
    required this.dailyReports,
    required this.maxIncome,
    required this.maxOutcome,
    required this.totalIncome,
    required this.totalOutcome,
  });

  ReportViewModel copyWith({
    List<ReportModel>? dailyReports,
    List<TransactionModel>? transactions,
    int? maxIncome,
    int? maxOutcome,
    int? totalIncome,
    int? totalOutcome,
  }) {
    return ReportViewModel(
      dailyReports: dailyReports ?? this.dailyReports,
      maxIncome: maxIncome ?? this.maxIncome,
      maxOutcome: maxOutcome ?? this.maxOutcome,
      totalIncome: totalIncome ?? this.totalIncome,
      totalOutcome: totalOutcome ?? this.totalOutcome,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dailyReports': dailyReports.map((x) => x.toMap()).toList(),
      'maxIncome': maxIncome,
      'maxOutcome': maxOutcome,
      'totalIncome': totalIncome,
      'totalOutcome': totalOutcome,
    };
  }

  factory ReportViewModel.fromMap(Map<String, dynamic> map) {
    return ReportViewModel(
      dailyReports: List<ReportModel>.from((map['dailyReports'] as List<int>).map<ReportModel>((x) => ReportModel.fromMap(x as Map<String,dynamic>),),),
      maxIncome: map['maxIncome'] as int,
      maxOutcome: map['maxOutcome'] as int,
      totalIncome: map['totalIncome'] as int,
      totalOutcome: map['totalOutcome'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReportViewModel.fromJson(String source) => ReportViewModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReportViewModel(dailyReports: $dailyReports, maxIncome: $maxIncome, maxOutcome: $maxOutcome, totalIncome: $totalIncome, totalOutcome: $totalOutcome)';
  }

  @override
  bool operator ==(covariant ReportViewModel other) {
    if (identical(this, other)) return true;
  
    return 
      listEquals(other.dailyReports, dailyReports) &&
      other.maxIncome == maxIncome &&
      other.maxOutcome == maxOutcome &&
      other.totalIncome == totalIncome &&
      other.totalOutcome == totalOutcome;
  }

  @override
  int get hashCode {
    return dailyReports.hashCode ^
      maxIncome.hashCode ^
      maxOutcome.hashCode ^
      totalIncome.hashCode ^
      totalOutcome.hashCode;
  }
}
