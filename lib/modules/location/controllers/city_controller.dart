import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:obm_market/modules/location/models/entities/city.dart';
import 'package:obm_market/modules/location/repository/city_repository.dart';


class CityController extends GetxController with StateMixin<List<City>> {
  TextEditingController name = TextEditingController();
  List<City>? cities;

  @override
  void onInit() {
    super.onInit();

    getCities(name.text.trim());
  }

  @override
  void onClose() {
    super.onClose();
  }

  getCities(String? data) async {
    cities = await CityRepository().getCities(name: data);

    if (cities!.isNotEmpty) {
      change(cities, status: RxStatus.success());

    } else if(cities!.isEmpty) {
      change(null, status: RxStatus.error('Something went wrong'));

    } else {
      change(null, status: RxStatus.empty());
    }
  }
}

