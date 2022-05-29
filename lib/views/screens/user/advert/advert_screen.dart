import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:obm_market/constants/app_theme.dart';
import 'package:obm_market/modules/auth/controllers/auth_controller.dart';
import 'package:obm_market/views/common/not_authorisation.dart';
import 'package:obm_market/views/screens/user/advert/user_advert_enabled_screen.dart';
import 'package:obm_market/views/screens/user/advert/user_advert_screen.dart';

class AdvertScreen extends StatelessWidget {
  const AdvertScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final AuthController authController = Get.find();

    return (authController.connected == false) ?
      NotAuthorisation(
        image: Image.asset('assets/images/annonce.png'),
        title: 'Toutes vos annonces au même endroit.',
        description: 'Modifier et gérer facilement vos annonces.',
      ) : Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Material(
            color: AppTheme.background,
            child: ListTile(
              leading: Icon(FontAwesomeIcons.clipboard, color: AppTheme.dark_grey.withOpacity(0.8), size: 20.0),
              trailing: Icon(FontAwesomeIcons.angleRight, color: AppTheme.dark_grey.withOpacity(0.6), size: 17.0),
              title: Text(
                'Mes annonces inactif',
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
                    'Ici sont regrouper tout vous annonce en attente de validation.',
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
              contentPadding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 20.0, left: 20.0),
              dense: true,
              onTap: () {
                Get.to(() => UserAdvertScreen());
              },
            ),
          ),
          Divider(height: 0.0),
          Material(
            color: AppTheme.background,
            child: ListTile(
              leading: Icon(FontAwesomeIcons.clipboardCheck, color: AppTheme.dark_grey.withOpacity(0.8), size: 20.0),
              trailing: Icon(FontAwesomeIcons.angleRight, color: AppTheme.dark_grey.withOpacity(0.6), size: 17.0),
              title: Text(
                'Mes annonce en ligne',
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
                    'Ici sont regrouper tout vous annonce en ligne.',
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
                Get.to(() => UserAdvertEnabledScreen());
              },
            ),
          ),
          Divider(height: 0.0),
        ],
    );
  }
}
