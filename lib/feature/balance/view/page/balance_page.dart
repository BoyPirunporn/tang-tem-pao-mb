import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tang_tem_pao_mb/core/constant/dimension_constant.dart';
import 'package:tang_tem_pao_mb/core/enum/balance_type_enum.dart';
import 'package:tang_tem_pao_mb/core/provider/dialog_provider.dart';
import 'package:tang_tem_pao_mb/core/theme/app_pallete.dart';
import 'package:tang_tem_pao_mb/core/widgets/bar_chart.dart';
import 'package:tang_tem_pao_mb/core/widgets/custom_appbar.dart';
import 'package:tang_tem_pao_mb/feature/balance/model/balance_model.dart';
import 'package:tang_tem_pao_mb/feature/balance/view/widget/balance_form.dart';
import 'package:tang_tem_pao_mb/feature/balance/viewmodel/balance_viewmodel.dart';
import 'package:tang_tem_pao_mb/feature/balance/viewmodel/networth_history_viewmodel.dart';

// [!] REFACTOR: The page is now more organized with a clear structure.
class BalancePage extends ConsumerWidget {
  const BalancePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2, // Simplified to two main tabs: Overview and History
      child: Scaffold(
        appBar: CustomAppBar(
          title: "การเงินสุทธิ",
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.pie_chart), text: 'ภาพรวม'),
              Tab(icon: Icon(Icons.show_chart), text: 'ประวัติ'),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () => _showAddDialog(context, ref),
              icon: Icon(
                Icons.add,
                size: DimensionConstant.responsiveFont(context, 32),
              ),
            ),
          ],
        ),
        body: TabBarView(
          children: [
            _OverviewTab(),
            Center(
              child: Text(
                "กำลังจะมาเร็วๆนี้",
                style: TextStyle(
                  fontSize: DimensionConstant.responsiveFont(context, 24),
                ),
              ),
            ),
            // _HistoryTab(),
          ],
        ),
      ),
    );
  }

  // Helper method to show a dialog for choosing what to add.
  void _showAddDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'เพิ่มรายการใหม่',
        ),
        content: Text(
          'คุณต้องการเพิ่มทรัพย์สินหรือหนี้สิน?',
          style: TextStyle(
            fontSize: DimensionConstant.responsiveFont(context, 16),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              DialogProvider.instance.showDialogBox(
                title: "เพิ่มทรัพย์สิน",
                content: BalanceForm(type: BalanceType.asset),
              );
            },
            child: Text(
              'ทรัพย์สิน',
              style: TextStyle(
                fontSize: DimensionConstant.responsiveFont(context, 16),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              DialogProvider.instance.showDialogBox(
                title: "เพิ่มหนี้สิน",
                content: BalanceForm(type: BalanceType.liability),
              );
            },
            child: Text(
              'หนี้สิน',
              style: TextStyle(
                color: AppPallete.destructiveDark,
                fontSize: DimensionConstant.responsiveFont(context, 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- WIDGET FOR THE OVERVIEW TAB ---
class _OverviewTab extends ConsumerWidget {
  const _OverviewTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balanceState = ref.watch(balanceViewModelProvider);
    final currencyFormat = NumberFormat("#,##0.00฿", "th_TH");

    return balanceState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('เกิดข้อผิดพลาด: $error')),
      data: (state) {
        return RefreshIndicator(
          onRefresh: () => ref.refresh(balanceViewModelProvider.future),
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildNetWorthCard(
                context,
                currencyFormat.format(state.netWorth),
              ),
              const SizedBox(height: 24),
              // [!] NEW: Donut chart for visual breakdown.
              _buildAssetLiabilityChart(
                context,
                state.assets.fold(0, (sum, item) => sum + item.value),
                state.liabilities.fold(0, (sum, item) => sum + item.value),
              ),
              const SizedBox(height: 24),
              _buildItemList(
                context,
                ref,
                "ทรัพย์สิน",
                state.assets,
                currencyFormat,
                AppPallete.ringDark,
              ),
              const SizedBox(height: 16),
              _buildItemList(
                context,
                ref,
                "หนี้สิน",
                state.liabilities,
                currencyFormat,
                AppPallete.destructiveDark,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNetWorthCard(BuildContext context, String netWorth) {
    // This is the main card showing the final net worth.
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [Color(0xFF2E7D32), Color(0xFF4CAF50)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ความมั่งคั่งสุทธิ",
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 4),
            Text(
              "สินทรัพย์ทั้งหมด - หนี้สินทั้งหมด",
              style: TextStyle(color: Colors.white.withOpacity(0.8)),
            ),
            const SizedBox(height: 16),
            Text(
              netWorth,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssetLiabilityChart(
    BuildContext context,
    double totalAssets,
    double totalLiabilities,
  ) {
    if (totalAssets == 0 && totalLiabilities == 0)
      return const SizedBox.shrink();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("สัดส่วน", style: Theme.of(context).textTheme.titleMedium),
            SizedBox(
              height: DimensionConstant.height(context, 25),
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: totalAssets,
                      color: AppPallete.ringDark,
                      title: 'ทรัพย์สิน',
                      radius: 50,
                    ),
                    PieChartSectionData(
                      value: totalLiabilities,
                      color: AppPallete.destructiveDark,
                      title: 'หนี้สิน',
                      radius: 50,
                    ),
                  ],
                  centerSpaceRadius: 40,
                  sectionsSpace: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemList(
    BuildContext context,
    WidgetRef ref,
    String title,
    List<BalanceModel> items,
    NumberFormat format,
    Color headerColor,
  ) {
    final double total = items.fold(0, (sum, item) => sum + item.value);

    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: headerColor),
                ),
                Text(
                  format.format(total),
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const Divider(indent: 16, endIndent: 16),
          if (items.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 32.0),
              child: Text("ไม่มีรายการ"),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  title: Text(item.name),
                  trailing: Text(format.format(item.value)),
                  onTap: () {
                    /* Optional: Edit item */
                  },
                  onLongPress: () {
                    DialogProvider.instance.showWarningDialog(
                      message: "คุณต้องการลบ '${item.name}' ใช่หรือไม่",
                      onOk: () async {
                        await ref
                            .read(balanceViewModelProvider.notifier)
                            .deleteById(item.id);
                      },
                    );
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}

class _HistoryTab extends ConsumerWidget {
  const _HistoryTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyState = ref.watch(netWorthHistoryViewModelProvider);
    return historyState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text(err.toString())),
      data: (snapshots) {
        if (snapshots.isEmpty) {
          return const Center(child: Text("ยังไม่มีข้อมูลประวัติ"));
        }
        return Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomBarchart(),
          ),
        );
      },
    );
  }
}
