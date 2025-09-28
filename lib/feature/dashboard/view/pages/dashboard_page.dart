import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tang_tem_pao_mb/core/constant/dimension_constant.dart';
import 'package:tang_tem_pao_mb/core/theme/app_pallete.dart';
import 'package:tang_tem_pao_mb/core/utils/color_convert.dart';
import 'package:tang_tem_pao_mb/core/widgets/custom_appbar.dart';
import 'package:tang_tem_pao_mb/core/widgets/list_title_skeleton.dart';
import 'package:tang_tem_pao_mb/core/widgets/pie_chart.dart';
import 'package:tang_tem_pao_mb/feature/dashboard/view/widgets/dashboard_block_summary_skeleton.dart';
import 'package:tang_tem_pao_mb/feature/dashboard/view/widgets/summary_card.dart';
import 'package:tang_tem_pao_mb/feature/dashboard/viewmodel/dashboard_viewmodel.dart';
import 'package:tang_tem_pao_mb/feature/transaction/view/pages/transaction_page.dart';
import 'package:tang_tem_pao_mb/feature/transaction/view/widgets/transaction_list_item.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardViewModelProvider);
    final currencyFormat = NumberFormat.currency(locale: 'th_TH', symbol: '฿');
    return Scaffold(
      appBar: CustomAppBar(
        title: "แดชบอร์ด",
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list), // The filter icon
            tooltip: 'กรองข้อมูล', // Text shown on long press
            onPressed: () async {
              final DateTimeRange? picked = await showDateRangePicker(
                context: context,
                firstDate: DateTime(2020),
                lastDate: DateTime.now(), // เลื่อนได้หลายเดือน
                initialDateRange: ref.read(dashboardFilterProvider),
              );
              if (picked != null) {
                ref
                    .read(dashboardFilterProvider.notifier)
                    .setDateTimeRange(picked);
                ref.invalidate(dashboardViewModelProvider);
              }
              // showModalBottomSheet(
              //   context: context,

              //   builder: (BuildContext c) {
              //     return FractionallySizedBox(
              //       heightFactor: 0.8,
              //       child: Column(
              //         mainAxisSize: MainAxisSize.min,
              //         children: [
              //           SizedBox(height: 20),
              //           GestureDetector(
              //             onTap: () async {
              //               final DateTimeRange? picked =
              //                   await showDateRangePicker(
              //                     context: context,
              //                     firstDate: DateTime(2020),
              //                     lastDate: DateTime.now(), // เลื่อนได้หลายเดือน
              //                     initialDateRange: dateRange,
              //                   );
              //               if (picked != null) {
              //                 dateRange = picked;
              //               }
              //             },
              //             child: Padding(
              //               padding: const EdgeInsets.all(28.0),
              //               child: Container(
              //                 alignment: Alignment.center,
              //                 width: double.infinity,
              //                 height: DimensionConstant.horizontalPadding(
              //                   context,
              //                   12,
              //                 ),
              //                 decoration: BoxDecoration(
              //                   border: Border.all(
              //                     color: AppPallete.primaryDark,
              //                   ),
              //                   borderRadius: BorderRadius.circular(6),
              //                 ),
              //                 child: Text(
              //                   "${DateFormat('yyyy-MM-dd').format(from)} - ${DateFormat('yyyy-MM-dd').format(to)}",
              //                   textAlign: TextAlign.center,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     );
              //   },
              // );
            },
          ),
        ],
      ),
      body: dashboardState.when(
        loading: () => ListView(
          // แสดง Skeleton ทั้งสองส่วนขณะโหลด
          padding: EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: DimensionConstant.horizontalPadding(context, 3),
          ),
          children: const [
            DashboardBlockSummarySkeleton(),
            SizedBox(height: 24),
            ListTitleSkeleton(length: 5),
          ],
        ),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        data: (state) {
          final summary = state?.summary;
          final recentTransactions = state?.recentTransactions;
          final chart = state?.chart;
          List<PieData> chartData = chart == null
              ? List.empty()
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
          return ListView(
            padding: EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: DimensionConstant.horizontalPadding(context, 3),
            ),
            children: [
              if (summary == null)
                const Center(child: Text("ไม่มีข้อมูลสรุป"))
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'สรุปภาพรวมเดือนนี้',
                      style: TextStyle(
                        fontSize: DimensionConstant.responsiveFont(context, 18),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: SummaryCard(
                            title: 'รายรับ',
                            amount: currencyFormat.format(
                              summary.incomeOfMonth,
                            ),
                            color: Colors.green,
                            icon: Icons.arrow_downward_rounded,
                          ),
                        ),
                        Expanded(
                          child: SummaryCard(
                            title: 'รายจ่าย',
                            amount: currencyFormat.format(
                              summary.expenseOfMonth,
                            ),
                            color: Colors.red,
                            icon: Icons.arrow_upward_rounded,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              const SizedBox(height: 24),
              if (chartData.isEmpty)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Center(
                          child: Icon(
                            Icons.pie_chart,
                            size: DimensionConstant.horizontalPadding(
                              context,
                              20,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),

                        Center(
                          child: Text(
                            'ยังไม่มีร่ายการใช้จ่ายในช่วงเวลาที่คุณเลือก',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: DimensionConstant.responsiveFont(
                                context,
                                20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'ภามรวมรายการใช้จ่าย',
                          style: TextStyle(
                            fontSize: DimensionConstant.responsiveFont(
                              context,
                              20,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 200,
                          padding: EdgeInsets.all(
                            DimensionConstant.horizontalPadding(context, 2),
                          ),
                          child: CustomPieChart(data: chartData),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 24),

              if (recentTransactions == null)
                const Center(child: Text("ไม่มีข้อมูลสรุป"))
              else
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'รายการล่าสุด',
                          style: TextStyle(
                            fontSize: DimensionConstant.responsiveFont(
                              context,
                              18,
                            ),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => TransactionPage(),
                                transitionsBuilder: (_, animation, __, child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                                transitionDuration: const Duration(
                                  milliseconds: 500,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            'ดูทั้งหมด',
                            style: TextStyle(
                              color: AppPallete.primaryDark,
                              fontSize: DimensionConstant.responsiveFont(
                                context,
                                DimensionConstant.isMobile(context) ? 14 : 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          12,
                        ), // ถ้าอยากให้มุมโค้ง
                      ),
                      child: Column(
                        children: recentTransactions.map((tx) {
                          return TransactionListItem(
                            category: tx.category as String,
                            type: tx.type,
                            amount: tx.amount as double,
                            date: tx.transactionDate as String,
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }
}
