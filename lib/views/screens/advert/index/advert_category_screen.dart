import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:obm_market/constants/app_theme.dart';
import 'package:obm_market/modules/advert/controllers/advert_category_controller.dart';
import 'package:obm_market/modules/advert/models/entities/category.dart';
import 'package:obm_market/modules/auth/controllers/auth_controller.dart';
import 'package:obm_market/modules/user/alert/controllers/alert_controller.dart';
import 'package:obm_market/utils/dialog_data.dart';
import 'package:obm_market/views/common/btn_bulk.dart';
import 'package:obm_market/views/common/page_exception_indicator.dart';
import 'package:obm_market/views/screens/advert/filter/advert_category_filter_screen.dart';
import 'package:obm_market/views/screens/security/login_screen.dart';
import 'package:obm_market/views/widgets/advert/advert_view.dart';
import 'package:obm_market/views/widgets/advert/advert_view_title.dart';
import 'package:obm_market/views/widgets/advert/category_children_menu.dart';
import 'package:obm_market/views/widgets/loading/advert_list_shimmer.dart';
import 'dart:math' as math;

import '../../../widgets/appbar/notification_icon.dart';
import '../../../widgets/appbar/search_icon.dart';
import '../../menu/menu_screen.dart';

class AdvertCategoryScreen extends StatelessWidget {

