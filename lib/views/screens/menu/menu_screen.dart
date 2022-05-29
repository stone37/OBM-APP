import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:obm_market/constants/app_theme.dart';
import 'package:obm_market/modules/auth/controllers/auth_controller.dart';
import 'package:obm_market/modules/menu/controllers/menu_controller.dart';
import 'package:obm_market/views/screens/home/home_screen.dart';
import 'package:obm_market/views/screens/user/advert/advert_screen.dart';
import 'package:obm_market/views/widgets/drawer/app_drawer.dart';
import '../../../modules/menu/models/tap_icon_data.dart';
import '../advert/create/category_screen.dart';
import '../advert/index/advert_list_category_screen.dart';
import '../user/thread/thread_screen.dart';
import 'bottom_bar_screen.dart';


class MenuScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final MenuController controller = Get.find();
    final AuthController authController = Get.find();

    return Obx(() => Scaffold(
        backgroundColor: AppTheme.background,
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppTheme.primary,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light,
          ),
          elevation: 3.0,
          automaticallyImplyLeading: true,
          backgroundColor: AppTheme.primary,
          iconTheme: IconThemeData(color: AppTheme.white),
          title: controller.title.value,
          actions: controller.actions,
          //leadingWidth: 40.0,
        ),
        drawer: AppDrawer(controller: controller, authController: authController),
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  controller.tabBody.value,
                  Column(
                    children: <Widget>[
                      const Expanded(
                        child: SizedBox(),
                      ),
                      (controller.bottomBarStatus.value) ?
                        BottomBarScreen(
                          addClick: () {
                            controller.changeTitle('Déposer une annonce');
                            controller.changeBottomBarStatus(true);

                            controller.animationController.reverse().then<dynamic>((data) {
                              controller.changeTabBody(CategoryScreen());
                            });

                            controller.tabIconsList.forEach((TabIconData tab) {
                              tab.isSelected = false;
                            });
                          },
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
                            } else if (index == 1) {
                              controller.changeTitle('Nos catégories');
                              controller.changeBottomBarStatus(true);

                              controller.animationController.reverse().then<dynamic>((data) {
                                controller.changeTabBody(AdvertListCategoryScreen());
                              });
                            } else if (index == 2) {
                              controller.changeTitle('Mes messages');
                              controller.changeBottomBarStatus(true);

                              controller.animationController.reverse().then<dynamic>((data) {
                                controller.changeTabBody(ThreadScreen());
                              });
                            } else if (index == 3) {
                              controller.changeTitle('Mes annonces');
                              controller.changeBottomBarStatus(true);

                              controller.animationController.reverse().then<dynamic>((data) {
                                controller.changeTabBody(AdvertScreen());
                              });
                            }
                          }
                        ) : SizedBox()
                    ],
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }
}











