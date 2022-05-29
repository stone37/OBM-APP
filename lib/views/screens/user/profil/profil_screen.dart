import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:obm_market/constants/app_theme.dart';
import 'package:obm_market/modules/advert/models/entities/advert.dart';
import 'package:obm_market/modules/auth/controllers/auth_controller.dart';
import 'package:obm_market/modules/menu/controllers/menu_controller.dart';
import 'package:obm_market/modules/user/notification/controllers/notification_controller.dart';
import 'package:obm_market/modules/user/notification/models/entities/notification.dart';
import 'package:obm_market/modules/user/profil/controllers/profil_controller.dart';
import 'package:obm_market/modules/user/thread/controllers/thread_controller.dart';
import 'package:obm_market/views/common/not_authorisation.dart';
import 'package:obm_market/views/screens/user/profil/profil_data_screen.dart';

import '../../../../modules/user/thread/models/entities/thread.dart';

class ProfilScreen extends StatelessWidget {

  final AuthController authController = Get.find();
  final MenuController menuController = Get.find();
  final ProfilController controller = Get.find();
  final NotificationController notificationController = Get.find();
  final ThreadController threadController = Get.find();
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    if (box.hasData('user_file'))
      controller.photoProfil.value = box.read('user_file');

    return (authController.connected == false) ?
      NotAuthorisation(
        image: Image.asset('assets/images/profile.png'),
        title: 'Votre espace personnel vous attend :)',
        description: 'Gérez facilement vos informations.'
      ) : Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                        splashColor: AppTheme.nearlyBlue.withOpacity(0.2),
                        onTap: () async {
                          await controller.changeProfilImage();
                        },
                        child: Stack(
                          children: <Widget>[
                            Obx(() => CircleAvatar(
                              backgroundColor: AppTheme.defaults,
                              minRadius: 50.0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  (box.read('user_file') == null) ?
                                  CircleAvatar(
                                    radius: 50.0,
                                    backgroundColor: AppTheme.defaults,
                                    child: Container(
                                      child: Text(
                                        '${box.read('user_firstname')[0]}',
                                        style: TextStyle(
                                          fontSize: 60.0,
                                          fontWeight: FontWeight.bold,
                                          color: AppTheme.white
                                        ),
                                      ),
                                    ),
                                  ) : CircleAvatar(
                                    radius: 50.0,
                                    backgroundImage: NetworkImage('https://oblackmarket.com/public/' + controller.photoProfil.value),
                                  )
                                ],
                              ),
                            )),
                            Positioned(
                              right: MediaQuery.of(context).size.width*0.37,
                              top: 70.0,
                              child: Container(
                                width: 28.0,
                                height: 28.0,
                                decoration: BoxDecoration(
                                  color: AppTheme.secondary,
                                  borderRadius: BorderRadius.all(Radius.circular(30.0))
                                ),
                                child: Center(child: Icon(FontAwesomeIcons.plus, size: 15.0, color: AppTheme.white)),
                              ),
                            )
                          ],
                        )
                      ),
                    ),
                    SizedBox(height: 6.0),
                    Padding(
                        padding: EdgeInsets.zero,
                        child: Text(
                          '${box.read('user_firstname')}',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.darkerText,
                            letterSpacing: 0.3
                          ),
                        )
                    ),
                    Padding(
                      padding: EdgeInsets.zero,
                      child: Text(
                        '${box.read('user_email')}',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.grey,
                          letterSpacing: 0.3
                        ),
                      )
                    ),
                    SizedBox(height: 15.0),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 14.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            child: Column(
                              children: <Widget>[
                                FutureBuilder<List<Advert>>(
                                  future: controller.getAdvertEnabled(),
                                  builder: (BuildContext context, AsyncSnapshot<List<Advert>> snapshot) {
                                    return Text(
                                      (snapshot.hasData) ? '${snapshot.data?.length}' : '0',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.primary
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  'Annonces'.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.3
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            color: AppTheme.grey.withOpacity(0.5),
                            width: 1.6,
                            height: 40.0,
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                FutureBuilder<List<Thread>>(
                                  future: threadController.getUserThread(),
                                  builder: (BuildContext context, AsyncSnapshot<List<Thread>> snapshot) {
                                    return Text(
                                      (snapshot.hasData) ? '${snapshot.data?.length}' : '0',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w500,
                                        color: AppTheme.primary
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  'Messages'.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.3
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            color: AppTheme.grey.withOpacity(0.5),
                            width: 1.6,
                            height: 40.0,
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                FutureBuilder<List<UserNotification>>(
                                  future: notificationController.getUserNotification(),
                                  builder: (BuildContext context, AsyncSnapshot<List<UserNotification>> snapshot) {
                                    return Text(
                                      (snapshot.hasData) ? '${snapshot.data?.length}' : '0',
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600,
                                          color: AppTheme.primary
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  'Notifications'.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.3
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Material(
                      color: AppTheme.background,
                      child: ListTile(
                        leading: Icon(FontAwesomeIcons.user, color: AppTheme.dark_grey.withOpacity(0.8), size: 20.0),
                        trailing: Icon(FontAwesomeIcons.angleRight, color: AppTheme.dark_grey.withOpacity(0.6), size: 17.0),
                        title: Text(
                          'Mon profil',
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.darkerText,
                            letterSpacing: 0.3
                          ),
                        ),
                        subtitle: Column(
                          children: <Widget>[
                            SizedBox(height: 5.0),
                            Text(
                              'Modifier votre profil ou votre mot de passe et aussi la fermeture du compte.',
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
                        contentPadding: EdgeInsets.only(top: 15.0, bottom: 15.0, right: 20.0, left: 20.0),
                        dense: true,
                        onTap: () {
                          Get.to(() => ProfilDataScreen());
                        },
                      ),
                    ),
                    Divider(height: 0.0),
                    Material(
                      color: AppTheme.background,
                      child: ListTile(
                        leading: Icon(FontAwesomeIcons.clipboard, color: AppTheme.dark_grey.withOpacity(0.8), size: 20.0),
                        trailing: Icon(FontAwesomeIcons.angleRight, color: AppTheme.dark_grey.withOpacity(0.6), size: 17.0),
                        title: Text(
                          'Mes annonces',
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.darkerText,
                            letterSpacing: 0.3
                          ),
                        ),
                        subtitle: Column(
                          children: <Widget>[
                            SizedBox(height: 5.0),
                            Text(
                              'Vous trouverez tous vos annonces ici, les annonces actif comme les annonces inactif.',
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
                        contentPadding: EdgeInsets.only(top: 15.0, bottom: 15.0, right: 20.0, left: 20.0),
                        dense: true,
                        onTap: () {
                          menuController.goToAdvert();
                        },
                      ),
                    ),
                    Divider(height: 0.0),
                    Material(
                      color: AppTheme.background,
                      child: ListTile(
                        leading: Icon(FontAwesomeIcons.powerOff, color: AppTheme.dark_grey.withOpacity(0.7), size: 18.0),
                        title: Text(
                          'Déconnexion',
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.darkerText,
                            letterSpacing: 0.3
                          ),
                        ),
                        visualDensity: VisualDensity.comfortable,
                        contentPadding: EdgeInsets.only(top: 8.0, bottom: 8.0, right: 20.0, left: 20.0),
                        dense: true,
                        onTap: () async {
                          await authController.logout();

                          menuController.goToHome();
                        },
                      ),
                    ),
                    Divider(height: 0.0)
                  ],
                ),
              ),
            ),
          )
        ],
      );
  }
}
