import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:obm_market/modules/auth/controllers/auth_controller.dart';
import 'package:obm_market/views/common/not_authorisation.dart';
import 'package:obm_market/views/screens/user/alert/user_alert_enabled_screen.dart';
import 'package:obm_market/views/screens/user/alert/user_alert_screen.dart';

import '../../../../constants/app_theme.dart';

class AlertScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              titleSpacing: 0.0,
              elevation: 0,
              backgroundColor: AppTheme.background,
              title: Text(
                'Gérer mes alertes',
                style: TextStyle(color: AppTheme.darkerText)
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                splashRadius: 20.0,
                onPressed: () => Get.back(),
              ),
            ),
            body: Container(
              decoration: BoxDecoration(
                color: AppTheme.background,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Material(
                    color: AppTheme.background,
                    child: ListTile(
                      leading: Icon(FontAwesomeIcons.bell, color: AppTheme.dark_grey.withOpacity(0.8), size: 20.0),
                      trailing: Icon(FontAwesomeIcons.angleRight, color: AppTheme.dark_grey.withOpacity(0.6), size: 17.0),
                      title: Text(
                        'Mes alertes active',
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.darkerText,
                          letterSpacing: 0.3
                        ),
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5.0),
                          Text(
                            'Ici sont regrouper tous vos alertes actives.',
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                color: AppTheme.grey,
                                letterSpacing: 0.3
                            ),
                          )
                        ],
                      ),
                      visualDensity: VisualDensity.comfortable,
                      contentPadding: EdgeInsets.only(top: 6.0, bottom: 6.0, right: 20.0, left: 20.0),
                      dense: true,
                      onTap: () {
                        Get.to(() => UserAlertEnabledScreen());
                      },
                    ),
                  ),
                  Divider(height: 0.0),
                  Material(
                    color: AppTheme.background,
                    child: ListTile(
                      leading: Icon(FontAwesomeIcons.bellSlash, color: AppTheme.dark_grey.withOpacity(0.8), size: 20.0),
                      trailing: Icon(FontAwesomeIcons.angleRight, color: AppTheme.dark_grey.withOpacity(0.6), size: 17.0),
                      title: Text(
                        'Mes alertes inactive',
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.darkerText,
                          letterSpacing: 0.3
                        ),
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5.0),
                          Text(
                            'Ici sont regrouper tous vos alertes inactive.',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                              color: AppTheme.grey,
                              letterSpacing: 0.3
                            ),
                          )
                        ],
                      ),
                      visualDensity: VisualDensity.comfortable,
                      contentPadding: EdgeInsets.only(top: 6.0, bottom: 6.0, right: 20.0, left: 20.0),
                      dense: true,
                      onTap: () {
                        Get.to(() => UserAlertScreen());
                      },
                    ),
                  ),
                  Divider(height: 0.0),
                ],
              ),
            )
        )
    );
  }
}
