import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:obm_market/modules/menu/controllers/menu_controller.dart';
import 'package:obm_market/modules/menu/models/tap_icon_data.dart';

class BottomBarController extends GetxController with SingleGetTickerProviderMixin {
  MenuController menuController = Get.find();

  late AnimationController animationController;
  late List<TabIconData> tabIconsList;

  @override
  void onInit() {
    super.onInit();

    tabIconsList = menuController.tabIconsList;

    animationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1000)
    );
    animationController.forward();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}

