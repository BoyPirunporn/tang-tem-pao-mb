import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tang_tem_pao_mb/core/constant/dimension_constant.dart';
import 'package:tang_tem_pao_mb/core/widgets/list_title_skeleton.dart';

class DashboardBlockRecentSkeleton extends StatelessWidget {
  const DashboardBlockRecentSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // กำหนดคู่สีแค่ชุดเดียว โดยเช็คจาก Theme
    final baseColor = isDark ? Colors.grey[900]! : Colors.grey[300]!;
    final highlightColor = isDark ? Colors.grey[800]! : Colors.grey[100]!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: DimensionConstant.horizontalPadding(context, 30),
                  height: DimensionConstant.horizontalPadding(context, 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Container(
                  width: DimensionConstant.horizontalPadding(context, 20),
                  height: DimensionConstant.horizontalPadding(context, 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // ถ้าอยากให้มุมโค้ง
          ),
          child: ListTitleSkeleton(length: 5),
        ),
      ],
    );
  }
}
