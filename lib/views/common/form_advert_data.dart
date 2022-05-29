import 'package:flutter/material.dart';
import 'package:obm_market/constants/app_theme.dart';

class FormDataField extends StatelessWidget {
  FormDataField(
      {required this.controller,
        this.validator,
        this.iconSuffix,
        this.prefix,
        this.keyboardType = TextInputType.text,
        this.obscureText = false,
        this.minLines = 1,
        this.maxLines,
        this.hintText,
        required this.onChanged,
        required this.onSaved,
        this.onTap
      });

  final TextEditingController controller;
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
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: iconSuffix,
        prefixIcon: prefix,
        filled: true,
        isDense: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.background, width: 1.6),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.primary, width: 1.6),
          borderRadius: BorderRadius.circular(30),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.danger_color, width: 1.6),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.danger_color, width: 1.6),
          borderRadius: BorderRadius.circular(30),
        ),
        errorStyle: TextStyle(
          color: AppTheme.danger_color,
          fontWeight: FontWeight.w500
        ),
      ),
      cursorHeight: 20,
      controller: controller,
      onSaved: onSaved,
      onChanged: onChanged,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      minLines: minLines,
      validator: validator,
      onTap: onTap,
    );
  }
}


class FormDataTextarea extends StatelessWidget {
  FormDataTextarea({
    required this.controller,
    this.validator,
    this.maxLines,
    this.hintText,
    required this.onChanged,
    required this.onSaved,
  });

  final TextEditingController controller;
  final int? maxLines;
  final String? hintText;
  final String? Function(String?)? validator;
  final void Function(String) onChanged;
  final void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.background, width: 1.6),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.primary, width: 1.6),
          borderRadius: BorderRadius.circular(30),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.danger_color, width: 1.6),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.danger_color, width: 1.6),
          borderRadius: BorderRadius.circular(30),
        ),
        errorStyle: TextStyle(
          color: AppTheme.danger_color,
          fontWeight: FontWeight.w500
        ),
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        errorMaxLines: 2
      ),
      maxLines: maxLines,
      cursorHeight: 20,
      controller: controller,
      onSaved: onSaved,
      onChanged: onChanged,
      keyboardType: TextInputType.multiline,
      validator: validator,
    );
  }
}

class FormRadioField extends StatelessWidget {
  FormRadioField({
    Key? key,
    required this.title,
    required this.value,
    required this.callback,
    required this.data
  }) : super(key: key);

  final String title;
  final String value;
  final  Function(String?) callback;
  final String? data;
  //final AdvertCreateController controller;

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 83.0,
      width: MediaQuery.of(context).size.width*0.21,
      decoration: BoxDecoration(
        color: (data == value) ?  AppTheme.defaults : AppTheme.white,
        borderRadius: BorderRadius.all(Radius.circular(20.0))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 8.0),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: (data == value) ?  AppTheme.white : AppTheme.darkerText,
              letterSpacing: 0.3
            ),
          ),
          Radio(
            value: value,
            groupValue: data,
            onChanged: callback,
            activeColor: (data == value) ? AppTheme.white : AppTheme.defaults,
          ),
        ],
      ),
    );
  }
}


class FormInputNoData extends StatelessWidget {
  const FormInputNoData({
    Key? key,
    required this.title,
    required this.content,
    required this.icon,
    this.helpText
  }) : super(key: key);

  final String title;
  final String content;
  final IconData icon;
  final String? helpText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 5.0, bottom: 5.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: AppTheme.darkerText,
              letterSpacing: 0.3,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(30)
          ),
          height: 45.0,
          child: Row(
            children: [
              SizedBox(width: 12.0),
              Icon(icon, color: AppTheme.primary),
              SizedBox(width: 10.0),
              Text(
                content,
                style: TextStyle(
                  fontSize: 15.5,
                  color: AppTheme.dark_grey.withOpacity(0.9),
                  letterSpacing: 0.3,
                ),
              )
            ],
          ),
        ),
        if (helpText != null)
        Padding(
          padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 3.0),
          child: Text(
            helpText!,
            style: TextStyle(
              fontSize: 13.0,
              color: AppTheme.dark_grey.withOpacity(0.7),
              letterSpacing: 0.3,
            ),
          ),
        )
      ],
    );
  }
}

class FormInputData extends StatelessWidget {
  const FormInputData({
    Key? key,
    required this.title,
    required this.content,
    this.icon,
    this.iconSuffix,
    this.helpText,
    this.borderState,
    required this.onTap
  }) : super(key: key);

  final String title;
  final Widget content;
  final IconData? icon;
  final IconData? iconSuffix;
  final String? helpText;
  final bool? borderState;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 5.0, bottom: 5.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: AppTheme.darkerText,
              letterSpacing: 0.3,
            ),
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: (borderState != null) ? (borderState! ? AppTheme.danger_color : AppTheme.white) : AppTheme.white,
                width: 1.6
              )
            ),
            height: 45.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 12.0),
                      (icon != null) ? Icon(icon, color: AppTheme.grey) : const SizedBox(),
                      SizedBox(width: 10.0),
                      content
                    ],
                  ),
                ),
                (iconSuffix != null) ? Row(
                  children: <Widget>[
                    Icon(iconSuffix, color: AppTheme.grey, size: 19.0),
                    SizedBox(width: 13.0)
                  ],
                ) : const SizedBox()
              ],
            ),
          ),
        ),
        if (helpText != null)
          Padding(
            padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 3.0),
            child: Text(
              helpText!,
              style: TextStyle(
                fontSize: 13.0,
                color: AppTheme.dark_grey.withOpacity(0.7),
                letterSpacing: 0.3,
              ),
            ),
          )
      ],
    );
  }
}

class FormFilterInputData extends StatelessWidget {
  const FormFilterInputData({
    Key? key,
    required this.title,
    required this.content,
    this.icon,
    this.iconSuffix,
    this.helpText,
    this.borderState,
    required this.onTap
  }) : super(key: key);

  final String title;
  final Widget content;
  final IconData? icon;
  final IconData? iconSuffix;
  final String? helpText;
  final bool? borderState;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 5.0, bottom: 2.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w500,
              color: AppTheme.darkerText,
              letterSpacing: 0.3,
            ),
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: (borderState != null) ? (borderState! ? AppTheme.danger_color : AppTheme.white) : AppTheme.white,
                width: 1.6
              )
            ),
            height: 45.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 12.0),
                      (icon != null) ? Icon(icon, color: AppTheme.grey) : const SizedBox(),
                      SizedBox(width: 10.0),
                      content
                    ],
                  ),
                ),
                (iconSuffix != null) ? Row(
                  children: <Widget>[
                    Icon(iconSuffix, color: AppTheme.grey, size: 19.0),
                    SizedBox(width: 13.0)
                  ],
                ) : const SizedBox()
              ],
            ),
          ),
        ),
        if (helpText != null)
          Padding(
            padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 3.0),
            child: Text(
              helpText!,
              style: TextStyle(
                fontSize: 13.0,
                color: AppTheme.dark_grey.withOpacity(0.7),
                letterSpacing: 0.3,
              ),
            ),
          )
      ],
    );
  }
}

