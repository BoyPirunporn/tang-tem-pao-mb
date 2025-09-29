import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tang_tem_pao_mb/core/constant/dimension_constant.dart';

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
            height: DimensionConstant.horizontalPadding(context, 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 16),
          Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            child: Row(
              children: [
                _buildCardPlaceholder(context),
                _buildCardPlaceholder(context),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            child: Row(
              children: [
                _buildCardPlaceholder(context),
                _buildCardPlaceholder(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardPlaceholder(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
          // ปรับ Padding ให้น้อยลงเล็กน้อยเพื่อให้การ์ดดูสมส่วน
          horizontal: DimensionConstant.horizontalPadding(context, 1.5),
          vertical: DimensionConstant.verticalPadding(context, 1),
        ),
        child: Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            // ⭐️ ใช้ color ทึบเพื่อให้ Shimmer วาดทับได้
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

}
