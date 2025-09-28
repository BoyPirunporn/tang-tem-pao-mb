import 'package:flutter/material.dart';
import 'package:tang_tem_pao_mb/core/constant/dimension_constant.dart';
import 'package:tang_tem_pao_mb/core/theme/app_pallete.dart';

class CustomField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final bool isObscureText;
  final bool readOnly;
  final VoidCallback? onTap;
  final EdgeInsets? contentPadding;
  final Text? label;
  final Decoration? decoration;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final double? height;
  final Function(String)? onChange;
  final AutovalidateMode? autovalidateMode;

  const CustomField({
    super.key,
    this.controller,
    this.hintText,
    this.isObscureText = false,
    this.readOnly = false,
    this.onTap,
    this.validator,
    this.contentPadding,
    this.label,
    this.decoration,
    this.prefixIcon,
    this.height,
    this.suffixIcon,
    this.onChange,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextFormField(
        onChanged: onChange,
        autovalidateMode: autovalidateMode,
        onTap: onTap,
        readOnly: readOnly,
        controller: controller,
        obscureText: isObscureText,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: suffixIcon,
          prefixIconConstraints: const BoxConstraints(
            minWidth: 40,
            minHeight: 40,
          ),
          // constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
          hintStyle: TextStyle(color: Colors.grey[500]),
          label: label,
          floatingLabelStyle: WidgetStateTextStyle.resolveWith((states) {
            if (states.contains(WidgetState.error)) {
              return const TextStyle(color: Colors.red); // label สีแดงตอน error
            }
            // if (states.contains(WidgetState.focused)) {
            //   return  TextStyle(
            //     color: AppPallete.primaryDark,
            //   ); // label สีน้ำเงินตอน focus
            // }
            return const TextStyle(
              color: AppPallete.primaryDark,
            ); // label สีเทาตอนปกติ
          }),
          labelStyle: TextStyle(
            color: Colors.grey[500],
            fontSize: DimensionConstant.responsiveFont(context, 16),
          ),
          isDense: true,
          prefixIcon: prefixIcon,

          contentPadding: DimensionConstant.isMobile(context)
              ? (contentPadding ??
                    EdgeInsets.symmetric(
                      vertical: DimensionConstant.horizontalPadding(context, 4),
                      horizontal: DimensionConstant.horizontalPadding(
                        context,
                        2,
                      ),
                    ))
              : null,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppPallete.ringDark), // ปกติ
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppPallete.ringDark), // ตอน focus
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppPallete.destructiveDark,
            ), // ตอน error
            borderRadius: BorderRadius.circular(8),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppPallete.destructiveDark,
              width: 2,
            ), // error + focus
            borderRadius: BorderRadius.circular(8),
          ),
          errorStyle: TextStyle(
            color: AppPallete.destructiveDark, // เปลี่ยนสีข้อความ error
            fontSize: DimensionConstant.responsiveFont(context, 16),
            fontWeight: FontWeight.w500,
          ),
        ),
        validator: validator,
      ),
    );
  }
}
