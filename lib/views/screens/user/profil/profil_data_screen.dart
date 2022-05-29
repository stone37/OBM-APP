import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:obm_market/constants/app_theme.dart';

import 'data/account_close_screen.dart';
import 'data/password_edit_screen.dart';
import 'data/profil_edit_screen.dart';

class ProfilDataScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppTheme.background,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
          ),
          titleSpacing: 0.0,
          elevation: 0,
          backgroundColor: AppTheme.background,
          title: Text(
            'Modifier vos informations',
            style: TextStyle(
              color: AppTheme.darkerText
            )
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
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
                  leading: Icon(FontAwesomeIcons.userEdit, color: AppTheme.dark_grey.withOpacity(0.8), size: 20.0),
                  trailing: Icon(FontAwesomeIcons.angleRight, color: AppTheme.dark_grey.withOpacity(0.6), size: 17.0),
                  title: Text(
                    'Modification du profil',
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
                        'Modifier votre profil.',
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
                    Get.to(() => ProfilEditScreen());
                  },
                ),
              ),
              Divider(height: 0.0),
              Material(
                color: AppTheme.background,
                child: ListTile(
                  leading: Icon(FontAwesomeIcons.lockOpen, color: AppTheme.dark_grey.withOpacity(0.8), size: 20.0),
                  trailing: Icon(FontAwesomeIcons.angleRight, color: AppTheme.dark_grey.withOpacity(0.6), size: 17.0),
                  title: Text(
                    'Edition du mot de passe',
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
                        'Modifier votre mot de passe.',
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
                    Get.to(() => PasswordEditScreen());
                  },
                ),
              ),
              Divider(height: 0.0),
              Material(
                color: AppTheme.background,
                child: ListTile(
                  leading: Icon(FontAwesomeIcons.trash, color: AppTheme.danger_color.withOpacity(0.8), size: 20.0),
                  trailing: Icon(FontAwesomeIcons.angleRight, color: AppTheme.dark_grey.withOpacity(0.6), size: 17.0),
                  title: Text(
                    'Fermeture du compte',
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
                        'Fermer votre compte.',
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
                    Get.to(() => AccountCloseScreen());
                  },
                ),
              ),
              Divider(height: 0.0),
            ],
          ),
        )
    );
  }
}
