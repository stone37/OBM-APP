import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:obm_market/constants/app_theme.dart';

class DialogData {
  DialogData();

  Future dialogImage({
    required String title,
    required String btnTitle,
    Image? image,
    IconData? btnIcon,
    VoidCallback? callback}) {

    return Get.defaultDialog(
      title: '',
      backgroundColor: AppTheme.primary,
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      radius: 30.0,
      content: Column(
        children: <Widget>[
          (image != null)
              ? Container(width: 70.0, child: image)
              : SizedBox(),
          (image != null) ? SizedBox(height: 20) : SizedBox(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
        padding: const EdgeInsets.only(left: 28.0, right: 28.0),
        margin: const EdgeInsets.only(bottom: 20.0),
        height: 38.0,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: callback,
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(5.0),
            backgroundColor: MaterialStateProperty.all<Color>(AppTheme.white),
            padding: MaterialStateProperty.all(
                EdgeInsets.only(top: 9.0, bottom: 9.0)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
                side: BorderSide(color: AppTheme.white),
              )
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 1.0),
                child: Text(
                  btnTitle,
                  style: TextStyle(
                    color: AppTheme.primary,
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0,
                    letterSpacing: 0.3
                  )
                ),
              ),
              (btnIcon != null) ?
              Container(
                padding: const EdgeInsets.only(left: 12.0),
                child: Icon(
                  btnIcon,
                  color: AppTheme.primary,
                  size: 15.0
                )
              ) : SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  Future dialogText({
    required String title,
    required String content,
    VoidCallback? onContinue,
    VoidCallback? onCancel}) {

    return Get.defaultDialog(
      title: '',
      titleStyle: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3
      ),
      confirm: SizedBox(),
      cancel: SizedBox(),
      textConfirm: '',
      textCancel: '',
      backgroundColor: AppTheme.white,
      titlePadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 0.0, top: 10),
      radius: 0.0,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: AppTheme.darkerText,
              letterSpacing: 0.3
            ),
          ),
          SizedBox(height: 15.0),
          Text(
            content,
            style: TextStyle(
              fontSize: 15.5,
              color: AppTheme.darkerText,
              letterSpacing: 0.3
            ),
          ),
          SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                onPressed: onCancel,
                child: Text(
                  'Rester'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.darkerText
                  ),
                )
              ),
              TextButton(
                onPressed: onContinue,
                child: Text(
                  'Quitter'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.darkerText
                  ),
                )
              )
            ],
          )
        ],
      ),
    );
  }
}