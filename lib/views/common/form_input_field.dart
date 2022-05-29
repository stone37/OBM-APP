import 'package:flutter/material.dart';
import 'package:obm_market/constants/app_theme.dart';

class FormInputField extends StatelessWidget {
  FormInputField(
      {required this.controller,
      required this.labelText,
      this.validator,
      this.iconSuffix,
      this.prefix,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.minLines = 1,
      this.maxLines,
      this.hintText,
      required this.onChanged,
      required this.onSaved});

  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final int minLines;
  final int? maxLines;
  final Widget? iconSuffix;
  final Widget? prefix;
  final String? hintText;
  final void Function(String) onChanged;
  final void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        labelText: labelText,
        suffixIcon: iconSuffix,
        prefix: prefix,
        hintText: hintText,
        contentPadding: EdgeInsets.all(5.0),
        fillColor: AppTheme.grey.withOpacity(0.1),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppTheme.grey.withOpacity(0.5), width: 1.4),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppTheme.primary, width: 1.4),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppTheme.danger_color, width: 1.4),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppTheme.danger_color, width: 1.4),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        errorStyle: TextStyle(
          color: AppTheme.danger_color
        ),
      ),
      controller: controller,
      onSaved: onSaved,
      onChanged: onChanged,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      minLines: minLines,
      validator: validator,
    );
  }
}





