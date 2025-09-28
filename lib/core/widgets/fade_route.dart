import 'package:flutter/material.dart';

class FadeRoute extends PageRouteBuilder {
  final Widget page;

  FadeRoute({required this.page})
      : super(
          // ระบุ Widget ที่จะแสดงในหน้านั้นๆ
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          // ระบุ Animation ที่จะใช้
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation, // ใช้ค่า animation (0.0 ถึง 1.0) ควบคุมความโปร่งใส
            child: child,
          ),
          // (ทางเลือก) กำหนดระยะเวลาของ animation
          transitionDuration: const Duration(milliseconds: 400),
        );
}