// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tang_tem_pao_mb/feature/dashboard/model/dashboard_expense_by_category_mdoel.dart';
import 'package:tang_tem_pao_mb/feature/dashboard/model/dashboard_summary_model.dart';
import 'package:tang_tem_pao_mb/feature/transaction/model/transaction_model.dart';

class DashboardState {
  final DashboardSummaryModel? summary;
  final List<DashboardExpenseByCategory>? chart;
  final List<TransactionModel>? recentTransactions;

  DashboardState({
    required this.summary,
    required this.recentTransactions,
    required this.chart,
  });
  
}
