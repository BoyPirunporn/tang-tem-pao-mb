import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tang_tem_pao_mb/feature/dashboard/model/dashboard_expense_by_category_mdoel.dart';
import 'package:tang_tem_pao_mb/feature/dashboard/model/dashboard_summary_model.dart';
import 'package:tang_tem_pao_mb/feature/dashboard/repository/dashboard_repository.dart';
import 'package:tang_tem_pao_mb/feature/dashboard/viewmodel/dashboard_state.dart';
import 'package:tang_tem_pao_mb/feature/transaction/model/transaction_model.dart';

part 'dashboard_viewmodel.g.dart';

@Riverpod(keepAlive: false)
class DashboardViewModel extends _$DashboardViewModel {
  @override
  Future<DashboardState?> build() async {
    // state = AsyncValue.loading();

    // _dashboardRepository = ref.watch(dashboardRepositoryProvider);
    // final filter = ref.watch(dashboardFilterProvider);
    // final results = await Future.wait([
    //   _dashboardRepository.loadSummary(filter),
    //   _dashboardRepository.loadRecentTransaction(page: 0, size: 5),
    //   _dashboardRepository.loadExpenseByCategory(filter),
    // ]);
    // final summaryResult =
    //     results[0] as Either<AppFailure, DashboardSummaryModel?>;
    // final transactionResult =
    //     results[1] as Either<AppFailure, List<TransactionModel>>;
    // final chartResult =
    //     results[2] as Either<AppFailure, List<DashboardExpenseByCategory>>;

    // final summary = summaryResult.fold((l) {
    //   state = AsyncValue.error(l.message, StackTrace.current);
    // }, (r) => r);
    // final List<TransactionModel>? transactions = transactionResult.fold((l) {
    //   state = AsyncValue.error(l.message, StackTrace.current);
    // }, (r) => r);
    // final List<DashboardExpenseByCategory>? chart = chartResult.fold((l) {
    //   state = AsyncValue.error(l.message, StackTrace.current);
    // }, (r) => r);

    // return DashboardState(
    //   summary: summary,
    //   recentTransactions: transactions,
    //   chart: chart,
    // );
    return null;
  }
}

@riverpod
class DashboardSummaryViewModel extends _$DashboardSummaryViewModel {
  @override
  Future<DashboardSummaryModel?> build() async {
    state = AsyncValue.loading();
    DashboardRepository dashboardRepository = ref.read(
      dashboardRepositoryProvider,
    );
    final filter = ref.watch(dashboardFilterProvider);
    final summaryResult = await dashboardRepository.loadSummary(filter);
    return summaryResult.fold(
      (failure) {
        return null;
      },
      (summaryModel) {
        return summaryModel;
      },
    );
  }
}

@riverpod
class DashboardChartViewModel extends _$DashboardChartViewModel {
  late DashboardRepository _dashboardRepository;

  @override
  Future<List<DashboardExpenseByCategory>?> build() async {
    state = AsyncValue.loading();

    _dashboardRepository = ref.watch(dashboardRepositoryProvider);
    final filter = ref.watch(dashboardFilterProvider);
    final chartResult = await _dashboardRepository.loadExpenseByCategory(
      filter,
    );
    final chart = chartResult.fold((l) {
      state = AsyncValue.error(l.message, StackTrace.current);
    }, (r) => r);
    return chart;
  }
}

@riverpod
class DashboardRecentViewModel extends _$DashboardRecentViewModel {
  late DashboardRepository _dashboardRepository;

  @override
  Future<List<TransactionModel>?> build() async {
    state = AsyncValue.loading();

    _dashboardRepository = ref.watch(dashboardRepositoryProvider);
    final filter = ref.watch(dashboardFilterProvider);
    final recentResult = await _dashboardRepository.loadRecentTransaction(
      page: 0,
      size: 5,
      filter: filter,
    );

    final transactions = recentResult.fold((l) {
      state = AsyncValue.error(l.message, StackTrace.current);
    }, (r) => r);

    return transactions;
  }
}

@riverpod
class DashboardFilter extends _$DashboardFilter {
  @override
  DateTimeRange? build() {
    return null;
  }

  void setDateTimeRange(DateTimeRange newStatus) {
    state = newStatus;
  }
}
