import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:obm_market/modules/advert/models/entities/advert.dart';
import 'package:obm_market/modules/user/advert/controllers/user_advert_controller.dart';
import 'package:obm_market/views/common/btn_bulk.dart';
import '../../../constants/app_theme.dart';
import '../../../modules/advert/controllers/advert_create_controller.dart';
import '../../screens/advert/index/advert_view_screen.dart';
import '../../screens/user/advert/advert_edit_screen.dart';


class UserAdvertView extends StatelessWidget {
  const UserAdvertView({
    Key? key,
    required this.advert,
    required this.controller,
    this.state = false
  }) : super(key: key);

  final Advert advert;
  final UserAdvertController controller;
  final bool state;

  @override
  Widget build(BuildContext context) {

    final AdvertCreateController advertCreateController = Get.put<AdvertCreateController>(AdvertCreateController());

    return Obx(() => (controller.advertId.contains(advert.id)) ? Container(
      margin: EdgeInsets.only(bottom: 25.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppTheme.background,
        boxShadow: [
          BoxShadow(
            color: AppTheme.grey.withOpacity(0.4),
            offset: const Offset(5, 5),
            blurRadius: 8.0
          ),
        ]
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    width: 118.0,
                    height: 110.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(28.5)),
                      child: (advert.images.isEmpty) ?
                      Image.asset('assets/images/no_photo.png', fit: BoxFit.cover) :
                      CachedNetworkImage(
                        imageUrl: 'https://oblackmarket.com/public/' + advert.photoPrincipale(),
                        fit: BoxFit.cover
                      ),
                    )
                  ),
                  SizedBox(height: 10.0)
                ],
              ),
              SizedBox(width: 8.0),
              Container(
                height: 120.0,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 4.0),
                          Container(
                            width: 200.0,
                            padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 2.0, bottom: 1.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1.3, color: AppTheme.danger_color),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30.0)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '${advert.price}',
                                  style: TextStyle(
                                    color: AppTheme.danger_color,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.3
                                  ),
                                ),
                                SizedBox(width: 3.0),
                                Container(
                                  child: Text(
                                    'CFA',
                                    style: TextStyle(
                                      color: AppTheme.danger_color,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.3
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Container(
                              width: 200.0,
                              child: Text(
                                '${advert.title}',
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.3,
                                  overflow: TextOverflow.ellipsis
                                ),
                              )
                          ),
                          SizedBox(height: 5.0),
                          Container(
                            width: 200.0,
                            child: RichText(
                              maxLines: 2,
                              text: TextSpan(
                                  text: '${advert.category['name']} - ${advert.subCategory['name']}',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.3,
                                    color: AppTheme.defaults,
                                    overflow: TextOverflow.ellipsis
                                  ),
                                  children: <TextSpan>[
                                    if (advert.subDivision != null)
                                      TextSpan(text: ' - ${advert.subDivision!['name']}')
                                  ]
                              ),
                            )
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            children: <Widget>[
                              PageButtonSm(
                                  text: 'Stats',
                                  textColor: AppTheme.white,
                                  backgroundColor: AppTheme.grey,
                                  borderColor: AppTheme.grey,
                                  icon: FontAwesomeIcons.chartBar,
                                  iconPosition: 'right',
                                  callback: () {
                                    Get.defaultDialog(
                                        title: '',
                                        titlePadding: EdgeInsets.all(0.0),
                                        contentPadding: EdgeInsets.all(0.0),
                                        radius: 0.0,
                                        content: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                              child: Text(
                                                'Statistiques de l\'annonce',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 17.0,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0.3,
                                                  color: AppTheme.darkerText,
                                                ),
                                              )
                                            ),
                                            SizedBox(height: 16.0),
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                              child: Column(
                                                children: <Widget>[
                                                  /*StatsData(title: 'Nombre de vue', quantity: '10', icon: FontAwesomeIcons.eye),
                                                  SizedBox(height: 15.0),
                                                  StatsData(title: 'Nombre de favoris', quantity: '10', icon: FontAwesomeIcons.heart),
                                                  SizedBox(height: 15.0),*/
                                                  StatsData(title: 'Nombre de message', quantity: '${advert.messageCount}', icon: FontAwesomeIcons.envelope),
                                                  SizedBox(height: 15.0),
                                                  StatsData(title: 'Nombre de photos', quantity: '${advert.images.length}', icon: FontAwesomeIcons.cameraRetro),
                                                  SizedBox(height: 6.0),
                                                ],
                                              )
                                            ),


                                          ],
                                        )
                                    );
                                  }
                              ),
                              /*SizedBox(width: 15.0),
                              PageButtonSm(
                                text: 'Options',
                                textColor: AppTheme.white,
                                backgroundColor: AppTheme.indigo,
                                borderColor: Colors.indigo,
                                icon: FontAwesomeIcons.gem,
                                iconPosition: 'right',
                                callback: () {}
                              ),*/
                            ],
                          )

                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Container(
              padding: (advert.subDivision != null) ? EdgeInsets.only(
                  bottom: 6.0, left: 12.0, right: 12.0, top: 10.0) :
              EdgeInsets.only(bottom: 6.0, left: 12.0, right: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  PageButtonSm(
                    text: 'Voir',
                    textColor: AppTheme.primary,
                    backgroundColor: AppTheme.white,
                    borderColor: AppTheme.primary,
                    icon: FontAwesomeIcons.eye,
                    iconPosition: 'left',
                    callback: () {
                      Get.to(() => AdvertViewScreen(advert: advert));
                    }
                  ),
                  SizedBox(width: 3.0),
                  if (state)
                    PageButtonSm(
                      text: 'Modifier',
                      textColor: AppTheme.secondary,
                      backgroundColor: AppTheme.white,
                      borderColor: AppTheme.secondary,
                      icon: FontAwesomeIcons.pencilAlt,
                      iconPosition: 'left',
                      callback: () {
                        advertCreateController.hydrate(advert: advert);
                        advertCreateController.getImagesId(advert: advert);

                        Get.to(
                          () => AdvertEditScreen(advert: advert),
                          transition: Transition.upToDown,
                          duration: Duration(milliseconds: 500)
                        );
                      }
                    ),
                  SizedBox(width: 3.0),
                  PageButtonSm(
                    text: 'Supprimer',
                    textColor: AppTheme.white,
                    backgroundColor: AppTheme.danger_color,
                    borderColor: AppTheme.danger_color,
                    icon: FontAwesomeIcons.trash,
                    iconPosition: 'left',
                    callback: () {
                      Get.defaultDialog(
                        title: '',
                        titlePadding: EdgeInsets.all(0.0),
                        contentPadding: EdgeInsets.all(0.0),
                        backgroundColor: AppTheme.danger_color,
                        radius: 0.0,
                        content: Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text(
                                'Être vous sur de vouloir supprimer cette annonce ?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.3,
                                  color: AppTheme.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 18.0),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Icon(FontAwesomeIcons.times, size: 55.0, color: AppTheme.white),
                            ),
                            SizedBox(height: 18.0),
                            Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      height: 40.0,
                                      child: PageButton(
                                        text: 'Oui',
                                        textColor: AppTheme.white,
                                        backgroundColor: AppTheme.danger_color,
                                        borderColor: AppTheme.white,
                                        callback: () async {
                                          Navigator.pop(context, false);

                                          await controller.delete(advert.id);
                                        }
                                      ),
                                    ),
                                    SizedBox(width: 30.0),
                                    Container(
                                      height: 40.0,
                                      child: PageButton(
                                        text: 'Non',
                                        textColor: AppTheme.danger_color,
                                        backgroundColor: AppTheme.white,
                                        borderColor: AppTheme.white,
                                        callback: () => Navigator.pop(context, false),
                                      ),
                                    ),
                                  ],
                                )
                            )
                          ],
                        )
                      );
                    }
                  )
                ],
              )
          )
        ],
      ),
    ) : SizedBox());
  }
}


class StatsData extends StatelessWidget {
  const StatsData({
    Key? key,
    required this.icon,
    required this.title,
    required this.quantity
  }) : super(key: key);

  final IconData icon;
  final String title;
  final String quantity;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 2.0),
                child: Icon(icon, size: 15.0, color: AppTheme.dark_grey)
              ),
              SizedBox(width: 8.0),
              Text(
                title,
                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.dark_grey
                ),
              ),
            ],
          )
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
          decoration: BoxDecoration(
            color: AppTheme.primary,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: AppTheme.grey.withOpacity(0.4),
                offset: const Offset(5, 5),
                blurRadius: 8.0
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(20.0))
          ),
          child: Text(
            quantity,
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w500,
              color: AppTheme.white
            ),
          ),
        )
      ],
    );
  }
}



