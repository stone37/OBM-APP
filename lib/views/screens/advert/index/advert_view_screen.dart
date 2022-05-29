import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:obm_market/constants/app_theme.dart';
import 'package:obm_market/modules/advert/controllers/advert_similar_controller.dart';
import 'package:obm_market/modules/advert/controllers/advert_view_controller.dart';
import 'package:obm_market/modules/advert/models/entities/advert.dart';
import 'package:date_format/date_format.dart';
import 'package:obm_market/modules/auth/controllers/auth_controller.dart';
import 'package:obm_market/modules/user/favorite/controllers/favorite_controller.dart';
import 'package:obm_market/utils/dialog_data.dart';
import 'package:obm_market/views/screens/advert/index/advert_similar_view_screen.dart';
import 'package:obm_market/views/screens/report/report_screen.dart';
import 'package:obm_market/views/screens/security/login_screen.dart';
import 'package:obm_market/views/widgets/advert/advert_image_list.dart';
import 'package:obm_market/views/widgets/advert/advert_similar_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../modules/user/advert/controllers/user_advert_controller.dart';
import '../../../../modules/user/thread/controllers/thread_controller.dart';
import '../../user/thread/thread_reply_screen.dart';
import '../../user/thread/thread_send_screen.dart';
import '../profil/user_profil_screen.dart';

class AdvertViewScreen extends StatelessWidget {
  AdvertViewScreen({Key? key, required this.advert}) : super(key: key);

  final Advert advert;
  final AdvertViewController controller = Get.find();
  final AuthController authController = Get.find();
  final FavoriteController favoriteController = Get.find();
  final AdvertSimilarController similarController = Get.find();
  final UserAdvertController userAdvertController  = Get.find();

