import 'package:intl/intl.dart';
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
    DateTime now = DateTime.now();
    DateFormat format = DateFormat("yyyy-MM-dd");
    String from = format.format(DateTime(now.year, now.month, 1));
    String to = format.format(now);
    // เรียก fetch data ตอนแรก build
    final res = await _dashboardRepository.loadRecentTransaction(
      page: 0,
      size: 10,
      from: from,
      to: to
    );
    return res.match((l) => throw l.message, (r) => r);
  }
}
