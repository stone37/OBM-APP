import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:obm_market/constants/app_theme.dart';

showSuccessMessage({required String message, IconData? icon}) {
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
    backgroundColor: AppTheme.darkerText.withOpacity(0.8),
    borderRadius: 8.0,
    icon: Icon((icon != null) ? icon : FontAwesomeIcons.check, color: AppTheme.white, size: 18.0),
    shouldIconPulse: false,
    padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 15.0),
    margin: EdgeInsets.all(8.0)
  );
}

