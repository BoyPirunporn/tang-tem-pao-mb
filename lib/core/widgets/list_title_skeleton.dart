import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListTitleSkeleton extends StatelessWidget {
  final int length;
  const ListTitleSkeleton({super.key, this.length = 5});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // กำหนดคู่สีแค่ชุดเดียว โดยเช็คจาก Theme
    final baseColor = isDark ? Colors.grey[900]! : Colors.grey[300]!;
    final highlightColor = isDark ? Colors.grey[800]! : Colors.grey[100]!;

    // ใช้ ListView.builder จะมีประสิทธิภาพดีกว่าการใช้ Column + map
    return ListView.builder(
      shrinkWrap: true, // ทำให้ ListView สูงเท่ากับ content ข้างใน
      physics: const NeverScrollableScrollPhysics(), // ป้องกันการ scroll ซ้อนกัน
      itemCount: length,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          period: const Duration(milliseconds: 2200), 
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.white, 
              radius: 24,
            ),
            title: Container(
              height: 16,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.white, 
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            subtitle: Container(
              height: 14,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            trailing: Container(
              height: 18,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        );
      },
    );
  }
}