import 'dart:convert';

class DashboardSummaryModel {
  final double incomeOfMonth;
  final double expenseOfMonth;
  final double saving;
  final double incomeChangePercent;
  final double expenseChangePercent;
  final double percentageChangeNetProfit;
  final double netProfit;
  
  DashboardSummaryModel.empty()
      : incomeOfMonth = 0.0,
        expenseOfMonth = 0.0,
        saving = 0.0,
        incomeChangePercent = 0.0,
        expenseChangePercent = 0.0,
        percentageChangeNetProfit = 0.0,
        netProfit = 0.0;
        
  DashboardSummaryModel({
    required this.incomeOfMonth,
    required this.expenseOfMonth,
    required this.saving,
    required this.incomeChangePercent,
    required this.expenseChangePercent,
    required this.percentageChangeNetProfit,
    required this.netProfit,
  });

  

  DashboardSummaryModel copyWith({
    double? incomeOfMonth,
    double? expenseOfMonth,
    double? saving,
    double? incomeChangePercent,
    double? expenseChangePercent,
    double? percentageChangeNetProfit,
    double? netProfit,
  }) {
    return DashboardSummaryModel(
      incomeOfMonth: incomeOfMonth ?? this.incomeOfMonth,
      expenseOfMonth: expenseOfMonth ?? this.expenseOfMonth,
      saving: saving ?? this.saving,
      incomeChangePercent: incomeChangePercent ?? this.incomeChangePercent,
      expenseChangePercent: expenseChangePercent ?? this.expenseChangePercent,
      percentageChangeNetProfit: percentageChangeNetProfit ?? this.percentageChangeNetProfit,
      netProfit: netProfit ?? this.netProfit,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'incomeOfMonth': incomeOfMonth,
      'expenseOfMonth': expenseOfMonth,
      'saving':saving,
      'incomeChangePercent': incomeChangePercent,
      'expenseChangePercent': expenseChangePercent,
      'percentageChangeNetProfit': percentageChangeNetProfit,
      'netProfit': netProfit,
    };
  }

  factory DashboardSummaryModel.fromMap(Map<String, dynamic> map) {
    return DashboardSummaryModel(
      incomeOfMonth: map['incomeOfMonth'] as double,
      expenseOfMonth: map['expenseOfMonth'] as double,
      saving: map['saving'] as double,
      incomeChangePercent: map['incomeChangePercent'] as double,
      expenseChangePercent: map['expenseChangePercent'] as double,
      percentageChangeNetProfit: map['percentageChangeNetProfit'] as double,
      netProfit: map['netProfit'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory DashboardSummaryModel.fromJson(String source) => DashboardSummaryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DashboardSummaryModel(incomeOfMonth: $incomeOfMonth, expenseOfMonth: $expenseOfMonth, incomeChangePercent: $incomeChangePercent, expenseChangePercent: $expenseChangePercent, percentageChangeNetProfit: $percentageChangeNetProfit, netProfit: $netProfit)';
  }

  @override
  bool operator ==(covariant DashboardSummaryModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.incomeOfMonth == incomeOfMonth &&
      other.expenseOfMonth == expenseOfMonth &&
      other.incomeChangePercent == incomeChangePercent &&
      other.expenseChangePercent == expenseChangePercent &&
      other.percentageChangeNetProfit == percentageChangeNetProfit &&
      other.netProfit == netProfit;
  }

  @override
  int get hashCode {
    return incomeOfMonth.hashCode ^
      expenseOfMonth.hashCode ^
      incomeChangePercent.hashCode ^
      expenseChangePercent.hashCode ^
      percentageChangeNetProfit.hashCode ^
      netProfit.hashCode;
  }
}