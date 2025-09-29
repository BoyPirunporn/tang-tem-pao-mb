import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tang_tem_pao_mb/core/enum/transaction_type_enum.dart';
import 'package:tang_tem_pao_mb/core/failure/app_failure.dart';
import 'package:tang_tem_pao_mb/core/provider/dio_provider.dart';
import 'package:tang_tem_pao_mb/feature/transaction/model/transaction_model.dart';

part 'transaction_repository.g.dart';

@riverpod
TransactionRepository transactionRepository(Ref ref) {
  final Dio dio = ref.watch(dioProvider);
  return TransactionRepository(dio);
}

class TransactionRepository {
  final Dio _client;
  TransactionRepository(this._client);

  Future<Either<AppFailure, List<TransactionModel>>> getAllTransaction({
    TransactionType type = TransactionType.all,
    String? name,
    required CancelToken cancelToken,
  }) async {
    try {
      final res = await _client.get(
        '/transaction',
        queryParameters: {
          'type': type == TransactionType.all ? null : type.getValue(),
          'name':name
        },
        cancelToken: cancelToken,
      );
      Map<String, dynamic> resBody = res.data;
      //logger.log("response : $resBody");
      if (res.statusCode != 200) {
        return Left(AppFailure(resBody['message']));
      }
      //await Future.delayed(const Duration(seconds: 2));

      List<TransactionModel> transactions =
          (resBody['payload'] as List<dynamic>)
              .map(
                (transaction) => TransactionModel.fromMapResponse(transaction),
              )
              .toList();

      return Right(transactions);
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, TransactionModel>> createTransaction({
    String? id,
    required TransactionType type,
    required String categoryId,
    required String transactionDate,
    required double amount,
    String? description,
  }) async {
    try {
      final res = await _client.post(
        '/transaction',
        data: {
          'id': id,
          'type': type.getValue(),
          'categoryId': categoryId,
          'transactionDate': transactionDate,
          'amount': amount,
          'description': description,
        },
      );
      Map<String, dynamic> resBody = res.data;
      //logger.log("response : $resBody\nstatusCode: ${res.statusCode}");
      if (res.statusCode! > 200) {
        return Left(AppFailure(resBody['message']));
      }
      TransactionModel transactions = TransactionModel.fromMapResponse(
        resBody['payload'],
      );
      return Right(transactions);
    } catch (e) {
      if (e is DioException) {
        return Left(AppFailure(e.error.toString()));
      }
      return Left(AppFailure(e.toString()));
    }
  }
  Future<Either<AppFailure, TransactionModel>> updateTransaction({
    String? id,
    required TransactionType type,
    required String categoryId,
    required String transactionDate,
    required double amount,
    String? description,
  }) async {
    try {
      final res = await _client.put(
        '/transaction/$id',
        data: {
          'id': id,
          'type': type.getValue(),
          'categoryId': categoryId,
          'transactionDate': transactionDate,
          'amount': amount,
          'description': description,
        },
      );
      Map<String, dynamic> resBody = res.data;
      //logger.log("response : $resBody\nstatusCode: ${res.statusCode}");
      if (res.statusCode! > 200) {
        return Left(AppFailure(resBody['message']));
      }
      TransactionModel transactions = TransactionModel.fromMapResponse(
        resBody['payload'],
      );
      return Right(transactions);
    } catch (e) {
      if (e is DioException) {
        return Left(AppFailure(e.error.toString()));
      }
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, bool>> deleteById(String id) async {
    try {
      await _client.delete("/transaction/$id");
      return Right(true);
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }
}
