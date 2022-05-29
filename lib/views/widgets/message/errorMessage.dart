import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:obm_market/constants/app_theme.dart';

showErrorMessage(String message) {
  Get.snackbar(
      '',
      '',
    titleText: SizedBox(),
    messageText: Text(
      message,
      style: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: AppTheme.white
      )
    ),
    duration: Duration(seconds: 5),
    snackPosition: SnackPosition.TOP,
    barBlur: 30.0,
    backgroundColor: AppTheme.danger_color.withOpacity(0.8),
    borderRadius: 8.0,
    shouldIconPulse: false,
    icon: Icon(FontAwesomeIcons.exclamationTriangle, color: AppTheme.white, size: 18.0),
    padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 15.0),
    margin: EdgeInsets.all(8.0)
  );
}

