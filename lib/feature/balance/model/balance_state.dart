// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tang_tem_pao_mb/feature/balance/model/balance_model.dart';

class BalanceState {
  final List<BalanceModel> assets;
  final List<BalanceModel> liabilities;
  final double netWorth;
  BalanceState({
    required this.assets,
    required this.liabilities,
    required this.netWorth,
  });
}
