import 'package:flutter/material.dart';
import 'package:tang_tem_pao_mb/core/constant/dimension_constant.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions; // ⭐️ ทำให้สามารถเพิ่มปุ่ม Action ได้
  final TabBar? bottom;
  final bool centerTitle;
  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.bottom,
    this.centerTitle = false
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: DimensionConstant.responsiveFont(context, 28),
        ),
      ),
      bottom: bottom,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: centerTitle,
      actions: actions,
    );
  }

  @override
  Size get preferredSize {
    final tabBarHeight = bottom?.preferredSize.height ?? 0.0;
    return Size.fromHeight(kToolbarHeight + tabBarHeight);
  }
}
