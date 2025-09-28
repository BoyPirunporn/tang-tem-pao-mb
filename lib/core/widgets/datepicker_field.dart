import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tang_tem_pao_mb/core/constant/dimension_constant.dart';
import 'package:tang_tem_pao_mb/core/widgets/custom_field.dart';

class DatePickerField extends StatefulWidget {
  final DateTime? initialDate;
  final Function(DateTime)? onDateSelected;
  final DateTime? lastDate;
  final TextEditingController controller;
  final Text? label;
  final String? Function(String?)? validator;

  const DatePickerField({
    super.key,
    required this.controller,
    this.initialDate,
    this.onDateSelected,
    this.lastDate,
    this.label,
    this.validator
  });

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime.now();
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: widget.lastDate ?? DateTime(2100),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        widget.controller.text = DateFormat('yyyy-MM-dd').format(picked);
      });
      if (widget.onDateSelected != null) {
        widget.onDateSelected!(picked);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomField(
      controller: widget.controller,
      readOnly: true,
      onTap: _pickDate,
      label: widget.label ?? Text(
        "วันที่ทำธุรกรรม",
        style: TextStyle(
          fontSize: DimensionConstant.responsiveFont(context, 18),
        ),
      ),
      validator: widget.validator,
    );
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }
}
