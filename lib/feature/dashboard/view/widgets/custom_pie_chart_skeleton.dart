import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tang_tem_pao_mb/core/constant/dimension_constant.dart';

class CustomPieChartSkeleton extends StatelessWidget {
  const CustomPieChartSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final baseColor = isDark ? Colors.grey[900]! : Colors.grey[300]!;
    final highlightColor = isDark ? Colors.grey[800]! : Colors.grey[100]!;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: DimensionConstant.verticalPadding(context, 8),
          horizontal: DimensionConstant.horizontalPadding(context, 8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            Container(
              width: DimensionConstant.horizontalPadding(context, 60),
              height: DimensionConstant.horizontalPadding(context, 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 5),
            Center(
              child: Container(
                height: 200,
                // Responsive width for the chart circle
                width: DimensionConstant.screenWidth(context) * 0.4,
                decoration: const BoxDecoration(
                  color:
                      Colors.white, // Shimmer needs a solid color to paint on
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // --- Skeleton for the Legend (Indicators) ---
            SizedBox(
              height: 100,
              child: ListView.builder(
                physics:
                    const NeverScrollableScrollPhysics(), // Disable scrolling
                padding: EdgeInsets.symmetric(
                  horizontal: DimensionConstant.horizontalPadding(context, 3),
                ),
                itemCount: 4, // Display 4 skeleton indicator rows
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: <Widget>[
                        // Square indicator skeleton
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Text line skeleton
                        Container(
                          width: DimensionConstant.screenWidth(context) * 0.3,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
