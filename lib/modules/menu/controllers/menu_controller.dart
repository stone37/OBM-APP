import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:obm_market/modules/menu/models/tap_icon_data.dart';
import 'package:obm_market/views/screens/home/home_screen.dart';
import 'package:obm_market/views/screens/user/advert/advert_screen.dart';
import '../../../views/widgets/appbar/notification_icon.dart';
import '../../../views/widgets/appbar/search_icon.dart';

class MenuController extends GetxController with SingleGetTickerProviderMixin {
  late AnimationController animationController;
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  var tabBody = Rx<Widget>(Container());
  var title = Rx<Widget>(Container());
  var actions = <Widget>[].obs;
  var bottomBarStatus = RxBool(true);

  @override
  void onInit() {
    super.onInit();

    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });

    tabIconsList[0].isSelected = true;

    animationController = AnimationController(duration: const Duration(milliseconds: 600), vsync: this);
    tabBody.value = HomeScreen();

    title.value = Container(
      width: 60.0,
      height: 50.0,
      child: Image.asset('assets/images/logo/logo_write.png'),
    );

    actions.value = <Widget> [
      SearchIcon()
    ];

  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  void changeTabBody(Widget widget) => tabBody.value = widget;

  void changeTitle(String data) => title.value = Text(data, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, letterSpacing: 0.3));

  void changeAction(List<Widget> widget) => actions.value = widget;

  void changeBottomBarStatus(bool status) => bottomBarStatus.value = status;

  goToHome() {
    tabIconsList.forEach((TabIconData tab) {tab.isSelected = false;});
    tabIconsList[0].isSelected = true;
    tabBody.value = HomeScreen();

    title.value = Container(
      width: 60.0,
      height: 50.0,
      child: Image.asset('assets/images/logo/logo_write.png'),
    );
    actions.value = <Widget> [
      NotificationIcon(),
      SearchIcon()
    ];
  }

  goToAdvert() {
    tabIconsList.forEach((TabIconData tab) {tab.isSelected = false;});
    tabIconsList[3].isSelected = true;
    tabBody.value = AdvertScreen();

    changeTitle('Mes annonces');
    changeBottomBarStatus(true);

    actions.value = <Widget> [
      NotificationIcon(),
      SearchIcon()
    ];
  }
}

