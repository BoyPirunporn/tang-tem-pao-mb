import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tang_tem_pao_mb/core/failure/app_failure.dart';
import 'package:tang_tem_pao_mb/feature/dashboard/model/dashboard_expense_by_category_mdoel.dart';
import 'package:tang_tem_pao_mb/feature/dashboard/model/dashboard_summary_model.dart';
import 'package:tang_tem_pao_mb/feature/dashboard/repository/dashboard_repository.dart';
import 'package:tang_tem_pao_mb/feature/dashboard/viewmodel/dashboard_state.dart';
import 'package:tang_tem_pao_mb/feature/transaction/model/transaction_model.dart';

part 'dashboard_viewmodel.g.dart';

@Riverpod(keepAlive: true)
class DashboardViewModel extends _$DashboardViewModel {
  late DashboardRepository _dashboardRepository;
  @override
  Future<DashboardState?> build() async {
    _dashboardRepository = ref.watch(dashboardRepositoryProvider);
    final _filter = ref.watch(dashboardFilterProvider);
    final results = await Future.wait([
      _dashboardRepository.loadSummary(_filter),
      _dashboardRepository.loadRecentTransaction(),
      _dashboardRepository.loadExpenseByCategory(_filter),
    ]);
    final summaryResult =
        results[0] as Either<AppFailure, DashboardSummaryModel?>;
    final transactionResult =
        results[1] as Either<AppFailure, List<TransactionModel>>;
    final chartResult =
        results[2] as Either<AppFailure, List<DashboardExpenseByCategory>>;

    final summary = summaryResult.fold((l) => throw l.message, (r) => r);
    final transactions = transactionResult.fold(
      (l) => throw l.message,
      (r) => r,
    );
    final chart = chartResult.fold((l) => throw l.message, (r) => r);
    return DashboardState(
      summary: summary,
      recentTransactions: transactions,
      chart: chart,
    );
  }
}
@riverpod
class DashboardFilter extends _$DashboardFilter {
  @override
  DateTimeRange build() {
    final now = DateTime.now();
    final start = DateTime(now.year,now.month,1);
    return DateTimeRange(start: start, end: now);
  }

  void setDateTimeRange(DateTimeRange newStatus) {
    state = newStatus;
  }
}
