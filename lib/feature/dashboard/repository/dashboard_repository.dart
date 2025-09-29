import 'dart:developer' as logger;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tang_tem_pao_mb/core/failure/app_failure.dart';
import 'package:tang_tem_pao_mb/core/provider/dio_provider.dart';
import 'package:tang_tem_pao_mb/feature/dashboard/model/dashboard_chart_model.dart';
import 'package:tang_tem_pao_mb/feature/dashboard/model/dashboard_expense_by_category_mdoel.dart';
import 'package:tang_tem_pao_mb/feature/dashboard/model/dashboard_summary_model.dart';
import 'package:tang_tem_pao_mb/feature/transaction/model/transaction_model.dart';

part 'dashboard_repository.g.dart';

@riverpod
DashboardRepository dashboardRepository(ref) {
  final dio = ref.watch(dioProvider);
  return DashboardRepository(dio);
}

class DashboardRepository {
  final Dio _client;
  DashboardRepository(this._client);

  Future<Either<AppFailure, DashboardSummaryModel>> loadSummary(
    DateTimeRange? filter,
  ) async {
    try {
      final queryParameters = Map.of({
        'from': filter != null
            ? DateFormat("yyyy-MM-dd").format(filter.start)
            : null,
        'to': filter != null
            ? DateFormat("yyyy-MM-dd").format(filter.end)
            : null,
      });
      logger.log("queryParams $queryParameters");
      final response = await _client.get(
        "/dashboard/summary",
        queryParameters: filter != null ? queryParameters : null,
      );
      // logger.log("response summary : ${response.data}");

      final resBodySummaryMap = response.data as Map<String, dynamic>;

      if (response.statusCode != 200) {
        // ถ้าไม่ใช่ 200 (เช่น 401) ให้คืนค่าเป็น Failure
        return Left(
          AppFailure(
            "Failed to load summary. Status code: ${response.statusCode}",
          ),
        );
      }
      DashboardSummaryModel summaryModel = DashboardSummaryModel.fromMap(
        resBodySummaryMap['payload'],
      );

      // //await Future.delayed(const Duration(seconds: 2));
      return Right(summaryModel);
    } catch (e) {
      logger.log(e.toString());
      return Left(AppFailure("ไม่สามารถโหลดข้อมูลได้ กรุณาติดต่อเจ้าหน้าที่"));
    }
  }

  Future<Either<AppFailure, List<TransactionModel>>> loadRecentTransaction({
    required int page,
    required int size,
    DateTimeRange? filter
  }) async {
    try {
      Map<String, dynamic> queryParameters = Map.of({
        'page': page,
        'size': size
      });

      if (filter != null) {
        queryParameters.addAll({'from': DateFormat("yyyy-MM-dd").format(filter.start), 'to': DateFormat("yyyy-MM-dd").format(filter.end)});
      }
      final transactionLatest = await _client.get(
        "/dashboard/recent-transaction",
        queryParameters: queryParameters,
      );
      // logger.log("response transactionLatest : ${transactionLatest.data}");
      final resBodyTransactionLatestMap =
          transactionLatest.data as Map<String, dynamic>;
      final transactions =
          (resBodyTransactionLatestMap['data'] as List<dynamic>)
              .map(
                (e) =>
                    TransactionModel.fromMapResponse(e as Map<String, dynamic>),
              )
              .toList();
      // //await Future.delayed(const Duration(seconds: 2));
      return Right(transactions);
    } catch (e) {
      logger.log(e.toString());
      return Left(AppFailure("ไม่สามารถโหลดข้อมูลได้ กรุณาติดต่อเจ้าหน้าที่"));
    }
  }

  Future<Either<AppFailure, List<DashboardExpenseByCategory>>>
  loadExpenseByCategory(DateTimeRange? filter) async {
    try {
      final queryParameters = Map.of({
        'from': filter != null
            ? DateFormat("yyyy-MM-dd").format(filter.start)
            : null,
        'to': filter != null
            ? DateFormat("yyyy-MM-dd").format(filter.end)
            : null,
      });

      final res = await _client.get(
        "/dashboard/chart",
        queryParameters: filter != null ? queryParameters : null,
      );
      final resBodyLoadExpenseByCategoryMap = res.data as Map<String, dynamic>;

      final chart = DashboardChartModel.fromMap(
        resBodyLoadExpenseByCategoryMap['payload'],
      );
      // logger.log(
      //   "response loadExpenseByCategory : ${chart.expenseByCategories}",
      // );

      // //await Future.delayed(const Duration(seconds: 2));
      return Right(chart.expenseByCategories);
    } catch (e) {
      logger.log(e.toString());
      return Left(AppFailure("ไม่สามารถโหลดข้อมูลได้ กรุณาติดต่อเจ้าหน้าที่"));
    }
  }
}
