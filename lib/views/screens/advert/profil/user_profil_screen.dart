import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:obm_market/constants/app_theme.dart';
import 'package:obm_market/modules/auth/controllers/auth_controller.dart';
import 'package:obm_market/views/screens/advert/search/search_screen.dart';
import 'package:obm_market/views/screens/security/login_screen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:date_format/date_format.dart';
import 'package:obm_market/utils/dialog_data.dart';
import '../../../../modules/advert/models/entities/advert.dart';
import '../../../widgets/advert/advert_view.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UserProfilScreen extends StatelessWidget {
  const UserProfilScreen({
    Key? key,
    required this.adverts,
    required this.user,
    required this.animationController
  }) : super(key: key);

  final List<Advert>? adverts;
  final Map<String, dynamic> user;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();

    return Container(
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppTheme.primary,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light,
          ),
          elevation: 0.0,
          backgroundColor: AppTheme.primary,
          iconTheme: IconThemeData(color: AppTheme.white),
          automaticallyImplyLeading: true,
          title: Text(
            'Annonces de ${user['username']}',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.3
            )
          ),
          actions: <Widget> [
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: IconButton(
                onPressed: (){
                  Get.to(() => SearchScreen(), transition: Transition.cupertino, duration: Duration(milliseconds: 500));
                },
                icon: Icon(FontAwesomeIcons.search, size: 20.0),
                splashRadius: 25.0,
              ),
            )
          ]
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        height: 250,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [AppTheme.primary, AppTheme.primary.withOpacity(0.8)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            stops: [0.5, 0.9],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    focusColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                                    splashColor: AppTheme.grey.withOpacity(0.5),
                                    onTap: () => launchUrlString('tel:${user['phone']}'),
                                    child: CircleAvatar(
                                      backgroundColor: AppTheme.defaults,
                                      minRadius: 32.0,
                                      child: Icon(Icons.call, size: 30.0, color: AppTheme.white)
                                    ),
                                  ),
                               ),
                                CircleAvatar(
                                  backgroundColor: Colors.white70,
                                  minRadius: 60.0,
                                  child: (user['fileUrl'] == null) ?
                                    CircleAvatar(
                                      radius: 50.0,
                                      backgroundColor: AppTheme.white,
                                      backgroundImage: ExactAssetImage('assets/images/icon_user.png')
                                    ) : CircleAvatar(
                                      radius: 50.0,
                                      backgroundImage: CachedNetworkImageProvider('https://oblackmarket.com/public/'+ user['fileUrl']),
                                    ),
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    focusColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                                    splashColor: AppTheme.grey.withOpacity(0.5),
                                    onTap: () {
                                      (authController.connected) ?
                                      DialogData().dialogImage(title: 'Message envoyer', btnTitle: '') :
                                      DialogData().dialogImage(
                                          title: 'Vous devez être connecter pour envoyer un message à l\'annonceur',
                                          btnTitle: 'Connectez-vous',
                                          image: Image.asset('assets/images/security.png', fit: BoxFit.cover),
                                          btnIcon: FontAwesomeIcons.arrowRight,
                                          callback: () {
                                            Navigator.pop(context);

                                            Get.to(
                                              () => LoginScreen(),
                                              transition: Transition.upToDown,
                                              duration: Duration(milliseconds: 500)
                                            );
                                          }
                                      );
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: AppTheme.defaults,
                                      minRadius: 32.0,
                                      child: Icon(Icons.mail, size: 30.0, color: AppTheme.white),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${user['username']}'.toUpperCase(),
                              style: TextStyle(
                                fontSize: 28.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 2.5),
                                      child: FaIcon(FontAwesomeIcons.mapMarkerAlt, color: AppTheme.white, size: 12.0)
                                    ),
                                    SizedBox(width: 3.0),
                                    Text(
                                      (user['city'] == null) ? 'Aucune' : user['city'],
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500,
                                        color: AppTheme.white,
                                        letterSpacing: 0.3,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 20.0),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 2.5),
                                      child: FaIcon(FontAwesomeIcons.calendarMinus, color: AppTheme.white, size: 12.0),
                                    ),
                                    SizedBox(width: 3.0),
                                    Text(
                                      'Membre depuis le ${formatDate(DateTime.parse(user['createdAt']), [dd, '/', mm, '/', yyyy])}',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500,
                                        color: AppTheme.white,
                                        letterSpacing: 0.3,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                           ),
                            SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 2.5),
                                      child: FaIcon(FontAwesomeIcons.calendarCheck, color: AppTheme.white, size: 12.0)
                                    ),
                                    SizedBox(width: 3.0),
                                    Text(
                                      'Dernière connexion: ${formatDate(DateTime.parse(user['lastLoginAt']), [dd, '/', mm, '/', yyyy, ' à ', HH, ':', nn])}',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500,
                                        color: AppTheme.white,
                                        letterSpacing: 0.3,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Flexible(
                        child: ListView.builder(
                          padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
                          shrinkWrap: true,
                          itemCount: adverts?.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0).animate(
                                CurvedAnimation(
                                    parent: animationController,
                                    curve: Interval((1 / adverts!.length) * index, 1.0, curve: Curves.fastOutSlowIn)
                                )
                            );

                            animationController.forward();

                            return Padding(
                              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                              child: AdvertView(
                                advert: adverts![index],
                                animation: animation,
                                animationController: animationController,
                              )
                            );
                          },
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).padding.bottom+10)
                    ],
                  ),
                ),
              )
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 17.0),
              decoration: BoxDecoration(
                color: AppTheme.primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: AppTheme.grey.withOpacity(0.4),
                    offset: const Offset(-1, -1),
                    blurRadius: 3.75,
                  ),
                ],
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: AppTheme.grey.withOpacity(0.4),
                      offset: const Offset(1.1, 1.1),
                      blurRadius: 3.75
                    ),
                  ],
                ),
                child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                      splashColor: AppTheme.grey.withOpacity(0.5),
                      onTap: () {
                        Share.share('https://oblackmarket.com/profil/${user['id']}', subject: 'Voici ma dernière trouvaille sur O\'blackmarket');
                      },
                      child: Container(
                          padding: EdgeInsets.only(left: 18.0, right: 20.0, top: 10.0, bottom: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                            border: Border.all(color: AppTheme.white, width: 1.6),
                            color: AppTheme.primary
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.share, color: AppTheme.white, size: 22.0),
                              SizedBox(width: 8.0),
                              Text(
                                'Partager ce profil',
                                style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.3,
                                  color: AppTheme.white
                                ),
                              )
                            ],
                          )
                      ),
                    )
                ),
              ),
            )
          ]
        ),
      )
    );
  }
}

