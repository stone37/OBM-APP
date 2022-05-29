import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:obm_market/constants/app_theme.dart';

class DialogData {
  static Future image({
    required String title,
    String? btnTitle,
    Color? backgroundColor,
    Color? btnColor,
    Color? btnBorderColor,
    Color? btnTextColor,
    Image? image,
    IconData? btnIcon,
    VoidCallback? callback
    }) {

    return Get.defaultDialog(
      title: '',
      backgroundColor: backgroundColor != null ? backgroundColor : AppTheme.white,
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      radius: 30.0,
      content: Column(
        children: <Widget>[
          Container(
            width: 120.0,
            height: 100.0,
            child: image,
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.3,
                color: AppTheme.white
              ),
            ),
          ),
        ],
      ),
      confirm: Container(
        padding: EdgeInsets.only(left: 28.0, right: 28.0),
        margin: EdgeInsets.only(bottom: 20.0),
        height: 40.0,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: callback,
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(5.0),
            backgroundColor: MaterialStateProperty.all<Color>(btnColor!),
            padding: MaterialStateProperty.all(EdgeInsets.only(top: 9.0, bottom: 9.0)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
                side: BorderSide(color: btnBorderColor!),
              )
            ),
          ),
          child: (btnTitle != null) ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 1.0),
                child: Text(
                  btnTitle,
                  style: TextStyle(
                    color: btnTextColor!,
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0,
                    letterSpacing: 0.3
                  )
                ),
              ),
              (btnIcon != null) ?
              Container(
                padding: EdgeInsets.only(left: 12.0),
                child: Icon(
                  FontAwesomeIcons.arrowRight,
                  color: btnTextColor,
                  size: 15.0
                )
              ) : SizedBox()
            ],
          ) : SizedBox(),
        ),
      ),
    );
  }
}
