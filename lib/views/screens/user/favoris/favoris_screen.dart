import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:obm_market/constants/app_theme.dart';
import 'package:obm_market/modules/auth/controllers/auth_controller.dart';
import 'package:obm_market/modules/user/favorite/controllers/favorite_controller.dart';
import 'package:obm_market/modules/user/favorite/models/entities/favorite.dart';
import 'package:obm_market/views/common/not_authorisation.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../advert/index/advert_view_screen.dart';

class FavorisScreen extends StatelessWidget {

  final AuthController authController = Get.find();
  final FavoriteController controller = Get.find();

  Widget build(BuildContext context) {

    return (authController.connected == false) ?
      NotAuthorisation(
        image: Image.asset('assets/images/favoris.png'),
        title: 'Toutes vos annonces intéressantes regrouper ici.',
      ) : Container(
        color: AppTheme.background,
        padding: EdgeInsets.symmetric(vertical: 10.0),
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Expanded(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      FutureBuilder<List<Favorite>>(
                        future: controller.getFavorite(),
                        builder: (BuildContext context, AsyncSnapshot<List<Favorite>> snapshot) {
                          if (!snapshot.hasData) {
                            return Padding(
                              padding: EdgeInsets.only(top: 50.0),
                              child: Center(child: CircularProgressIndicator(color: AppTheme.primary)),
                            );
                          } else {
                            if (snapshot.data!.isEmpty) {
                              return Container(
                                  padding: EdgeInsets.only(right: 20, left: 20, top: MediaQuery.of(context).size.height*0.18),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(left: 65.0, right: 65.0, bottom: 20.0),
                                        child: Image.asset('assets/images/favoris.png')
                                      ),
                                      Container(
                                          padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                                          child: Text(
                                            'Aucune favoris pour le moment !',
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w600,
                                              color: AppTheme.darkerText
                                            ),
                                            textAlign: TextAlign.center,
                                          )
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(bottom: 20.0),
                                        child: Text(
                                          'Vous avez trouvé une annonce intéressante sur OBM ? \n Cliquez simplement sur "Favoris" lorsque vous consultez une annonce.',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: AppTheme.grey,
                                          ),
                                          textAlign: TextAlign.center,
                                        )
                                      ),
                                      SizedBox(height: 62.0)
                                    ],
                                  )
                              );
                            } else {
                              return _buildFavoriteView(controller, context, snapshot.data);
                            }
                          }
                        },
                      ),
                      SizedBox(height: 50.0)
                    ],
                  ),
                )
            )
          ],
        )
      );
  }

  Widget _buildFavoriteView(FavoriteController controller, BuildContext context, List<Favorite>? favorites) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: favorites!.length,
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(left: 13.0, right: 13.0, top: 10.0),
      itemBuilder: (BuildContext context, int index) {
        return FavoriteView(
          favorite: favorites[index],
          controller: controller,
          callback: () {
            Get.to(() => AdvertViewScreen(advert: favorites[index].advert!));
          }
        );
      }
    );
  }
}

class FavoriteView extends StatelessWidget {
  const FavoriteView({
    Key? key,
    required this.controller,
    required this.favorite,
    required this.callback
  }) : super(key: key);

  final FavoriteController controller;
  final Favorite favorite;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    final advert = favorite.advert!;
    timeago.setLocaleMessages('fr', timeago.FrMessages());

