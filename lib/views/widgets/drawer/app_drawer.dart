import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:obm_market/constants/app_theme.dart';
import 'package:obm_market/modules/auth/controllers/auth_controller.dart';
import 'package:obm_market/modules/menu/controllers/menu_controller.dart';
import 'package:obm_market/views/screens/home/home_screen.dart';
import 'package:obm_market/views/screens/menu/drawer_item_screen.dart';
import 'package:obm_market/views/screens/security/login_screen.dart';
import 'package:obm_market/views/screens/user/advert/advert_screen.dart';
import 'package:obm_market/views/screens/user/favoris/favoris_screen.dart';
import 'package:obm_market/views/screens/user/profil/profil_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
    required this.controller,
    required this.authController}) : super(key: key);

  final MenuController controller;
  final AuthController authController;

  @override
  Widget build(BuildContext context) {

    final box = GetStorage();

    return Drawer(
      elevation: 20.0,
      backgroundColor: AppTheme.primary,
      child: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top-7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 25.0),
                    (!authController.connected) ? _header() : SizedBox(),
                    (!authController.connected) ? Padding(
                      padding: EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
                      child: Text(
                        'Nous voulons votre confort :)',
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.white,
                            letterSpacing: 0.5
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ) : SizedBox(),
                    (!authController.connected) ? SizedBox() :
                    Container(
                      padding: EdgeInsets.only(left: 20.0, right: 10.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 55.0,
                            height: 55.0,
                            child: (box.read('user_file') == null) ?
                            CircleAvatar(
                              radius: 50.0,
                              backgroundColor: AppTheme.defaults,
                              child: Container(
                                child: Text(
                                  '${box.read('user_firstname')[0]}',
                                  style: TextStyle(
                                    fontSize: 35.0,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.white
                                  ),
                                ),
                              ),
                            ) : CircleAvatar(
                              radius: 50.0,
                              backgroundImage: CachedNetworkImageProvider('https://oblackmarket.com/public/' + box.read('user_file')),
                            )
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.54,
                                  child: Text(
                                    '${box.read('user_firstname')}',
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.white,
                                      letterSpacing: 0.3,
                                      overflow: TextOverflow.ellipsis
                                    ),
                                  )
                                ),
                                SizedBox(height: 5.0),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.54,
                                  child: Text(
                                    '@${box.read('user_username')}',
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey.shade200,
                                      letterSpacing: 0.3
                                    ),
                                  )
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ),
                    SizedBox(height: 10.0),

                    DrawerItemScreen(
                      controller: controller,
                      changeIndex: (int index) {
                        if (index == 0) {
                          controller.title.value = Container(
                            width: 60.0,
                            height: 50.0,
                            child: Image.asset('assets/images/logo/logo_write.png'),
                          );

                          controller.changeBottomBarStatus(true);

                          controller.animationController.reverse().then<dynamic>((data) {
                            controller.changeTabBody(HomeScreen());
                          });

                          Navigator.pop(context);
                        } else if (index == 3) {
                          controller.changeTitle('Mes annonces');
                          controller.changeBottomBarStatus(true);

                          controller.animationController.reverse().then<dynamic>((data) {
                            controller.changeTabBody(AdvertScreen());
                          });

                          Navigator.pop(context);
                        } else if (index == 4) {
                          controller.changeTitle('Mes favoris');
                          controller.changeBottomBarStatus(false);

                          controller.animationController.reverse().then<dynamic>((data) {
                            controller.changeTabBody(FavorisScreen());
                          });

                          Navigator.pop(context);
                        } else if (index == 5) {
                          controller.changeTitle('Mon profil');
                          controller.changeBottomBarStatus(false);

                          controller.animationController.reverse().then<dynamic>((data) {
                            controller.changeTabBody(ProfilScreen());
                          });

                          Navigator.pop(context);
                        }
                      }
                    ),
                    Divider(color: AppTheme.white),
                    drawerItem(
                      icon: FontAwesomeIcons.userCheck,
                      text: 'Support',
                      onTap: () async {
                        final Uri url = Uri.parse('https://oblackmarket.com/contact');

                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        }
                      }
                    ),
                    drawerItem(
                      icon: FontAwesomeIcons.list,
                      text: 'Conditions d\'utilisations',
                      onTap: () async {
                        final Uri url = Uri.parse('https://oblackmarket.com/condition-d-utilisation');

                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        }
                      }
                    ),
                    drawerItem(
                      icon: FontAwesomeIcons.shieldAlt,
                      text: 'Politique de confidentialité',
                      onTap: () async {
                        final Uri url = Uri.parse('https://oblackmarket.com/politique-de-confidentialite');

                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        }
                      }
                    ),
                  ],
                ),
              )
            ),
          ),
          Container(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Divider(color: AppTheme.white),
                    GetBuilder<AuthController>(
                      builder: (controller) => controller.connected == false ?
                        drawerItem(
                          icon: FontAwesomeIcons.signInAlt,
                          text: 'Se connecter',
                          onTap: () {
                            Navigator.pop(context);
                            Get.to(() => LoginScreen(), transition: Transition.upToDown);
                          }
                        ) :
                        drawerItem(
                          icon: FontAwesomeIcons.powerOff,
                          text: 'Déconnexion',
                          onTap: () async {
                            Navigator.pop(context);
                            await authController.logout();
                          }
                        )
                    ),
                    Divider(color: AppTheme.primary.withOpacity(0.88)),
                  ]
                )
              )
            )
          )
        ],
      )
    );
  }

  Widget _header() {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      child: Row(
        children: [
          Container(
            width: 100.0,
            padding: EdgeInsets.only(right: 15.0),
            child: Image.asset('assets/images/logo/logo_write.png', fit: BoxFit.cover),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'O\'blackmarket',
                  style: TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.white
                  ),
                ),
                SizedBox(height: 5.0),
                RichText(
                  text: TextSpan(
                    text: 'Gratuit\t\t\t',
                    style: TextStyle(
                      color: AppTheme.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(
                        text: 'Rapide\t\t\t',
                        style: TextStyle(
                          color: AppTheme.secondary,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                        )
                      ),
                      TextSpan(
                        text: 'Sécurisé',
                        style: TextStyle(
                          color: AppTheme.defaults,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                        )
                      ),
                    ]
                  )
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget drawerItem({required IconData icon, required String text, required GestureTapCallback onTap}) {
    return Container(
      child: ListTile(
        title: Row(
          children: <Widget>[
            Icon(icon, size: 16.0, color: AppTheme.white),
            Padding(
              padding: EdgeInsets.only(left: 25.0),
              child: Text(
                text,
                style: TextStyle(
                  color: AppTheme.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                ),
              ),
            ),
          ],
        ),
        onTap: onTap,
      )
    );
  }


  Widget wallet(String sold) {
    return InkWell(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
        margin: EdgeInsets.only(left: 23.0, right: 33.0, bottom: 18.0),
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(50.0),
          border: Border.all(
              width: 1.5, style: BorderStyle.solid, color: AppTheme.defaults),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Icon(FontAwesomeIcons.wallet, size: 14.0, color: AppTheme.defaults),
            ),
            SizedBox(
              width: 4.0,
            ),
            Container(
              padding: EdgeInsets.only(top: 2.0),
              child: RichText(
                text: TextSpan(
                  text: sold,
                  style: TextStyle(
                    color: AppTheme.defaults,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: ' CFA',
                      style: TextStyle(
                        color: AppTheme.defaults,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      )
                    ),
                  ]
                )
              )
            ),
          ],
        ),
      ),
    );
  }
}
