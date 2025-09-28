// balance_page.dart (Refactored)

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tang_tem_pao_mb/core/enum/balance_type_enum.dart';
import 'package:tang_tem_pao_mb/core/widgets/custom_appbar.dart';
import 'package:tang_tem_pao_mb/feature/balance/view/widget/balance_category_card.dart';
import 'package:tang_tem_pao_mb/feature/balance/viewmodel/balance_viewmodel.dart';

class BalancePage extends ConsumerWidget {
  const BalancePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balanceState = ref.watch(balanceViewModelProvider);
    final currencyFormat = NumberFormat("#,##0.00฿", "th_TH");

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: CustomAppBar(
          title: "การเงิน",
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: 'ภาพรวม'),
              Tab(text: 'ทรัพย์สิน'),
              Tab(text: 'หนี้สิน'),
            ],
          ),
        ),
        body: balanceState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) =>
              Center(child: Text('เกิดข้อผิดพลาด: $error')),
          data: (state) {
            return TabBarView(
              children: [
                _buildHeading(context, currencyFormat.format(state.netWorth)),
                BalanceCategoryCard(
                  title: "ทรัพย์สิน",
                  type: BalanceType.asset,
                  items: state.assets,
                  
                ),
                BalanceCategoryCard(
                  title: "หนี้สิน",
                  type: BalanceType.liability,
                  items: state.liabilities
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeading(BuildContext context, String netWorth) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: const LinearGradient(
              colors: [Color(0xFF2b7fff), Color(0xFF4f39f6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "การเงินสุทธิ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "สินทรัพย์ทั้งหมด - หนี้สินทั้งหมด",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 24),
                Text(
                  netWorth,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
