import 'dart:developer' as logger;

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tang_tem_pao_mb/core/enum/budget_status_enum.dart';
import 'package:tang_tem_pao_mb/core/enum/transaction_type_enum.dart';
import 'package:tang_tem_pao_mb/core/failure/app_failure.dart';
import 'package:tang_tem_pao_mb/core/provider/dio_provider.dart';
import 'package:tang_tem_pao_mb/feature/budget/model/budget_model.dart';

part 'budget_repository.g.dart';

@riverpod
BudgetRepository budgetRepository(Ref ref) {
  final dio = ref.watch(dioProvider);
  return BudgetRepository(dio);
}

class BudgetRepository {
  final Dio _client;
  BudgetRepository(this._client);

  Future<Either<AppFailure, List<BudgetModel>>> getAllWithStatusBudgets({
    BudgetStatus status = BudgetStatus.active,
  }) async {
    try {
      final response = await _client.get(
        "/budget",
        queryParameters: {'status': status.getValue()},
      );
      List<BudgetModel> budgets = (response.data['payload'] as List<dynamic>)
          .map((budget) {
            return BudgetModel.fromResponseMap(budget);
          })
          .toList();

      // logger.log(budgets.toString());
      return Right(budgets);
    } catch (e) {
      logger.log(e.toString());
      return Left(AppFailure(e.toString()));
    }
  }
  Future<Either<AppFailure, String>> deleteById(String id) async {
    try {
      await _client.delete(
        "/budget/$id",
      );
      return Right("");
    } catch (e) {
      logger.log(e.toString());
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, BudgetModel>> createBudget({
    required String categoryId,
    required TransactionType type,
    required double targetAmount,
    required String startDate,
    required String endDate,
    BudgetStatus status = BudgetStatus.active,
  }) async {
    try {
      final response = await _client.post(
        "/budget",
        data: Map<String, dynamic>.of({
          'categoryId': categoryId,
          'type': type.getValue(),
          'targetAmount': targetAmount,
          'startDate': startDate,
          'endDate': endDate,
          'status': status.getValue(),
        }),
      );
      logger.log(response.data['payload'].toString());

      BudgetModel budgets = BudgetModel.fromResponseMap(
        response.data['payload'],
      );

      return Right(budgets);
    } catch (e) {
      logger.log(e.toString());
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, BudgetModel>> editBudget({
    required String id,
    required String categoryId,
    required TransactionType type,
    required double targetAmount,
    required String startDate,
    required String endDate,
    BudgetStatus? status = BudgetStatus.active,
  }) async {
    try {
      final response = await _client.put(
        "/budget/$id",
        data: Map<String, dynamic>.of({
          'categoryId': categoryId,
          'type': type.getValue(),
          'targetAmount': targetAmount,
          'startDate': startDate,
          'endDate': endDate,
          'status': status!.getValue(),
        }),
      );
      logger.log(response.data['payload'].toString());

      BudgetModel budgets = BudgetModel.fromResponseMap(
        response.data['payload'],
      );

      return Right(budgets);
    } catch (e) {
      print(e);
      return Left(AppFailure(e.toString()));
    }
  }

}
