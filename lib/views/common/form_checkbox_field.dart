import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:obm_market/constants/app_theme.dart';

class FormCheckboxField extends StatelessWidget {
  FormCheckboxField({
    this.isChecked = false,
    required this.onChanged
  });

  final bool isChecked;
  final void  Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      checkColor: AppTheme.white,
      side: BorderSide(color: AppTheme.grey.withOpacity(0.5)),
      fillColor: MaterialStateProperty.all(AppTheme.danger_color),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0)
      ),
      onChanged: onChanged,
      value: isChecked,
    );
  }
}


