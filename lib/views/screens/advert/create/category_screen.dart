import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:obm_market/constants/app_theme.dart';
import 'package:obm_market/modules/auth/controllers/auth_controller.dart';
import 'package:obm_market/views/common/not_authorisation.dart';

import '../../../common/btn_bulk.dart';
import 'advert_create_screen.dart';

class CategoryScreen extends StatelessWidget {

  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {

    return (!authController.connected) ?
      NotAuthorisation(
        image: Image.asset('assets/images/advert.png'),
        title: 'Déposez votre annonce rapidement !',
        description: 'Facile avec notre assistance, suivez simplement des étapes.',
      ) :
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 65.0, right: 65.0, bottom: 20.0),
              child: Image.asset('assets/images/advert.png')
            ),
            Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
              child: Text(
                'Déposez votre annonce rapidement !',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              )
            ),
            Container(
              padding: EdgeInsets.only(bottom: 20.0, left: 10.0, right: 10.0),
              child: Text(
                'Facile avec notre assistance, suivez simplement des étapes.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppTheme.grey,
                ),
                textAlign: TextAlign.center,
              )
            ),

            Container(
              child: BtnBulk(
                text: 'Publier maintenant',
                color: AppTheme.white,
                backgroundColor: AppTheme.defaults,
                borderColor: AppTheme.defaults,
                icon: FontAwesomeIcons.arrowRight,
                iconPosition: 'right',
                callback: () {
                  Get.to(
                    () => AdvertCreateScreen(),
                    transition: Transition.upToDown,
                    duration: Duration(milliseconds: 500)
                  );
                },
              ),
            ),
            SizedBox(height: 62.0)
          ],
        )
    );
  }
}
