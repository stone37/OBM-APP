import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:obm_market/constants/app_theme.dart';
import 'package:obm_market/modules/advert/models/entities/advert.dart';
import 'package:timeago/timeago.dart' as timeago;

class AdvertSimilarView extends StatelessWidget {
  const AdvertSimilarView(
      {Key? key,
        required this.advert,
        this.animationController,
        this.animation,
        this.callback}
      ) : super(key: key);

  final Advert advert;
  final VoidCallback? callback;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {

    timeago.setLocaleMessages('fr', timeago.FrMessages());

    var webPath = '';

    advert.images.map((image) {
      if (image['principale']) webPath = image['webPath'];
    }).toList();

    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(100 * (1.0 - animation!.value), 0.0, 0.0),
            child: Container(
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
                                      child: (advert.images.isEmpty) ?
                                      Image.asset('assets/images/no_photo.png', fit: BoxFit.cover) :
                                      CachedNetworkImage(
                                        imageUrl: 'https://oblackmarket.com/public/'+webPath,
                                        fit: BoxFit.cover
                                      ),
                                    )
                                  ),

                                  Positioned(
                                    bottom: 5,
                                    right: 6,
                                    child: Material(
                                      color: Colors.transparent,
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 24.0,
                                        padding: EdgeInsets.only(left: 1.0),
                                        constraints: BoxConstraints(
                                          maxWidth: 40.0
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppTheme.white,
                                          borderRadius: BorderRadius.circular(8.0),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                              color: AppTheme.grey.withOpacity(0.8),
                                              offset: const Offset(5, 5),
                                              blurRadius: 8.0
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            FaIcon(
                                              FontAwesomeIcons.cameraRetro,
                                              color: AppTheme.secondary,
                                              size: 14.0,
                                            ),
                                            SizedBox(width: 3.0),
                                            Text(
                                              '${advert.images.length}',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 0.3,
                                                color: AppTheme.secondary
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

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
                                                  (advert.location!['detail']) != null ?
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
                          (advert.traitement!.isNotEmpty) ?
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
            ),
          ),
        );
      }
    );
  }
}
