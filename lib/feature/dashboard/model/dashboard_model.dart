// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:tang_tem_pao_mb/feature/dashboard/model/dashboard_chart_model.dart';
import 'package:tang_tem_pao_mb/feature/dashboard/model/dashboard_recent_transaction_model.dart';
import 'package:tang_tem_pao_mb/feature/dashboard/model/dashboard_summary_model.dart';
import 'package:tang_tem_pao_mb/feature/transaction/model/transaction_model.dart';

class DashboardModel {
  final DashboardSummaryModel summary;
  final List<TransactionModel> recentTransaction;
  final DashboardChartModel? chart;
  DashboardModel({
    required this.summary,
    required this.recentTransaction,
    this.chart,
  });


  DashboardModel copyWith({
    DashboardSummaryModel? summary,
    List<TransactionModel>? recentTransaction,
    DashboardChartModel? chart,
  }) {
    return DashboardModel(
      summary: summary ?? this.summary,
      recentTransaction: recentTransaction ?? this.recentTransaction,
      chart: chart ?? this.chart,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'summary': summary.toMap(),
      'recentTransaction': recentTransaction.map((x) => x.toMap()).toList(),
      'chart': chart?.toMap(),
    };
  }

  factory DashboardModel.fromMap(Map<String, dynamic> map) {
    return DashboardModel(
      summary: DashboardSummaryModel.fromMap(map['summary'] as Map<String,dynamic>),
      recentTransaction: List<TransactionModel>.from((map['recentTransaction'] as List<int>).map<DashboardRecentTransactionModel>((x) => DashboardRecentTransactionModel.fromMap(x as Map<String,dynamic>),),),
      chart: map['chart'] != null ? DashboardChartModel.fromMap(map['chart'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DashboardModel.fromJson(String source) => DashboardModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DashboardModel(summary: $summary, recentTransaction: $recentTransaction, chart: $chart)';

  @override
  bool operator ==(covariant DashboardModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.summary == summary &&
      listEquals(other.recentTransaction, recentTransaction) &&
      other.chart == chart;
  }

  @override
  int get hashCode => summary.hashCode ^ recentTransaction.hashCode ^ chart.hashCode;
}


