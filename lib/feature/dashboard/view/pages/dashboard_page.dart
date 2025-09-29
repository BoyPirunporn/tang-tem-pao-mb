import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tang_tem_pao_mb/core/constant/dimension_constant.dart';
import 'package:tang_tem_pao_mb/core/theme/app_pallete.dart';
import 'package:tang_tem_pao_mb/core/utils/color_convert.dart';
import 'package:tang_tem_pao_mb/core/widgets/custom_appbar.dart';
import 'package:tang_tem_pao_mb/core/widgets/pie_chart.dart';
import 'package:tang_tem_pao_mb/feature/dashboard/model/dashboard_summary_model.dart';
import 'package:tang_tem_pao_mb/feature/dashboard/view/widgets/custom_pie_chart_skeleton.dart';
import 'package:tang_tem_pao_mb/feature/dashboard/view/widgets/dashboard_block_recent_skeleton.dart';
import 'package:tang_tem_pao_mb/feature/dashboard/view/widgets/dashboard_block_summary_skeleton.dart';
import 'package:tang_tem_pao_mb/feature/dashboard/viewmodel/dashboard_viewmodel.dart';
import 'package:tang_tem_pao_mb/feature/transaction/view/pages/transaction_page.dart';
import 'package:tang_tem_pao_mb/feature/transaction/view/widgets/transaction_list_item.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardSummary = ref.watch(dashboardSummaryViewModelProvider);
    final dashboardChart = ref.watch(dashboardChartViewModelProvider);
    final dashboardRecent = ref.watch(dashboardRecentViewModelProvider);
    return Scaffold(
      appBar: CustomAppBar(
        title: "แดชบอร์ด",
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            tooltip: 'กรองข้อมูล',
            onPressed: () async {
              final DateTimeRange? picked = await showDateRangePicker(
                context: context,
                firstDate: DateTime(2020),
                lastDate: DateTime.now(),
                initialDateRange: ref.read(dashboardFilterProvider),
              );
              if (picked != null) {
                ref
                    .read(dashboardFilterProvider.notifier)
                    .setDateTimeRange(picked);
                ref.invalidate(dashboardSummaryViewModelProvider);
                ref.invalidate(dashboardChartViewModelProvider);
                ref.invalidate(dashboardRecentViewModelProvider);
              }
            },
          ),

          IconButton(
            icon: Icon(Icons.refresh_sharp),
            tooltip: 'เคลียร์ตัวกรอง',
            onPressed: () async {
              ref.invalidate(dashboardFilterProvider);
              ref.invalidate(dashboardSummaryViewModelProvider);
              ref.invalidate(dashboardChartViewModelProvider);
              ref.invalidate(dashboardRecentViewModelProvider);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(dashboardSummaryViewModelProvider);
          ref.invalidate(dashboardChartViewModelProvider);
          ref.invalidate(dashboardRecentViewModelProvider);
        },
        child: ListView(
          children: [
            dashboardSummary.when(
              loading: () => _buildLoadingSkeleton(
                context,
                DashboardBlockSummarySkeleton(),
              ),
              error: (error, stackTrace) =>
                  Center(child: Text(error.toString())),
              data: (summary) {
                return Padding(
                  padding: EdgeInsets.all(
                    DimensionConstant.horizontalPadding(context, 3),
                  ),
                  child: _buildSummarySection(context, summary),
                );
              },
            ),
            const SizedBox(height: 24),
            dashboardChart.when(
              loading: () =>
                  _buildLoadingSkeleton(context, CustomPieChartSkeleton()),
              error: (error, stackTrace) =>
                  Center(child: Text(error.toString())),
              data: (chart) {
                List<PieData> chartData = chart == null
                    ? []
                    : chart
                          .where((c) => c.value > 0)
                          .map(
                            (c) => PieData(
                              name: c.categoryName,
                              value: c.value,
                              color: ColorConvert.colorFromHex(c.color),
                            ),
                          )
                          .toList();
                return _buildExpenseChart(context, chartData);
              },
            ),
            const SizedBox(height: 24),
            dashboardRecent.when(
              loading: () => _buildLoadingSkeleton(
                context,
                DashboardBlockRecentSkeleton(),
              ),
              error: (error, stackTrace) =>
                  Center(child: Text(error.toString())),
              data: (recent) {
                return _buildRecentTransactions(context, recent);
              },
            ),
          ],
        ),
      ),
    );
  }

  // --- Refactored Widgets for better structure ---

  Widget _buildLoadingSkeleton(BuildContext context, Widget child) {
    return Padding(
      padding: EdgeInsets.all(DimensionConstant.horizontalPadding(context, 3)),
      child: child,
    );
  }

  Widget _buildSummarySection(
    BuildContext context,
    DashboardSummaryModel? summary,
  ) {
    final currencyFormat = NumberFormat.currency(locale: 'th_TH', symbol: '฿');
    if (summary == null) return const Center(child: Text("ไม่มีข้อมูลสรุป"));

    final totalAmount = summary.incomeOfMonth - summary.expenseOfMonth;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'สรุปภาพรวม',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _SecondarySummaryCard(
                title: 'รายรับ',
                amount: summary.incomeOfMonth,
                color: Colors.green,
                icon: Icons.arrow_downward_rounded,
                currencyFormat: currencyFormat,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _SecondarySummaryCard(
                title: 'รายจ่าย',
                amount: summary.expenseOfMonth,
                color: Colors.red,
                icon: Icons.arrow_upward_rounded,
                currencyFormat: currencyFormat,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _SecondarySummaryCard(
                title: 'เงินออม',
                amount: summary.saving,
                color: Colors.blueAccent,
                icon: Icons.savings_outlined,
                currencyFormat: currencyFormat,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _SecondarySummaryCard(
                title: 'ยอดรวม',
                amount: summary.expenseOfMonth,
                color: totalAmount < 0 ? Colors.red : Colors.green,
                icon: Icons.account_balance_wallet,
                currencyFormat: currencyFormat,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildExpenseChart(BuildContext context, List<PieData> chartData) {
    if (chartData.isEmpty) {
      return Card(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: DimensionConstant.verticalPadding(context, 8),
            horizontal: DimensionConstant.horizontalPadding(context, 8),
          ),
          child: Column(
            children: [
              Icon(
                Icons.pie_chart_outline,
                size: DimensionConstant.responsiveFont(context, 64),
                color: Colors.grey.shade400,
              ),
              const SizedBox(height: 16),
              Text(
                'ยังไม่มีรายการใช้จ่าย',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: DimensionConstant.responsiveFont(context, 18),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'ไม่พบรายการรายจ่ายในช่วงเวลาที่เลือก',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.all(DimensionConstant.responsiveFont(context, 10)),
      child: Column(
        children: [
          Text(
            'ภาพรวมรายการใช้จ่าย',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: DimensionConstant.height(context, 45),
            child: CustomPieChart(data: chartData),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentTransactions(
    BuildContext context,
    dynamic recentTransactions,
  ) {
    if (recentTransactions == null || recentTransactions.isEmpty) {
      return const SizedBox.shrink(); // Hide if no transactions
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'รายการล่าสุด',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () => Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => TransactionPage())),
              child: const Text('ดูทั้งหมด'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Card(
          child: Column(
            children: recentTransactions
                .map<Widget>(
                  (tx) => TransactionListItem(
                    category: tx.category as String,
                    type: tx.type,
                    amount: tx.amount as double,
                    date: tx.transactionDate as String,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _PrimarySummaryCard extends StatelessWidget {
  final double amount;
  final NumberFormat currencyFormat;

  const _PrimarySummaryCard({
    required this.amount,
    required this.currencyFormat,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 0,
        color: AppPallete.primaryDark.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(
            DimensionConstant.horizontalPadding(context, 5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ยอดคงเหลือ',
                style: TextStyle(
                  fontSize: DimensionConstant.responsiveFont(context, 18),
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                currencyFormat.format(amount),
                style: TextStyle(
                  fontSize: DimensionConstant.responsiveFont(context, 32),
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SecondarySummaryCard extends StatelessWidget {
  final String title;
  final double amount;
  final Color color;
  final IconData icon;
  final NumberFormat currencyFormat;

  const _SecondarySummaryCard({
    required this.title,
    required this.amount,
    required this.color,
    required this.icon,
    required this.currencyFormat,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: color.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(
          DimensionConstant.horizontalPadding(context, 5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: color,
                    fontSize: DimensionConstant.responsiveFont(context, 18),
                  ),
                ),
                Icon(
                  icon,
                  color: color,
                  size: DimensionConstant.responsiveFont(context, 20),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              currencyFormat.format(amount),
              style: TextStyle(
                fontSize: DimensionConstant.responsiveFont(context, 20),
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
