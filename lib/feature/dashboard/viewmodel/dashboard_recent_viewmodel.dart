
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tang_tem_pao_mb/feature/dashboard/repository/dashboard_repository.dart';
import 'package:tang_tem_pao_mb/feature/transaction/model/transaction_model.dart';

part 'dashboard_recent_viewmodel.g.dart';


@Riverpod(keepAlive: true)
class DashboardRecentViewmodel extends _$DashboardRecentViewmodel {
  late DashboardRepository _dashboardRepository;
 @override
  Future<List<TransactionModel>> build() async {
    _dashboardRepository = ref.watch(dashboardRepositoryProvider);

    // เรียก fetch data ตอนแรก build
    final res = await _dashboardRepository.loadRecentTransaction();
    return res.match(
      (l) => throw l.message,
      (r) => r,
    );
  }
}