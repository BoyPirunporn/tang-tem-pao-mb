import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tang_tem_pao_mb/core/constant/dimension_constant.dart';
import 'package:tang_tem_pao_mb/core/enum/budget_status_enum.dart';
import 'package:tang_tem_pao_mb/core/provider/dialog_provider.dart';
import 'package:tang_tem_pao_mb/core/theme/app_pallete.dart';
import 'package:tang_tem_pao_mb/core/widgets/custom_appbar.dart';
import 'package:tang_tem_pao_mb/feature/budget/helper/budget_helper.dart';
import 'package:tang_tem_pao_mb/feature/budget/model/budget_model.dart';
import 'package:tang_tem_pao_mb/feature/budget/viewmodel/budget_viewmodel.dart';

class BudgetPage extends ConsumerWidget {
  const BudgetPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final budgetState = ref.watch(budgetViewModelProvider);
    return Scaffold(
      appBar: CustomAppBar(title: "เป้าหมาย"),
      body: RefreshIndicator(
        onRefresh: () async => await ref.refresh(budgetViewModelProvider),
        child: Column(
          children: [
            SizedBox(height: 20),
            _buildToggleButton(ref, context),
            SizedBox(height: 20),
            Expanded(
              child: budgetState.when(
                loading: () => Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) =>
                    Center(child: Text(error.toString())),
                data: (budgets) {
                  if (budgets.isEmpty) {
                    return Center(
                      child: Text(
                        "ยังไม่มีเป้าหมายที่สำเร็จ",
                        style: TextStyle(
                          fontSize: DimensionConstant.responsiveFont(
                            context,
                            20,
                          ),
                        ),
                      ),
                    );
                  }
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      // Define a breakpoint for tablet-sized screens.
                      const double tabletBreakpoint = 600.0;

                      // If width is 600 or more (tablet), show 2 columns.
                      final int crossAxisCount =
                          constraints.maxWidth < tabletBreakpoint ? 1 : 2;

                      // Adjust the aspect ratio based on the column count for a better look.
                      final double aspectRatio = crossAxisCount == 1
                          ? 1.3
                          : 1.2;

                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: crossAxisCount == 1
                              ? 0
                              : 20, // No horizontal spacing for 1 column
                          childAspectRatio: aspectRatio,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: DimensionConstant.horizontalPadding(
                            context,
                            3,
                          ),
                          vertical: 8,
                        ),
                        itemCount: budgets.length,
                        itemBuilder: (cx, index) {
                          final BudgetModel budget = budgets[index];
                          return CardBudget(budget: budget);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "budgetPageFAB'",
        onPressed: () {
          BudgetHelper.showBottomSheet(context, "สร้าง");
        }, // Icon to display inside the button
        backgroundColor: AppPallete.primaryDark,
        child: Icon(Icons.add), // Optional: customize background color
      ),
    );
  }

  ToggleButtons _buildToggleButton(WidgetRef ref, BuildContext context) {
    final budgetStatus = ref.watch(budgetFilterProvider);
    return ToggleButtons(
      isSelected: [
        budgetStatus == BudgetStatus.active,
        budgetStatus == BudgetStatus.complete,
      ],
      onPressed: (index) {
        if (index == 0) {
          ref
              .read(budgetViewModelProvider.notifier)
              .setStatus(BudgetStatus.active);
        }
        if (index == 1) {
          ref
              .read(budgetViewModelProvider.notifier)
              .setStatus(BudgetStatus.complete);
        }
      },
      borderRadius: BorderRadius.circular(8),
      selectedColor: Colors.white,
      fillColor: AppPallete.primaryDark,
      color: Colors.grey[500],
      constraints: BoxConstraints(
        minHeight: 40,
        minWidth: DimensionConstant.horizontalPadding(context, 40),
        maxWidth: DimensionConstant.horizontalPadding(context, 55),
      ),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text("กำลังใช้งาน"),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('สำเร็จแล้ว'),
        ),
      ],
    );
  }
}

class CardBudget extends ConsumerWidget {
  final BudgetModel budget;
  const CardBudget({super.key, required this.budget});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: DimensionConstant.horizontalPadding(context, 4),
          horizontal: DimensionConstant.horizontalPadding(context, 5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    budget.categoryName,
                    style: TextStyle(
                      fontSize: DimensionConstant.responsiveFont(context, 20),
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                if (budget.status == BudgetStatus.active)
                  PopupMenuButton<String>(
                    menuPadding: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: 'edit',
                        onTap: () {
                          BudgetHelper.showBottomSheet(
                            context,
                            "แก้ไข",
                            budget: budget,
                          );
                        },
                        child: Row(
                          children: [
                            Icon(Icons.edit_outlined, color: Colors.grey),
                            const SizedBox(width: 12),
                            Text(
                              'แก้ไข',
                              style: TextStyle(
                                fontSize: DimensionConstant.responsiveFont(
                                  context,
                                  16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'complete',
                        onTap: () {
                          DialogProvider.instance.showDialogBox(
                            title: "บรรลุเป้าหมาย",
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Center(
                                  child: Text(
                                    "คุณต้องการจบเป้าหมายใช่หรือไม่",
                                    style: TextStyle(
                                      fontSize:
                                          DimensionConstant.responsiveFont(
                                            context,
                                            18,
                                          ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                        width: DimensionConstant.width(
                                          context,
                                          13,
                                        ),
                                        alignment: Alignment.center,
                                        constraints: BoxConstraints(
                                          minWidth: 80,
                                          maxWidth: 180,
                                        ),
                                        padding: EdgeInsets.all(
                                          DimensionConstant.horizontalPadding(
                                            context,
                                            1,
                                          ),
                                        ),
                                        child: Text(
                                          "ยกเลิก",
                                          style: TextStyle(
                                            color: AppPallete.destructiveDark,
                                            fontSize:
                                                DimensionConstant.responsiveFont(
                                                  context,
                                                  16,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        bool ok = true;
                                        if (budget.current <
                                            budget.targetAmount) {
                                          ok = await DialogProvider.instance
                                              .showWarningDialog(
                                                message:
                                                    "ยอดเงินปัจจุบรรยังไม่ถึงเป้าหมายที่ตั้งไว้ \nคุณต้องการที่จะจบเป้าหมายใช่หรือไม่?",
                                              );
                                        }
                                        if (ok) {
                                          await ref
                                              .read(
                                                budgetViewModelProvider
                                                    .notifier,
                                              )
                                              .editBudget(
                                                id: budget.id,
                                                categoryId: budget.categoryId,
                                                type: budget.type,
                                                targetAmount:
                                                    budget.targetAmount,
                                                startDate: budget.startDate,
                                                endDate: budget.endDate,
                                                status: BudgetStatus.complete,
                                              );
                                          ref.invalidate(
                                            budgetViewModelProvider,
                                          );
                                        }
                                        Future.microtask(() {
                                          if (context.mounted) {
                                            Navigator.pop(context);
                                          }
                                        });
                                      },
                                      child: Container(
                                        width: DimensionConstant.width(
                                          context,
                                          13,
                                        ),
                                        alignment: Alignment.center,
                                        constraints: BoxConstraints(
                                          minWidth: 80,
                                          maxWidth: 180,
                                        ),
                                        padding: EdgeInsets.all(
                                          DimensionConstant.horizontalPadding(
                                            context,
                                            1,
                                          ),
                                        ),
                                        child: Text(
                                          "ตกลง",
                                          style: TextStyle(
                                            color: AppPallete.primaryDark,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(Icons.check, color: Colors.greenAccent),
                            const SizedBox(width: 12),
                            Text(
                              'ทำสำเร็จแล้ว',
                              style: TextStyle(
                                fontSize: DimensionConstant.responsiveFont(
                                  context,
                                  16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'delete',
                        padding: EdgeInsets.zero,
                        onTap: () async {
                          DialogProvider.instance.showWarningDialog(
                            title: "Warning",
                            message:
                                "ต้องการที่จะลบเป้าหมาย ${budget.categoryName}",
                            onOk: () async {
                              await ref
                                  .read(budgetViewModelProvider.notifier)
                                  .deleteBudget(budget.id);
                            },
                          );
                        },
                        child: Container(
                          // ⭐️ 2. เพิ่ม borderRadius ให้ดูสวยงาม
                          decoration: BoxDecoration(
                            color: AppPallete.destructiveDark,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete_outline_rounded,
                                color: Colors.white,
                              ),
                              SizedBox(width: 12),
                              Text(
                                'ลบ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: DimensionConstant.responsiveFont(
                                    context,
                                    16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    icon: Icon(
                      CupertinoIcons.ellipsis,
                      size: DimensionConstant.responsiveFont(context, 20),
                    ),
                    tooltip: 'ตัวเลือกเพิ่มเติม',
                  )
                else
                  Container(
                    padding: EdgeInsets.all(
                      DimensionConstant.horizontalPadding(context, 1),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.greenAccent),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Icon(
                      Icons.check,
                      color: Colors.greenAccent,
                      size: DimensionConstant.responsiveFont(context, 14),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "สิ้นสุด ${budget.endDate}",
              style: TextStyle(
                fontSize: DimensionConstant.responsiveFont(context, 16),
                color: Colors.grey[500],
              ),
            ),
            SizedBox(height: 10),
            RichText(
              text: TextSpan(
                text:
                    "฿${NumberFormat.currency(locale: 'th_TH', symbol: '').format(budget.current)}",
                style: TextStyle(
                  fontFamily: "Kanit",
                  fontWeight: FontWeight.bold,
                  fontSize: DimensionConstant.responsiveFont(context, 28),
                  color: AppPallete.ringDark,
                ),
                children: [
                  TextSpan(
                    text:
                        "/ ฿${NumberFormat.currency(locale: 'th_TH', symbol: '').format(budget.targetAmount)}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[500],
                      fontSize: DimensionConstant.responsiveFont(context, 16),
                    ),
                  ),
                ],
              ),
            ),

            Spacer(),
            LinearProgressIndicator(
              value: budget.current / budget.targetAmount,
              minHeight: 10,
              borderRadius: BorderRadius.circular(10),
            ),
            SizedBox(height: 10),
            Text(
              "${((budget.current / budget.targetAmount) * 100).toStringAsFixed(0)}% ของเป้าหมาย",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[500],
                fontSize: DimensionConstant.responsiveFont(context, 14),
              ),
            ),
            SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
