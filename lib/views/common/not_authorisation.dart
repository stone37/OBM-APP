import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:obm_market/views/common/btn_bulk.dart';
import 'package:obm_market/views/screens/security/login_screen.dart';

import '../../constants/app_theme.dart';

class NotAuthorisation extends StatelessWidget {
  const NotAuthorisation({
    Key? key,
    this.image,
    this.title,
    this.description,
  }) : super(key: key);

  final Widget? image;
  final String? title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            (image != null) ? Container(
                padding: EdgeInsets.only(left: 65.0, right: 65.0, bottom: 20.0),
                child: image!) : SizedBox(),

            (title != null) ? Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                child: Text(
                  title!,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.darkerText
                  ),
                  textAlign: TextAlign.center,
                )) : SizedBox(),

            (description != null) ? Container(
              padding: EdgeInsets.only(bottom: 20.0, left: 10.0, right: 10.0),
              child: Text(
                description!,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppTheme.grey,
                ),
                textAlign: TextAlign.center,
              )
            ) : SizedBox(),

            Container(
              child: BtnBulk(
                text: 'Connectez-vous d\'abord',
                color: AppTheme.white,
                backgroundColor: AppTheme.primary,
                borderColor: AppTheme.primary,
                icon: FontAwesomeIcons.arrowRight,
                iconPosition: 'right',
                callback: () => Get.to(
                  () => LoginScreen(),
                  transition: Transition.upToDown,
                  duration: Duration(milliseconds: 300)
                ),
              ),
            ),
            SizedBox(height: 62.0)
          ],
        )
    );
  }
}
