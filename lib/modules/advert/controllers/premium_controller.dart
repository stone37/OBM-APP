import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:obm_market/modules/advert/models/entities/categoryPremium.dart';
import 'package:obm_market/modules/advert/repository/category_premuim_repository.dart';

class PremiumController extends GetxController with StateMixin<List<CategoryPremium>>, SingleGetTickerProviderMixin {
  late AnimationController animationController;

  @override
  void onInit() {
    super.onInit();
    getPremiums();
    animationController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  getPremiums() async {
    final response = await CategoryPremiumRepository().getPremiums();

    if (response.isNotEmpty) {
      change(response, status: RxStatus.success());

    } else if(response.isEmpty) {
      change(null, status: RxStatus.error('Something went wrong'));

    } else {
      change(null, status: RxStatus.empty());
    }
  }
}

