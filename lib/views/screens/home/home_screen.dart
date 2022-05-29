import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:obm_market/modules/advert/controllers/category_controller.dart';
import 'package:obm_market/views/widgets/advert/category_menu.dart';
import 'package:obm_market/views/widgets/autoload/auto_load.dart';
import 'package:obm_market/views/widgets/advert/premium.dart';

import '../../../constants/app_theme.dart';


class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return GetBuilder<CategoryController>(

        builder: (controller) => AutoLoad(
          onInit: controller,
          child: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CategoryMenu(),
                        //HomeGalleryScreen(),
                        Flexible(child: Premium()),
                        SizedBox(height: 62.0)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ),
    );
  }
}

Widget headerBtn() {
  return Padding(
    padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 15.0),
    child: Column(
      children: <Widget>[
        Text(
          'Trouvez la bonne affaire parmi des milliers de petites annonces O\'blackmarket.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: AppTheme.dark_grey,
            letterSpacing: 0.3
          ),
        ),
        SizedBox(height: 5.0),
        Container(
          child: ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(AppTheme.primary),
              padding: MaterialStateProperty.all(EdgeInsets.only(left: 14.0, right: 6.0, top: 9.0, bottom: 9.0)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                )
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 1.0),
                  child: Text(
                    'Déposer une annonce',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 13.0,
                      letterSpacing: 0.3
                    )
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Icon(FontAwesomeIcons.signInAlt, size: 12.0),
                )
              ],
            ),
          ),
        )
      ],
    ),
  );
}


/*class HomeGalleryScreen extends StatelessWidget {
  const HomeGalleryScreen({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 8.0,
          color: AppTheme.grey.withOpacity(0.2),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  child: Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(right: 3.0),
                          child: Text(
                            'Gallerie d\'accueil',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.primary,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(bottom: 2.0),
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                child: Icon(
                                  FontAwesomeIcons.solidQuestionCircle,
                                  size: 16.0,
                                  color: AppTheme.grey.withOpacity(0.5),
                                ),
                              ),
                            )
                        )
                      ],
                    ),
                  )
              ),
              Container(
                child: TextButton(
                    style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 13.0),
                        primary: AppTheme.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: EdgeInsets.only(left: 3.0, right: 3.0, top: 2.0, bottom: 5.0)
                    ),
                    onPressed: () {},
                    child: Container(
                      padding: EdgeInsets.only(top: 5.0, left: 10.0),
                      child: Row(
                        children: [
                          const Text('Voir tout', style: TextStyle(fontWeight: FontWeight.w700)),
                          const Icon(Icons.chevron_right, size: 18,)
                        ],
                      ),
                    )
                ),
              ),
            ],
          ),
        ),
        AdvertGalleryView(
          callBack: () {},
        ),
        Container(
          margin: EdgeInsets.only(top: 18.0),
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          height: 36.0,
          child: ElevatedButton(
            onPressed: () => {},
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(AppTheme.defaults),
                padding: MaterialStateProperty.all(EdgeInsets.only(left: 14.0, right: 6.0, top: 9.0, bottom: 9.0)),
                shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    )
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                      'Mettre mon annonce ici',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 13.0,
                          letterSpacing: 0.3
                      )
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 8.0, bottom: 2.0),
                  child: Icon(FontAwesomeIcons.paperPlane, size: 12.0),
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 17.0),
        Container(
          height: 8.0,
          color: AppTheme.grey.withOpacity(0.2),
        )
      ],
    );
  }
}*/

/*class AdvertGalleryView extends HookWidget {
  AdvertGalleryView({Key? key, required this.callBack}) : super(key: key);

  final VoidCallback callBack;

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(duration: const Duration(milliseconds: 2000));

    return Padding(
      padding: EdgeInsets.only(top: 0.0),
      child: Container(
        width: double.infinity,
        child: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return CarouselSlider.builder(
                  options: CarouselOptions(
                      height: 160.0,
                      viewportFraction: 0.37,
                      autoPlay: true
                  ),
                  itemCount: Advert.advertList.length,
                  itemBuilder: (BuildContext context, int index, int pageViewIndex) {
                    final int count = Advert.advertList.length;

                    final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                            parent: animationController,
                            curve: Interval((1 / count) * index, 1.0, curve: Curves.fastOutSlowIn)
                        )
                    );
                    animationController.forward();


                    return AdvertView(
                      advert: Advert.advertList[index],
                      animation: animation,
                      animationController: animationController,
                      callback: callBack,
                    );
                  }

              );
            }
          },
        ),
      ),
    );
  }
}

class AdvertView extends StatelessWidget {
  const AdvertView({
    Key? key,
    this.advert,
    this.animationController,
    this.animation,
    this.callback
  }) : super(key: key);

  final VoidCallback? callback;
  final Advert? advert;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
            opacity: animation!,
            child: Transform(
                transform: Matrix4.translationValues(100 * (1.0 - animation!.value), 0.0, 0.0),
                child: InkWell(
                  onTap: () {},
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  splashColor: AppTheme.nearlyBlue.withOpacity(0.2),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: AppTheme.grey.withOpacity(0.2),
                              offset: const Offset(1.1, 1.1),
                              blurRadius: 3.75
                          ),
                        ],
                      ),
                      child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                          child: Column(
                            children: <Widget>[
                              AspectRatio(
                                aspectRatio: 1.6,
                                child: Image.asset(advert!.imageUrl, fit: BoxFit.cover),
                              ),
                              Container(
                                  color: AppTheme.white,
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.only(left: 6.0, right: 6.0, top: 5.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  advert!.title,
                                                  textAlign: TextAlign.left,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 14.0,
                                                      color: AppTheme.primary
                                                  ),
                                                ),
                                              ]
                                            ),
                                          ),
                                        ),
                                      ]
                                  )
                              ),
                              Container(
                                color: AppTheme.white,
                                padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0, bottom: 7.0),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Text(
                                        advert!.price.toStringAsFixed(0),
                                        overflow: TextOverflow.fade,
                                        softWrap: false,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: AppTheme.defaults,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 10,
                                      height: 9.8,
                                      child: Image.asset('images/devise.png'),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                      )
                  ),
                )
            )
        );
      },
    );
  }



}*/