  final AdvertCategoryController controller = Get.find();
  final AuthController authController = Get.find();
  final AlertController alertController = Get.find();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: AppTheme.background,
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppTheme.primary,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light,
          ),
          elevation: 3.0,
          backgroundColor: AppTheme.primary,
          iconTheme: IconThemeData(color: AppTheme.white),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            splashRadius: 20.0,
            onPressed: () {
              controller.initCategory();
              Get.off(() => MenuScreen());
            },
          ),
          title: Text(
            controller.category.value.name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.3
            )
          ),
          actions: <Widget> [
            NotificationIcon(),
            SearchIcon()
          ]
        ),
        body: Container(
          color: AppTheme.background,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Expanded(
                child: NestedScrollView(
                  controller: scrollController,
                  physics: AlwaysScrollableScrollPhysics(),
                  headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverList(
                        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              CategoryChildrenMenu(id: controller.category.value.id),
                              SizedBox(height: 3.0),
                            ],
                          );
                        }, childCount: 1),
                      ),
                      SliverPersistentHeader(
                        pinned: true,
                        floating: true,
                        delegate: ContestTabHeader(_filterBar(controller.category.value, context))
                      ),
                    ];
                  },
                  body: Column(
                    children: <Widget>[
                      Expanded(
                        child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(height: 10.0),
                                /*AdvertViewTitle(id: int.parse(id), city: controller.filter['city']),*/
                                Obx(() => AdvertViewTitle(id: controller.category.value.id, city: controller.city.value)),
                                SizedBox(height: 5.0),
                                Obx(() => Padding(
                                  padding: EdgeInsets.only(left: 15.0, right: 13.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        '${controller.totalItem} Resultats',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600,
                                          color: AppTheme.darkerText,
                                          letterSpacing: 0.3
                                        ),
                                      ),
                                      SizedBox(width: 10.0),
                                      Text(
                                        '(page ${controller.page.value} sur ${controller.lastPage.value})',
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w500,
                                          color: AppTheme.grey,
                                          letterSpacing: 0.3
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                                SizedBox(height: 10.0),
                                Flexible(
                                  child: controller.obx(
                                    (advertState) => ListView.builder(
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.only(top: 0.0, bottom: 0.0, right: 13.0, left: 13.0),
                                      itemCount: advertState?.length,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (BuildContext context, int index) {
                                        final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0).animate(
                                          CurvedAnimation(
                                            parent: controller.animationController,
                                            curve: Interval((1 / advertState!.length) * index, 1.0, curve: Curves.fastOutSlowIn)
                                          )
                                        );

                                        controller.animationController.forward();

                                        final advert = advertState[index];

                                        return AdvertView(
                                          advert: advert,
                                          animation: animation,
                                          animationController: controller.animationController
                                        );
                                      },
                                    ),
                                    onLoading: AdvertListShimmer(),
                                    onEmpty: PageExceptionIndicator(
                                      title: 'Aucun élément trouvé',
                                      message: 'La liste est actuellement vide',
                                    ),
                                    onError: (error) => PageExceptionIndicator(
                                      title: '$error',
                                      message: 'La liste est actuellement vide',
                                    ),
                                  )
                                ),
                                Obx(() {
                                  return Container(
                                    padding: EdgeInsets.only(left: 13.0, right: 13.0),
                                    margin: EdgeInsets.only(bottom: 20.0, top: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width*0.45,
                                          child: PageButton(
                                            text: 'Précédent',
                                            textColor: (controller.page.value == controller.firstPage.value) ? AppTheme.dark_grey.withOpacity(0.6) : AppTheme.darkerText,
                                            backgroundColor: (controller.page.value == controller.firstPage.value) ? AppTheme.grey.withOpacity(0.4) : AppTheme.white,
                                            borderColor: AppTheme.background,
                                            icon: FontAwesomeIcons.arrowLeft,
                                            iconPosition: 'left',
                                            overlay: (controller.page.value == controller.firstPage.value) ? false : true,
                                            elevation: (controller.page.value == controller.firstPage.value) ? 0.0 : 2.0,
                                            callback: (controller.page.value == controller.firstPage.value) ?
                                            null : () {
                                              scrollController.animateTo(
                                                scrollController.position.minScrollExtent,
                                                curve: Curves.easeOut,
                                                duration: const Duration(milliseconds: 500),
                                              );

                                              controller.page.value--;
                                              controller.filter.addAll({'page': controller.page.value});
                                            },
                                          ),
                                        ),

                                        Container(
                                          width: MediaQuery.of(context).size.width*0.45,
                                          child: PageButton(
                                            text: 'Suivant',
                                            textColor: (controller.page.value == controller.lastPage.value) ? AppTheme.dark_grey.withOpacity(0.6) : AppTheme.darkerText,
                                            backgroundColor: (controller.page.value == controller.lastPage.value) ? AppTheme.grey.withOpacity(0.4) : AppTheme.white,
                                            borderColor: AppTheme.background,
                                            icon: FontAwesomeIcons.arrowRight,
                                            iconPosition: 'right',
                                            overlay: (controller.page.value == controller.lastPage.value) ? false : true,
                                            elevation: (controller.page.value == controller.lastPage.value) ? 0.0 : 2.0,
                                            callback: (controller.page.value == controller.lastPage.value) ? null : () {
                                              scrollController.animateTo(
                                                scrollController.position.minScrollExtent,
                                                curve: Curves.easeOut,
                                                duration: const Duration(milliseconds: 500),
                                              );

                                              controller.page.value++;
                                              controller.filter.addAll({'page': controller.page.value});
                                            },
                                          ),
                                        ),

                                      ],
                                    ),
                                  );
                                }),
                                SizedBox(height: MediaQuery.of(context).padding.bottom)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ),
              )
            ],
          ),
        ),
      );
  }

  Widget _filterBar(Category category, BuildContext context) {
    final box = GetStorage();

    return Container(
      color: AppTheme.white,
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        borderRadius: const BorderRadius.all(Radius.circular(0.0)),
                        splashColor: controller.positionOrderState.value ? AppTheme.secondary.withOpacity(0.2) : AppTheme.nearlyBlue.withOpacity(0.2),
                        onTap: () {
                          controller.filter.addAll({'positionOrder': 'desc'});

                          controller.changePositionOrderState(true);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 4),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Row(
                                  children: <Widget>[
                                    FaIcon(
                                      FontAwesomeIcons.clock,
                                      color: controller.positionOrderState.value ? AppTheme.secondary : AppTheme.primary,
                                      size: 16.0
                                    ),
                                    SizedBox(width: 2.0,),
                                    FaIcon(
                                      FontAwesomeIcons.arrowDown,
                                      color: controller.positionOrderState.value ? AppTheme.secondary : AppTheme.primary,
                                      size: 13.0
                                    ),
                                  ],
                                )
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                'Date',
                                style: TextStyle(
                                  color: controller.positionOrderState.value ? AppTheme.secondary : AppTheme.primary,
                                  fontWeight: controller.positionOrderState.value ? FontWeight.bold : FontWeight.w600,
                                  fontSize: 12.5,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        borderRadius: const BorderRadius.all(Radius.circular(0.0)),
                        splashColor: controller.positionOrderState.value ? AppTheme.nearlyBlue.withOpacity(0.2) : AppTheme.secondary.withOpacity(0.2),
                        onTap: () {
                          controller.filter.addAll({'positionOrder': 'asc'});

                          controller.changePositionOrderState(false);

                          //print(controller.filter);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 4),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Row(
                                  children: <Widget>[
                                    FaIcon(
                                      FontAwesomeIcons.clock,
                                      color: controller.positionOrderState.value ? AppTheme.primary : AppTheme.secondary,
                                      size: 16.0
                                    ),
                                    SizedBox(width: 2.0),
                                    FaIcon(
                                      FontAwesomeIcons.arrowUp,
                                      color: controller.positionOrderState.value ? AppTheme.primary : AppTheme.secondary,
                                      size: 13.0
                                    )
                                  ],
                                )
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                'Date',
                                style: TextStyle(
                                  color: controller.positionOrderState.value ? AppTheme.primary : AppTheme.secondary,
                                  fontWeight: controller.positionOrderState.value ? FontWeight.w600 : FontWeight.bold,
                                  fontSize: 12.5,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        borderRadius: const BorderRadius.all(Radius.circular(0.0)),
                        splashColor: controller.priceOrderDescState.value ? AppTheme.secondary.withOpacity(0.2) : AppTheme.nearlyBlue.withOpacity(0.2),
                        onTap: () {

                          controller.filter.addAll({'priceOrder': 'desc'});

                          controller.changePriceOrderDescState(true);
                          controller.changePriceOrderAscState(false);
                        },
                        onLongPress: () {
                          if (controller.priceOrderDescState.value) {
                            controller.filter.addAll({'priceOrder': ''});
                          }
                          controller.changePriceOrderDescState(false);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 4),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Row(
                                  children: <Widget>[
                                    FaIcon(
                                      FontAwesomeIcons.dollarSign,
                                      color: controller.priceOrderDescState.value ? AppTheme.secondary : AppTheme.primary,
                                      size: 16.0
                                    ),
                                    SizedBox(width: 2.0),
                                    FaIcon(
                                      FontAwesomeIcons.arrowDown,
                                      color: controller.priceOrderDescState.value ? AppTheme.secondary : AppTheme.primary,
                                      size: 13.0,
                                    ),
                                  ],
                                )
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                'Prix',
                                style: TextStyle(
                                  color: controller.priceOrderDescState.value ? AppTheme.secondary : AppTheme.primary,
                                  fontWeight: controller.priceOrderDescState.value ? FontWeight.bold : FontWeight.w600,
                                  fontSize: 12.5,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        borderRadius: const BorderRadius.all(Radius.circular(0.0)),
                        splashColor: controller.priceOrderAscState.value ? AppTheme.secondary.withOpacity(0.2) : AppTheme.nearlyBlue.withOpacity(0.2),
                        onTap: () {
                          controller.filter.addAll({'priceOrder': 'asc'});

                          controller.changePriceOrderAscState(true);
                          controller.changePriceOrderDescState(false);
                        },
                        onLongPress: () {
                          if (controller.priceOrderAscState.value) {
                            controller.filter.addAll({'priceOrder': ''});
                          }

                          controller.changePriceOrderAscState(false);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 4),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Row(
                                  children: <Widget>[
                                    FaIcon(
                                      FontAwesomeIcons.dollarSign,
                                      color: controller.priceOrderAscState.value ? AppTheme.secondary : AppTheme.primary,
                                      size: 16.0
                                    ),
                                    SizedBox(width: 2.0,),
                                    FaIcon(
                                      FontAwesomeIcons.arrowUp,
                                      color: controller.priceOrderAscState.value ? AppTheme.secondary : AppTheme.primary,
                                      size: 13.0
                                    )
                                  ],
                                )
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                'Prix',
                                style: TextStyle(
                                  color: controller.priceOrderAscState.value ? AppTheme.secondary : AppTheme.primary,
                                  fontWeight: controller.priceOrderAscState.value ? FontWeight.w600 : FontWeight.bold,
                                  fontSize: 12.5,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Container(
                      width: 2.5,
                      height: 42.0,
                      color: AppTheme.primary,
                    )
                  ],
                ))
              ),
              (box.read('app_alerte_state') == true) ?
              Material(
                color: Colors.transparent,
                child: InkWell(
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  borderRadius: const BorderRadius.all(Radius.circular(3.0)),
                  splashColor: AppTheme.danger_color.withOpacity(0.2),
                  onTap: () async {
                    if (authController.connected) {
                      await alertController.add(category.id);
                    } else {
                      DialogData().dialogImage(
                        title: 'Vous devez être connecter pour créer des alertes',
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
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 7.0, bottom: 7.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: FaIcon(Icons.notifications, color: AppTheme.danger_color, size: 28.0),
                        ),
                        Text(
                          'M\'alerter',
                          style: TextStyle(
                            color: AppTheme.danger_color,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.0,
                            letterSpacing: 0.3,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ) : SizedBox(),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  borderRadius: const BorderRadius.all(Radius.circular(3.0)),
                  splashColor: AppTheme.grey.withOpacity(0.2),
                  onTap: () {
                    Get.to(
                      () => AdvertCategoryFilterScreen(),
                      /*arguments: data,*/
                      transition: Transition.cupertino,
                      duration: Duration(milliseconds: 300)
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 7.0, bottom: 7.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Transform.rotate(
                              angle: 90 * math.pi / 180,
                              child: FaIcon(Icons.tune, color: AppTheme.grey, size: 28.0)
                          ),
                        ),
                        Text(
                          'Filter',
                          style: TextStyle(
                            color: AppTheme.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.5,
                            letterSpacing: 0.3,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  ContestTabHeader(this.searchUI);

  final Widget searchUI;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return searchUI;
  }

  @override
  double get maxExtent => 58.0;

  @override
  double get minExtent => 58.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
