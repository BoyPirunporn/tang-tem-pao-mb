import 'dart:convert';

class DashboardMonthlySummary {
  final String month;
  final double income;
  final double expense;
  DashboardMonthlySummary({
    required this.month,
    required this.income,
    required this.expense,
  });

  

  DashboardMonthlySummary copyWith({
    String? month,
    double? income,
    double? expense,
  }) {
    return DashboardMonthlySummary(
      month: month ?? this.month,
      income: income ?? this.income,
      expense: expense ?? this.expense,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'month': month,
      'income': income,
      'expense': expense,
    };
  }

  factory DashboardMonthlySummary.fromMap(Map<String, dynamic> map) {
    return DashboardMonthlySummary(
      month: map['month'] as String,
      income: map['income'] as double,
      expense: map['expense'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory DashboardMonthlySummary.fromJson(String source) => DashboardMonthlySummary.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DashboardMonthlySummary(month: $month, income: $income, expense: $expense)';

  @override
  bool operator ==(covariant DashboardMonthlySummary other) {
    if (identical(this, other)) return true;
  
    return 
      other.month == month &&
      other.income == income &&
      other.expense == expense;
  }

  @override
  int get hashCode => month.hashCode ^ income.hashCode ^ expense.hashCode;
}