    return Obx(() => (!controller.userSaved.contains(favorite.advert!.id)) ?
      Container(
        margin: EdgeInsets.only(bottom: 15.0),
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
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: callback,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                                width: 145.0,
                                height: 130.0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0)),
                                  child: (favorite.advert!.images.isEmpty) ?
                                  Image.asset('assets/images/no_photo.png', fit: BoxFit.cover) :
                                  CachedNetworkImage(
                                    imageUrl: 'https://oblackmarket.com/public/'+ favorite.advert!.photoPrincipale(),
                                    fit: BoxFit.cover
                                  ),
                                )
                            ),
                            Positioned(
                              top: 5,
                              right: 6,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                                  onTap: () {
                                    controller.delete(favorite.advert!.id);

                                    controller.userSaved.add(favorite.advert!.id);
                                  },
                                  child: AnimatedContainer(
                                    height: 35.0,
                                    width: 35.0,
                                    duration: Duration(milliseconds: 300),
                                    decoration: BoxDecoration(
                                      color: AppTheme.white,
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                          color: AppTheme.grey.withOpacity(0.8),
                                          offset: const Offset(2, 2),
                                          blurRadius: 8.0
                                        ),
                                      ],
                                    ),
                                    padding: const EdgeInsets.only(top: 2.0),
                                    child: Center(
                                        child: Icon(Icons.favorite, color: AppTheme.danger_color,
                                        )
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(width: 8.0),
                        Container(
                          height: 130.0,
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                    children: <Widget>[
                                      SizedBox(height: 4.0),
                                      Container(
                                        width: 172.0,
                                        padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 4.0, bottom: 3.0),
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 2.0, color: AppTheme.defaults),
                                          borderRadius: BorderRadius.only(topRight: Radius.circular(30.0)),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              '${advert.price}',
                                              style: TextStyle(
                                                  color: AppTheme.defaults,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 0.3
                                              ),
                                            ),
                                            SizedBox(width: 3.0),
                                            Container(
                                              child: Text(
                                                'CFA',
                                                style: TextStyle(
                                                    color: AppTheme.defaults,
                                                    fontSize: 14.0,
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
                                          width: 172.0,
                                          child: Text(
                                            '${advert.title}',
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 0.3,
                                                overflow: TextOverflow.ellipsis
                                            ),
                                          )
                                      ),
                                      SizedBox(height: 9.0),
                                      Container(
                                        width: 172.0,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(bottom: 2.0, right: 3.0),
                                              child: FaIcon(FontAwesomeIcons.mapMarkerAlt, color: AppTheme.primary, size: 10.0),
                                            ),
                                            Text(
                                              ((advert.location!['detail']) != null && advert.location!['detail'].toString().isNotEmpty)  ?
                                              '${advert.location!['name']} (${advert.location!['detail']})':
                                              '${advert.location!['name']}',
                                              maxLines: 1,
                                              style: TextStyle(
                                                color: AppTheme.dark_grey,
                                                fontSize: 10.0,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 0.3,
                                                overflow: TextOverflow.ellipsis
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 5.0),
                                      Container(
                                        width: 172.0,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(bottom: 1.7, right: 3.0),
                                              child: FaIcon(FontAwesomeIcons.clock, color: AppTheme.primary, size: 10.0),
                                            ),
                                            Text(
                                              timeago.format(advert.validatedAt!, locale: 'fr'),
                                              style: TextStyle(
                                                  color: AppTheme.dark_grey,
                                                  fontSize: 10.0,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 0.3
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 8.0),
                                      Container(
                                        width: 172.0,
                                        child: Wrap(
                                          crossAxisAlignment: WrapCrossAlignment.start,
                                          children: <Widget>[
                                            (advert.marque!.isNotEmpty) ?
                                            Container(
                                              width: 172.0,
                                              child: Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: EdgeInsets.only(right: 3.0),
                                                    child: FaIcon(FontAwesomeIcons.solidCircle, color: Colors.indigo, size: 5.0),
                                                  ),
                                                  Text(
                                                    '${advert.marque}',
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        color: Colors.indigo,
                                                        fontSize: 11.0,
                                                        fontWeight: FontWeight.w600,
                                                        letterSpacing: 0.3,
                                                        overflow: TextOverflow.ellipsis
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ) : SizedBox(),

                                            (advert.model!.isNotEmpty) ?
                                            Container(
                                              width: 100.0,
                                              child: Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: EdgeInsets.only(right: 3.0),
                                                    child: FaIcon(FontAwesomeIcons.solidCircle, color: Colors.indigo, size: 5.0),
                                                  ),
                                                  Text(
                                                    '${advert.model}',
                                                    style: TextStyle(
                                                        color: Colors.indigo,
                                                        fontSize: 11.0,
                                                        fontWeight: FontWeight.w600,
                                                        letterSpacing: 0.3,
                                                        overflow: TextOverflow.visible
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ) : SizedBox(),

                                            (advert.autoYear!.isNotEmpty) ?
                                            Container(
                                              width: 45.0,
                                              child: Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: EdgeInsets.only(right: 3.0),
                                                    child: FaIcon(FontAwesomeIcons.solidCircle, color: Colors.indigo, size: 5.0),
                                                  ),
                                                  Text(
                                                    '${advert.autoYear}',
                                                    style: TextStyle(
                                                        color: Colors.indigo,
                                                        fontSize: 11.0,
                                                        fontWeight: FontWeight.w600,
                                                        letterSpacing: 0.3
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ) : SizedBox(),

                                            (advert.surface != null) ?
                                            Container(
                                              width: 70.0,
                                              child: Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: EdgeInsets.only(right: 3.0),
                                                    child: FaIcon(FontAwesomeIcons.solidCircle, color: Colors.indigo, size: 5.0),
                                                  ),
                                                  Text(
                                                    '${advert.surface}',
                                                    style: TextStyle(
                                                      color: Colors.indigo,
                                                      fontSize: 11.0,
                                                      fontWeight: FontWeight.w600,
                                                      letterSpacing: 0.3
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ) : SizedBox(),

                                            (advert.dateConstruction!.isNotEmpty) ?
                                            Container(
                                              width: 60.0,
                                              child: Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: EdgeInsets.only(right: 3.0),
                                                    child: FaIcon(FontAwesomeIcons.solidCircle, color: Colors.indigo, size: 5.0),
                                                  ),
                                                  Text(
                                                    '${advert.dateConstruction}',
                                                    style: TextStyle(
                                                        color: Colors.indigo,
                                                        fontSize: 11.0,
                                                        fontWeight: FontWeight.w600,
                                                        letterSpacing: 0.3
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ) : SizedBox(),

                                            (advert.brand!.isNotEmpty) ?
                                            Container(
                                              width: 80.0,
                                              child: Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: EdgeInsets.only(right: 3.0),
                                                    child: FaIcon(FontAwesomeIcons.solidCircle, color: Colors.indigo, size: 5.0),
                                                  ),
                                                  Text(
                                                    '${advert.brand}',
                                                    style: TextStyle(
                                                        color: Colors.indigo,
                                                        fontSize: 11.0,
                                                        fontWeight: FontWeight.w600,
                                                        letterSpacing: 0.3
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ) : SizedBox(),

                                            (advert.state!.isNotEmpty) ?
                                            Container(
                                              width: 60.0,
                                              child: Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: EdgeInsets.only(right: 3.0),
                                                    child: FaIcon(FontAwesomeIcons.solidCircle, color: Colors.indigo, size: 5.0),
                                                  ),
                                                  Text(
                                                    '${advert.state}',
                                                    style: TextStyle(
                                                        color: Colors.indigo,
                                                        fontSize: 11.0,
                                                        fontWeight: FontWeight.w600,
                                                        letterSpacing: 0.3
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ) : SizedBox(),

                                          ],
                                        ),
                                      )
                                    ]
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 6.0),
              Container(
                padding: EdgeInsets.only(bottom: 6.0, left: 12.0, right: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    (favorite.advert!.traitement != null) ?
                    Container(
                      padding: EdgeInsets.only(top: 3.0, bottom: 4.0, left: 8.0, right: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.blue.withOpacity(0.4)
                      ),
                      child: Text(
                        'Livraison possible',
                        style: TextStyle(
                          color: AppTheme.primary,
                          fontSize: 11.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3
                        )
                      ),
                    ) : SizedBox(),

                    Container(
                      padding: EdgeInsets.only(top: 3.0, bottom: 3.0, left: 8.0, right: 8.0),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.6, color: Colors.pink),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Particulier',
                        style: TextStyle(
                          color: Colors.pink,
                          fontSize: 11.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3
                        )
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ) : const SizedBox());
  }
}
