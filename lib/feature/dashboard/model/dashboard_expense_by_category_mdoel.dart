// Model for the expense by category pie chart
import 'dart:convert';

class DashboardExpenseByCategory {
  final String categoryName;
  final double value;
  final String color;
  DashboardExpenseByCategory({
    required this.categoryName,
    required this.value,
    required this.color,
  });

  

  DashboardExpenseByCategory copyWith({
    String? categoryName,
    double? value,
    String? color,
  }) {
    return DashboardExpenseByCategory(
      categoryName: categoryName ?? this.categoryName,
      value: value ?? this.value,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categoryName': categoryName,
      'value': value,
      'color': color,
    };
  }

  factory DashboardExpenseByCategory.fromMap(Map<String, dynamic> map) {
    return DashboardExpenseByCategory(
      categoryName: map['categoryName'] as String,
      value: map['value'] as double,
      color: map['color'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DashboardExpenseByCategory.fromJson(String source) => DashboardExpenseByCategory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DashboardExpenseByCategory(categoryName: $categoryName, value: $value, color: $color)';

  @override
  bool operator ==(covariant DashboardExpenseByCategory other) {
    if (identical(this, other)) return true;
  
    return 
      other.categoryName == categoryName &&
      other.value == value &&
      other.color == color;
  }

  @override
  int get hashCode => categoryName.hashCode ^ value.hashCode ^ color.hashCode;
}
