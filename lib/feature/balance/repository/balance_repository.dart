import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tang_tem_pao_mb/core/enum/balance_type_enum.dart';
import 'package:tang_tem_pao_mb/core/failure/app_failure.dart';
import 'package:tang_tem_pao_mb/core/provider/dio_provider.dart';
import 'package:tang_tem_pao_mb/feature/balance/model/balance_model.dart';
import 'package:tang_tem_pao_mb/feature/balance/model/networth_snapshot_model.dart';

final balanceRepositoryProvider = Provider<BalanceRepository>((ref) {
  // AuthRepository จะ "ขอ" httpClient ที่เราสร้างไว้มาใช้งาน
  final dio = ref.watch(dioProvider);
  return BalanceRepository(dio);
});

class BalanceRepository {
  final Dio _client;
  BalanceRepository(Dio client) : _client = client;

  Future<Either<AppFailure, List<BalanceModel>>> getAllBalance() async {
    try {
      final response = await _client.get("/balance");
      if (response.data == null) {
        return Left(AppFailure("เกิดข้อผิดพลาดในการโหลดข้อมูลการเงิน"));
      }
      List<BalanceModel> balances = (response.data['payload'] as List<dynamic>)
          .map((balance) => BalanceModel.fromResponseMap(balance))
          .toList();
      return Right(balances);
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, BalanceModel>> addBalance(
    String name,
    double value,
    BalanceType type,
  ) async {
    try {
      final res = await _client.post(
        "/balance",
        data: {'name': name, 'itemType': type.getValue(), 'value': value},
      );
      if (res.data == null) {
        return Left(
          AppFailure("ไม่สามารถสร้างรายการได้ กรุณาติต่อเจ้าหน้าที่"),
        );
      }
      BalanceModel balance = BalanceModel.fromResponseMap(res.data['payload']);
      return Right(balance);
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, String>> deleteById(String id) async {
    try {
      await _client.delete("/balance/$id");
      return Right("ลบรายการสำเร็จ");
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  Future<List<NetWorthSnapshotModel>> fetchHistory() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      NetWorthSnapshotModel(snapshotDate: DateTime(2025, 6, 30), netWorth: 340000.00),
      NetWorthSnapshotModel(snapshotDate: DateTime(2025, 7, 31), netWorth: 360000.00),
      NetWorthSnapshotModel(snapshotDate: DateTime(2025, 8, 31), netWorth: 380000.00),
      NetWorthSnapshotModel(snapshotDate: DateTime(2025, 9, 30), netWorth: 392000.00),
      NetWorthSnapshotModel(snapshotDate: DateTime(2025, 10, 31), netWorth: 410000.00),
    ];
  }
}
