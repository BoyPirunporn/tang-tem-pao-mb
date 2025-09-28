// Model for the chart data section
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:tang_tem_pao_mb/feature/dashboard/model/dashboard_expense_by_category_mdoel.dart';
import 'package:tang_tem_pao_mb/feature/dashboard/model/dashboard_monthly_summary_model.dart';

class DashboardChartModel {
  final List<DashboardMonthlySummary> monthlySummary;
  final List<DashboardExpenseByCategory> expenseByCategories;
  DashboardChartModel({
    required this.monthlySummary,
    required this.expenseByCategories,
  });

  

  DashboardChartModel copyWith({
    List<DashboardMonthlySummary>? monthlySummary,
    List<DashboardExpenseByCategory>? expenseByCategories,
  }) {
    return DashboardChartModel(
      monthlySummary: monthlySummary ?? this.monthlySummary,
      expenseByCategories: expenseByCategories ?? this.expenseByCategories,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'monthlySummary': monthlySummary.map((x) => x.toMap()).toList(),
      'expenseByCategories': expenseByCategories.map((x) => x.toMap()).toList(),
    };
  }

  factory DashboardChartModel.fromMap(Map<String, dynamic> map) {
    return DashboardChartModel(
      monthlySummary: List<DashboardMonthlySummary>.from((map['monthlySummary'] as List<dynamic>).map<DashboardMonthlySummary>((x) => DashboardMonthlySummary.fromMap(x as Map<String,dynamic>),),),
      expenseByCategories: List<DashboardExpenseByCategory>.from((map['expenseByCategories'] as List<dynamic>).map<DashboardExpenseByCategory>((x) => DashboardExpenseByCategory.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory DashboardChartModel.fromJson(String source) => DashboardChartModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DashboardChartModel(monthlySummary: $monthlySummary, expenseByCategories: $expenseByCategories)';

  @override
  bool operator ==(covariant DashboardChartModel other) {
    if (identical(this, other)) return true;
  
    return 
      listEquals(other.monthlySummary, monthlySummary) &&
      listEquals(other.expenseByCategories, expenseByCategories);
  }

  @override
  int get hashCode => monthlySummary.hashCode ^ expenseByCategories.hashCode;
}
