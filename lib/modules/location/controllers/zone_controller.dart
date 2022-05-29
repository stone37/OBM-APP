import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:obm_market/modules/location/models/entities/zone.dart';
import 'package:obm_market/modules/location/repository/zone_repository.dart';

class ZoneController extends GetxController {
  TextEditingController name = TextEditingController();
  List<Zone>? zones;

  @override
  void onInit() {
    super.onInit();
  }

  Future<List<Zone>?> getZones(String data) async {
    zones = await ZoneRepository().getZones(name: data);

    return zones;
  }
}

