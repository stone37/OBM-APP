import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:obm_market/constants/app_theme.dart';

class FormInputFieldWithIcon extends StatelessWidget {
  FormInputFieldWithIcon({
      required this.controller,
      required this.iconPrefix,
      required this.labelText,
      required this.validator,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.minLines = 1,
      this.maxLines,
      this.iconSuffix,
      required this.onChanged,
      required this.onSaved});

  final TextEditingController controller;
  final IconData iconPrefix;
  final InkWell? iconSuffix;
  final String labelText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final int minLines;
  final int? maxLines;
  final void Function(String) onChanged;
  final void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        prefixIcon: Icon(iconPrefix),
        suffixIcon: iconSuffix,
        labelText: labelText,
        contentPadding: EdgeInsets.all(8.0),
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
        labelStyle: TextStyle(
          fontWeight: FontWeight.w400,
          letterSpacing: 0.3,
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
