import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:obm_market/modules/advert/models/entities/category.dart';
import 'package:obm_market/modules/advert/repository/category_repository.dart';


class CategoryController extends GetxController with StateMixin<List<Category>>, SingleGetTickerProviderMixin {
  List<Category>? categories;
  late AnimationController animationController;

  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    getCategories();
    animationController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  getCategories() async {
    categories = await CategoryRepository().getCategories();

    if (categories!.isNotEmpty) {
      change(categories, status: RxStatus.success());

    } else if(categories!.isEmpty) {
      change(null, status: RxStatus.error('Something went wrong'));

    } else {
      change(null, status: RxStatus.empty());
    }
  }

  Future<Category?> getCategory(int id) async {
    if (id == 0) return null;

    return await CategoryRepository().getCategory(id: id);
  }

  getLists() async {
    await box.write('app_categories', await CategoryRepository().getCategories());
  }
}

