import 'package:flutter/material.dart';
import 'package:tang_tem_pao_mb/core/constant/dimension_constant.dart';
import 'package:tang_tem_pao_mb/core/theme/app_pallete.dart';

class Button extends StatelessWidget {
  final String buttonText;
  final bool isSubmitting;
  final Color? color;
  final VoidCallback onTap;

  const Button({
    super.key,
    required this.buttonText,
    required this.onTap,
    this.isSubmitting = false,
    this.color = AppPallete.primaryDark
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient:  LinearGradient(
          colors: [color!, AppPallete.accentDark],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: ElevatedButton(
        onPressed: isSubmitting ? null : onTap,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(395, 55),
          backgroundColor: color,
          shadowColor: AppPallete.transparentColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              buttonText,
              style: TextStyle(
                color: AppPallete.inputDark,
                fontSize: DimensionConstant.responsiveFont(context, 17),
                fontWeight: FontWeight.w600,
              ),
            ),

            if (isSubmitting) ...[
              SizedBox(width: 20),
              SizedBox(
                height: DimensionConstant.horizontalPadding(context, 5),
                width: DimensionConstant.horizontalPadding(context, 5),
                child: CircularProgressIndicator(
                  color: AppPallete.accentForegroundDark,
                  strokeWidth: 2,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
