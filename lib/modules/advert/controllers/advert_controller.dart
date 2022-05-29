import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdvertController extends GetxController with SingleGetTickerProviderMixin {
  late AnimationController animationController;

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
  }

  @override
  void onClose() {
    animationController.dispose();

    super.onClose();
  }



}

