import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tang_tem_pao_mb/feature/balance/model/networth_snapshot_model.dart';
import 'package:tang_tem_pao_mb/feature/balance/repository/balance_repository.dart';

part 'networth_history_viewmodel.g.dart';

@riverpod
class NetWorthHistoryViewModel extends _$NetWorthHistoryViewModel {
    late BalanceRepository _balanceRepository;

  @override
  Future<List<NetWorthSnapshotModel>> build() async {
    _balanceRepository = ref.read(balanceRepositoryProvider);
    return _fetchHistory();
  }

  /// Helper method to fetch data from the repository.
  Future<List<NetWorthSnapshotModel>> _fetchHistory() async {
    return _balanceRepository.fetchHistory();
  }
}