  @override
  Widget build(BuildContext context) {

    final userCheck = favoriteController.checkAdvert(id: advert.id);
    Map advertData = controller.getData(advert);

    return Obx(() => Container(
      color: AppTheme.background,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: (controller.isAppbar.value) ? AppTheme.primary : Colors.transparent,
              statusBarIconBrightness: (controller.isAppbar.value) ? Brightness.light : Brightness.dark,
              statusBarBrightness: (controller.isAppbar.value) ? Brightness.light : Brightness.dark,
            ),
            backgroundColor: (controller.isAppbar.value) ? AppTheme.primary : Colors.transparent,
            elevation: 0.0,
            leading: (controller.isAppbar.value) ? IconButton(
              splashRadius: 20.0,
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Get.back(),
            ) : Container(
              margin: EdgeInsets.only(left: 10.0, bottom: 5.0, top: 5.0),
              decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius:  BorderRadius.circular(30.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(color: AppTheme.grey.withOpacity(0.4), offset: const Offset(1.1, 1.1), blurRadius: 3.75),
                ],
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: AppTheme.primary),
                onPressed: () =>  Get.back(),
              ),
            ),
            title: (controller.isAppbar.value) ? Text(controller.title.value) : SizedBox(),
            actions: <Widget>[
              (controller.isAppbar.value) ?
                (authController.connected) ?
                    FutureBuilder<bool?>(
                      future: userCheck,
                      builder: (BuildContext context, AsyncSnapshot<bool?> snapshot) {
                        if (!snapshot.hasData) {
                          return SizedBox();
                        } else {
                          if (snapshot.data!) {
                            return SizedBox();
                          } else {
                            return FutureBuilder<bool>(
                                future: favoriteController.check(advert.id),
                                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                                  if (!snapshot.hasData) {
                                    return const SizedBox();
                                  } else {
                                    if (snapshot.data!) {
                                      WidgetsBinding.instance?.addPostFrameCallback((_) => favoriteController.saved.add(advert.id));
                                    }

                                    return Obx(
                                            () => Padding(
                                          padding: const EdgeInsets.only(right: 10.0),
                                          child: IconButton(
                                            onPressed: () {
                                              if (favoriteController.saved.contains(advert.id)) {
                                                favoriteController.delete(advert.id);

                                                favoriteController.saved.remove(advert.id);
                                              } else {
                                                favoriteController.add(advert.id);

                                                favoriteController.saved.add(advert.id);
                                              }
                                            },
                                            icon: (favoriteController.saved.contains(advert.id)) ?
                                            Icon(Icons.favorite, color: AppTheme.danger_color) :
                                            Icon(Icons.favorite_border, color: AppTheme.grey.withOpacity(0.8)),
                                            splashRadius: 20.0,
                                          ),
                                        )
                                    );
                                  }
                                }
                            );
                          }
                        }
                      }
                    ) : Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: IconButton(
                    onPressed: (){
                      DialogData().dialogImage(
                        title: 'Vous devez être connecter pour ajouter des annonces à vos favoris',
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
                    icon: Icon(Icons.favorite_border, size: 25.0),
                    splashRadius: 20.0,
                  ),
                ) :
                  (authController.connected) ?
                    FutureBuilder<bool?>(
                        future: userCheck,
                        builder: (BuildContext context, AsyncSnapshot<bool?> snapshot) {
                          if (!snapshot.hasData) {
                            return SizedBox();
                          } else {
                            if (snapshot.data!) {
                              return SizedBox();
                            } else {
                              return FutureBuilder<bool>(
                                  future: favoriteController.check(advert.id),
                                  builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                                    if (!snapshot.hasData) {
                                      return const SizedBox();
                                    } else {
                                      if (snapshot.data!) {
                                        WidgetsBinding.instance?.addPostFrameCallback((_) => favoriteController.saved.add(advert.id));
                                      }

                                      return Obx(() => Container(
                                            margin: EdgeInsets.only(right: 10.0, bottom: 5.0, top: 5.0),
                                            decoration: BoxDecoration(
                                              color: AppTheme.white,
                                              borderRadius:  BorderRadius.circular(30.0),
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(color: AppTheme.grey.withOpacity(0.4), offset: const Offset(1.1, 1.1), blurRadius: 3.75),
                                              ],
                                            ),
                                            child: IconButton(
                                              onPressed: () {
                                                if (favoriteController.saved.contains(advert.id)) {
                                                  favoriteController.delete(advert.id);

                                                  favoriteController.saved.remove(advert.id);
                                                } else {
                                                  favoriteController.add(advert.id);

                                                  favoriteController.saved.add(advert.id);
                                                }
                                              },
                                              icon: (favoriteController.saved.contains(advert.id)) ?
                                              Icon(Icons.favorite, color: AppTheme.danger_color) :
                                              Icon(Icons.favorite_border, color: AppTheme.grey.withOpacity(0.8)),
                                              splashRadius: 20.0,
                                            ),
                                          )
                                      );
                                    }
                                  });
                            }
                          }
                        }
                    ) :
                      Container(
                        margin: EdgeInsets.only(right: 10.0, bottom: 5.0, top: 5.0),
                        decoration: BoxDecoration(
                          color: AppTheme.white,
                          borderRadius:  BorderRadius.circular(30.0),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: AppTheme.grey.withOpacity(0.4),
                              offset: const Offset(1.1, 1.1),
                              blurRadius: 3.75
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.favorite_border,
                            color: AppTheme.grey.withOpacity(0.8),
                            size: 25.0,
                          ),
                          onPressed: () {
                            DialogData().dialogImage(
                              title: 'Vous devez être connecter pour ajouter des annonces à vos favoris',
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
                        ),
                      )
            ],
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  controller: controller.scrollController,
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Stack(
                    children: <Widget>[
                      InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          Get.to(
                            () => AdvertImageList(images: advert.images, controller: controller)
                          );
                        },
                        child: CarouselSlider.builder(
                          itemCount: advert.images.length,
                          options: CarouselOptions(
                            //autoPlay: (advert.images.isEmpty) ? false : true,
                            autoPlay: false,
                            aspectRatio: 1.2,
                            viewportFraction: 1,
                            onPageChanged: (index, reason) {
                              controller.current.value = index;
                            }
                          ),
                          itemBuilder: (BuildContext context, int index, int pageViewIndex) {
                            return (advert.images.isEmpty) ?
                            Image.asset('assets/images/no_photo_big.png', fit: BoxFit.cover) :
                            CachedNetworkImage(
                              imageUrl: 'https://oblackmarket.com/public/'+advert.images[index]['webPath'],
                              fit: BoxFit.cover
                            );
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 13.0),
                        margin: EdgeInsets.only(top: (MediaQuery.of(context).size.width / 1.2) - 20.0),
                        decoration: new BoxDecoration(
                          color: AppTheme.background,
                          borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(30.0),
                            topRight: const Radius.circular(30.0),
                          )
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0, bottom: 3.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.45,
                                    child: Text(
                                      advert.title,
                                      textAlign: TextAlign.left,
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0,
                                        letterSpacing: 0.3,
                                        color: AppTheme.darkText,
                                        overflow: TextOverflow.ellipsis
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          '${advert.price}',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0,
                                            color: AppTheme.defaults,
                                            overflow: TextOverflow.fade
                                          ),
                                        ),
                                        SizedBox(width: 1.0),
                                        Text(
                                          'CFA',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            color: AppTheme.defaults,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  (advert.validatedAt != null) ?
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 2.0, right: 4.0),
                                          child: FaIcon(FontAwesomeIcons.solidClock, color: AppTheme.primary, size: 12.0),
                                        ),
                                        Text(
                                          formatDate(advert.validatedAt!, [dd, '/', mm, '/', yyyy]),
                                          style: TextStyle(
                                            color: AppTheme.grey,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0.3
                                          ),
                                        ),
                                        SizedBox(width: 15.0),
                                      ],
                                    ) : SizedBox(),
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(right: 4.0, bottom: 4.0),
                                        child: FaIcon(FontAwesomeIcons.mapMarkerAlt, color: AppTheme.primary, size: 12.0),
                                      ),
                                      Text(
                                        ((advert.location!['detail']) != null && advert.location!['detail'].toString().isNotEmpty) ?
                                        '${advert.location!['name']} (${advert.location!['detail']})':
                                        '${advert.location!['name']}',
                                        style: TextStyle(
                                          color: AppTheme.grey,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.3
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),

                            (advertData.isNotEmpty) ?
                                ListView.builder(
                                  itemCount: advertData.length,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (BuildContext context, int index) {
                                    String key = advertData.keys.elementAt(index);

                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(top: 12.0, bottom: 12.0, left: 8.0),
                                              child: Text(
                                                key,
                                                style: TextStyle(
                                                  color: AppTheme.primary,
                                                  fontSize: 13.0,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 0.3
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0),
                                              child: Text(
                                                advertData[key],
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppTheme.dark_grey,
                                                  overflow: TextOverflow.fade,
                                                  letterSpacing: 0.3
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Container(
                                          height: 0.5,
                                          width: MediaQuery.of(context).size.width,
                                          color: AppTheme.grey.withOpacity(0.8),
                                        )
                                      ],
                                    );
                                  },
                                ) : SizedBox(),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0, top: 18.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Description',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.darkText,
                                      letterSpacing: 0.3
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    '${advert.description}',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w400,
                                      color: AppTheme.grey,
                                      letterSpacing: 0.3
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'Référence: ${advert.reference}'.toUpperCase(),
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w700,
                                          color: AppTheme.darkerText,
                                          letterSpacing: 0.3,
                                        ),
                                      ),
                                      SizedBox(width: 8.0),
                                      Text(
                                        'Dernière mise à jour: ${formatDate(advert.updatedAt!, [dd, '/', mm, '/', yyyy, ' à ', HH, ':', nn])}',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w700,
                                          color: AppTheme.darkerText,
                                          letterSpacing: 0.3
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 13.0),
                                  (authController.connected) ?
                                    FutureBuilder<bool?>(
                                      future: userCheck,
                                      builder: (BuildContext context, AsyncSnapshot<bool?> snapshot) {
                                        if (!snapshot.hasData) {
                                          return SizedBox();
                                        } else {
                                          if (snapshot.data!) {
                                            return SizedBox();
                                          } else {
                                            return _signalement();
                                          }
                                        }
                                      },
                                    ) : _signalement(),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      FaIcon(FontAwesomeIcons.userCircle, color: AppTheme.primary, size: 20.0),
                                      SizedBox(width: 10.0),
                                      Text(
                                        '${advert.user['username']}'.toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w500,
                                          color: AppTheme.dark_grey,
                                          letterSpacing: 0.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.0),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      FaIcon(FontAwesomeIcons.ad, color: AppTheme.primary, size: 20.0),
                                      SizedBox(width: 10.0),
                                      Text(
                                        'Annonceur particulier',
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w500,
                                          color: AppTheme.dark_grey,
                                          letterSpacing: 0.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.0),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      FaIcon(FontAwesomeIcons.calendarMinus, color: AppTheme.primary, size: 20.0),
                                      SizedBox(width: 10.0),
                                      Text(
                                        'Membre de "OBM" depuis le ${formatDate(DateTime.parse(advert.user['createdAt']), [dd, '/', mm, '/', yyyy])}',
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w500,
                                          color: AppTheme.dark_grey,
                                          letterSpacing: 0.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.0),
                                  (authController.connected) ?
                                    FutureBuilder<bool?>(
                                      future: userCheck,
                                      builder: (BuildContext context, AsyncSnapshot<bool?> snapshot) {
                                        if (!snapshot.hasData) {
                                          return SizedBox();
                                        } else {
                                          if (snapshot.data!) {
                                            return SizedBox();
                                          } else {
                                            return _advertiser(controller, userAdvertController);
                                          }
                                        }
                                      },
                                    ) : _advertiser(controller, userAdvertController),
                                ],
                              ),
                            ),
                            SizedBox(height: 30.0),

                            FutureBuilder<List<Advert>>(
                              future: similarController.getSimilar(advert.id),
                              builder: (BuildContext context,  AsyncSnapshot<List<Advert>> snapshot) {
                                if (!snapshot.hasData) {
                                  return const SizedBox();
                                } else {
                                  return (snapshot.data?.length != 0) ?
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          'Ces annonces peuvent vous intérèsser',// Afficher son unique annonce,
                                          style: TextStyle(
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.w600,
                                            color: AppTheme.darkerText,
                                            letterSpacing: 0.3,
                                          ),
                                        ),
                                        SizedBox(height: 20.0),
                                        Flexible(
                                          child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            itemCount: snapshot.data?.length,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemBuilder: (BuildContext context, int index) {
                                              final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0).animate(
                                                CurvedAnimation(
                                                  parent: controller.animationController,
                                                  curve: Interval((1 / snapshot.data!.length) * index, 1.0, curve: Curves.fastOutSlowIn)
                                                )
                                              );

                                              controller.animationController.forward();

                                              return AdvertSimilarView(
                                                  advert: snapshot.data![index],
                                                  animation: animation,
                                                  animationController: controller.animationController,
                                                  callback: () {
                                                    Get.to(() => AdvertSimilarViewScreen(advert: snapshot.data![index]));
                                                  }
                                              );
                                            },
                                          ),
                                        )
                                      ],
                                    ) : const SizedBox();
                                }
                              },
                            ),
                            SizedBox(height: 30)
                          ],
                        ),
                      ),
                      Positioned(
                        top: (MediaQuery.of(context).size.width / 1.2) - 24.0 - 35,
                        right: 35,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            focusColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                            splashColor: AppTheme.nearlyBlue.withOpacity(0.2),
                            onTap: () {
                              var baseUrl = 'https://oblackmarket.com/a/${advert.category['slug']}/${advert.subCategory['slug']}';
                              var url;

                              if (advert.subDivision == null) {
                                url = '$baseUrl/${advert.location!['name'].toString().toLowerCase()}/${advert.reference}/${advert.slug}';
                              } else {
                                url = '$baseUrl/${advert.subDivision!['slug']}/${advert.location!['name'].toString().toLowerCase()}/${advert.reference}/${advert.slug}';
                              }

                              Share.share('$url', subject: 'Voici ma dernière trouvaille sur O\'blackmarket: ${advert.title}');
                            },

                            child: ScaleTransition(
                              alignment: Alignment.center,
                              scale: CurvedAnimation(parent: controller.animationController, curve: Curves.fastOutSlowIn),
                              child: Card(
                                color: AppTheme.primary,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                                elevation: 10.0,
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  child: Center(
                                    child: Icon(
                                      Icons.share,
                                      color: AppTheme.white,
                                      size: 27.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ),
                      Positioned(
                        top: (MediaQuery.of(context).size.width / 1.2) - 24.0 - 38,
                        right: 160,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: advert.images.map((url) {
                            int index = advert.images.indexOf(url);

                            return (controller.current.value == index) ?
                            Container(
                              width: 18.0,
                              height: 18.0,
                              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 3.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppTheme.white,
                                border: Border.all(width: 2.0 , color: AppTheme.primary)
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(top: 3.0, left: 3.0),
                                child: FaIcon(FontAwesomeIcons.solidCircle, color: AppTheme.primary, size: 8.0),
                              )
                            ) :
                            Container(
                              width: 8.0,
                              height: 8.0,
                              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 3.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppTheme.primary,
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      SizedBox(height: MediaQuery.of(context).padding.bottom)
                    ],
                  ),
                ),
              ),
              (authController.connected) ?
                FutureBuilder<bool?>(
                  future: userCheck,
                  builder: (BuildContext context, AsyncSnapshot<bool?> snapshot) {
                    if (!snapshot.hasData) {
                      return SizedBox();
                    } else {
                      if (snapshot.data!) {
                        return SizedBox();
                      } else {
                        return _bottomBar(context, authController, userAdvertController, advert);
                      }
                    }
                  },
                ) : _bottomBar(context, authController, userAdvertController, advert)
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder _advertiser(AdvertViewController controller, UserAdvertController userAdvertController) {
    return FutureBuilder<List<Advert>>(
      future: userAdvertController.getAdvertEnabled(advert.user['id']),
      builder: (BuildContext context, AsyncSnapshot<List<Advert>> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return (snapshot.data?.length != 0) ? Container(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                    splashColor: AppTheme.secondary.withOpacity(0.2),
                    onTap: () => Get.to(() => UserProfilScreen(
                        adverts: snapshot.data,
                        user: advert.user,
                        animationController: controller.animationController)
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        FaIcon(FontAwesomeIcons.clipboardCheck, color: AppTheme.primary, size: 18.0),
                        SizedBox(width: 10.0),
                        Text(
                          (snapshot.data!.length == 1) ?
                          'Afficher son unique annonce' :
                          'Afficher ces ${snapshot.data!.length} annonces',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.secondary,
                            letterSpacing: 0.3,
                            decoration: TextDecoration.underline
                          ),
                        ),
                      ],
                    )
                ),
              )
          ) : SizedBox();
        }
      },
    );
  }

  Widget _signalement() {
    return Container(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(30.0)),
            splashColor: AppTheme.defaults.withOpacity(0.2),
            onTap: () {
              Get.to(() => ReportScreen(advert: advert));
            },
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius:  BorderRadius.circular(30.0),
                    border: Border.all(width: 1.0, color: AppTheme.grey.withOpacity(0.4))
                  ),
                  child: Icon(
                    Icons.flag,
                    color: AppTheme.defaults,
                    size: 18.0,
                  )
                ),
                SizedBox(width: 5.0),
                Text(
                  'Signalez cette annonce',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.defaults,
                    letterSpacing: 0.3,
                    decoration: TextDecoration.underline
                  ),
                ),
              ],
            )
          ),
        )
    );
  }


  Widget _bottomBar(
      BuildContext context,
      AuthController authController,
      UserAdvertController userAdvertController,
      Advert advert) {

      //final threadCheck = userAdvertController.checkThread(id: advert.id);
      final thread = userAdvertController.findThread(advertId: advert.id);
      final ThreadController threadController = Get.find();

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppTheme.background,
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
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)
                  ),
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
                      launchUrlString('tel:${advert.user['phone']}');
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 13.0, right: 15.0, top: 10.0, bottom: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                        border: Border.all(color: AppTheme.primary, width: 1.7),
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.phone, color: AppTheme.primary, size: 20.0),
                          SizedBox(width: 8.0),
                          Text(
                            'Appeler',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.3,
                              color: AppTheme.primary
                            ),
                          )
                        ],
                      )
                    ),
                  )
                ),
              ),
              SizedBox(width: 8.0),
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: AppTheme.grey.withOpacity(0.4),
                      offset: const Offset(1.1, 1.1),
                      blurRadius: 3.75
                    ),
                  ],
                ),
                child: Material(
                    color: AppTheme.primary,
                    borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                    child: InkWell(
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                      splashColor: AppTheme.grey.withOpacity(0.5),
                      onTap: () {
                        if (authController.connected) {
                          threadController.initMessage();

                          thread.then((value) {
                            if (value != null) {
                              Get.to(
                                () => ThreadReplyScreen(thread: value),
                                transition: Transition.cupertino,
                                duration: Duration(milliseconds: 300)
                              );
                            } else {
                              Get.to(
                                () => ThreadSendScreen(advert: advert),
                                transition: Transition.cupertino,
                                duration: Duration(milliseconds: 300)
                              );
                            }
                          });
                        } else {
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
                                  duration: Duration(milliseconds: 300)
                              );
                            }
                          );
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 10.0, bottom: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(30.0),),
                          border: Border.all(color: AppTheme.primary, width: 1.7),
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.mail, color: AppTheme.white, size: 20.0),
                            SizedBox(width: 5.0),
                            Text(
                              'Envoyer un message',
                              style: TextStyle(
                                fontSize: 16.0,
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
              )
            ],
          )
        ],
      ),
    );
  }
}