/*Column(
              children: <Widget>[
                InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    Get.to(
                      AdvertImageListScreen(images: images)
                    );
                  },
                  child: CarouselSlider.builder(
                    itemCount: images.length,
                    options: CarouselOptions(
                      autoPlay: false,
                      aspectRatio: 1.2,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      }
                    ),
                    itemBuilder: (BuildContext context, int index, int pageViewIndex){
                      return images[index];
                    },
                  ),
                )
              ],
            ),
            Positioned(
              top: (MediaQuery.of(context).size.width / 1.2) - 24.0,
              bottom: 0,
              left: 0,
              right: 0,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.nearlyWhite,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: AppTheme.grey.withOpacity(0.2),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Container(
                        /*constraints: BoxConstraints(
                          minHeight: infoHeight,
                          maxHeight: tempHeight > infoHeight ? tempHeight : infoHeight),*/
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          /*mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,*/
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 32.0, left: 18, right: 16),
                              child: Text(
                                'Web Design Course',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22,
                                  letterSpacing: 0.27,
                                  color: AppTheme.darkerText,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    '\$28.99',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 22,
                                      letterSpacing: 0.27,
                                      color: AppTheme.nearlyBlue,
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          '4.3',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w200,
                                            fontSize: 22,
                                            letterSpacing: 0.27,
                                            color: AppTheme.grey,
                                          ),
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: AppTheme.nearlyBlue,
                                          size: 24,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Text(
                                  'There are three important parameters in carousel widget: items, carouselController, options. In items param, We need to pass an array of widgets which are displayed in slider. Using your own carousel controller, You can control slider page’s position manually. CarouselOptions widget is passed to options parameter. CarouselOptions widget is used to customize slider with use of different parameters like autoplay, height etc.There are three important parameters in carousel widget: items, carouselController, options. In items param, We need to pass an array of widgets which are displayed in slider. Using your own carousel controller, You can control slider page’s position manually. CarouselOptions widget is passed to options parameter. CarouselOptions widget is used to customize slider with use of different parameters like autoplay, height etc.There are three important parameters in carousel widget: items, carouselController, options. In items param, We need to pass an array of widgets which are displayed in slider. Using your own carousel controller, You can control slider page’s position manually. CarouselOptions widget is passed to options parameter. CarouselOptions widget is used to customize slider with use of different parameters like autoplay, height etc.There are three important parameters in carousel widget: items, carouselController, options. In items param, We need to pass an array of widgets which are displayed in slider. Using your own carousel controller, You can control slider page’s position manually. CarouselOptions widget is passed to options parameter. CarouselOptions widget is used to customize slider with use of different parameters like autoplay, height etc.'
                              ),
                            )


                            /*
                          SizedBox(
                            height: MediaQuery.of(context).padding.bottom,
                          )*/
                          ],
                        ),
                      ),
                    ),
                  ),

              )




            ),
            Positioned(
              top: MediaQuery.of(context).padding.top + 10,
              right: 20.0,
              child: ScaleTransition(
                alignment: Alignment.center,
                scale: CurvedAnimation(parent: animationController!, curve: Curves.fastOutSlowIn),
                child: InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                  onTap: () {},
                  child: Card(
                    color: AppTheme.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    elevation: 10.0,
                    child: Container(
                      width: AppBar().preferredSize.height - 12,
                      height: AppBar().preferredSize.height - 12,
                      child: Center(
                        child: Icon(
                          Icons.favorite_border,
                          color: AppTheme.grey.withOpacity(0.8),
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                )
              ),
            ),
            Positioned(
              top: (MediaQuery.of(context).size.width / 1.2) - 24.0 - 35,
              right: 35,
              child: ScaleTransition(
                alignment: Alignment.center,
                scale: CurvedAnimation(
                    parent: animationController!, curve: Curves.fastOutSlowIn),
                child: Card(
                  color: AppTheme.nearlyBlue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                  elevation: 10.0,
                  child: Container(
                    width: 55,
                    height: 55,
                    child: Center(
                      child: Icon(
                        Icons.favorite,
                        color: AppTheme.nearlyWhite,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: (MediaQuery.of(context).size.width / 1.2) - 24.0 - 38,
              right: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: images.map((url) {
                  int index = images.indexOf(url);
                  return (_current == index) ?
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
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10, left: 20.0),
              child: SizedBox(
                width: AppBar().preferredSize.height - 12,
                height: AppBar().preferredSize.height - 12,
                child: Material(
                  color: AppTheme.white,
                  borderRadius:  BorderRadius.circular(30.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(AppBar().preferredSize.height),
                    child: Icon(
                      Icons.arrow_back,
                      color: AppTheme.nearlyBlack,
                    ),
                    onTap: () {
                      Get.back();
                    },
                  ),
                ),
              ),
            )*/





