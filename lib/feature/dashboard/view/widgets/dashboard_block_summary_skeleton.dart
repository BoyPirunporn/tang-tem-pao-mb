import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tang_tem_pao_mb/core/constant/dimension_constant.dart';
import 'package:tang_tem_pao_mb/feature/dashboard/view/widgets/summary_skelenton_card.dart';

class DashboardBlockSummarySkeleton extends ConsumerWidget {
  const DashboardBlockSummarySkeleton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // กำหนดคู่สีแค่ชุดเดียว โดยเช็คจาก Theme
    final baseColor = isDark ? Colors.grey[900]! : Colors.grey[300]!;
    final highlightColor = isDark ? Colors.grey[800]! : Colors.grey[100]!;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: DimensionConstant.horizontalPadding(context, 45),
            height: DimensionConstant.horizontalPadding(context, 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 16),
          SummaryCardSkeleton(),
         ],
      ),
    );
  }
}
