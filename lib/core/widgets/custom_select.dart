import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:tang_tem_pao_mb/core/constant/dimension_constant.dart';
import 'package:tang_tem_pao_mb/core/theme/app_pallete.dart';

// 1. ทำให้เป็น Generic <T> เพื่อให้รับข้อมูลได้ทุกประเภท (String, Enum, etc.)
class CustomSelectBox<T> extends StatelessWidget {
  final String label; // เปลี่ยนจาก hintText เป็น label เพื่อความหมายที่ดีกว่า
  final String? hint;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final bool? readOnly;
  final AutovalidateMode? autovalidateMode;

  const CustomSelectBox({
    super.key,
    required this.label,
    this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
    this.validator,
    this.readOnly = false,
    this.autovalidateMode = AutovalidateMode.onUserInteraction
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<T>(
      autovalidateMode: autovalidateMode,
      value: value,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontSize: DimensionConstant.responsiveFont(
          context,
          16,
        ), // <-- ปรับขนาด Font ที่นี่
      ),
      decoration: InputDecoration(
        // disabledBorder: OutlineInputBorder(
        //   borderSide: BorderSide(
        //     color: Colors.grey.shade400, // ⭐️ สีของเส้นขอบ
        //     width: 1.0, // ⭐️ ความหนา
        //     style: BorderStyle.solid, // ⭐️ (ทางเลือก) รูปแบบเส้น (เช่น เส้นประ)
        //   ),
        //   borderRadius: BorderRadius.circular(8),
        // ),
        labelText: label, // ใช้ labelText จะลอยขึ้นข้างบนเมื่อมีค่า
        labelStyle: TextStyle(
          color: !!readOnly! ? Colors.grey.shade400 : AppPallete.ringDark,
          fontSize: DimensionConstant.responsiveFont(context, 18),
        ),
        contentPadding: DimensionConstant.isMobile(context)
            ? EdgeInsets.symmetric(
                vertical: DimensionConstant.verticalPadding(context, 4),
                horizontal: DimensionConstant.verticalPadding(context, 2),
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppPallete.ringDark),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppPallete.ringDark),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppPallete.destructiveDark),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppPallete.destructiveDark, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        errorStyle: TextStyle(
          color: AppPallete.destructiveDark,
          fontSize: DimensionConstant.responsiveFont(context, 16),
          fontWeight: FontWeight.w400,
        ),
        floatingLabelStyle: WidgetStateTextStyle.resolveWith((states) {
          if (states.contains(WidgetState.error)) {
            return const TextStyle(color: Colors.red); // label สีแดงตอน error
          }
          // if (states.contains(WidgetState.focused)) {
          //   return  TextStyle(
          //     color: AppPallete.primaryDark,
          //   ); // label สีน้ำเงินตอน focus
          // }
          return const TextStyle(color: AppPallete.primaryDark); // label สีเทาตอนปกติ
        }),
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).cardColor,
        ),
        offset: const Offset(0, -4),
      ),
      iconStyleData: const IconStyleData(
        icon: AnimatedRotation(
          turns: 0, // 0 = ไม่หมุน
          duration: Duration(milliseconds: 200),
          child: Icon(Icons.keyboard_arrow_down_rounded),
        ),
        openMenuIcon: AnimatedRotation(
          turns: 0.5, // 0.5 = หมุน 180 องศา
          duration: Duration(milliseconds: 200),
          child: Icon(Icons.keyboard_arrow_down_rounded),
        ),
      ),
      items: items,
      onChanged: onChanged,
      validator: validator,
      isExpanded: true,
      hint: hint != null
          ? Text(
              hint!,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: DimensionConstant.responsiveFont(context, 16),
              ),
            )
          : null,
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 5),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
        ), // padding ของแต่ละ item ในเมนู
      ),
    );
  }
}
