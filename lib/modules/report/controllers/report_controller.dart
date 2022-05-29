import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:obm_market/modules/report/models/entities/report.dart';
import 'package:obm_market/modules/report/repository/report_repository.dart';

class ReportController extends GetxController {

  TextEditingController contentController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final box = GetStorage();
  ReportData? reportData;
  RxString reason = ''.obs;
  RxString reasonValidatorState = ''.obs;

  @override
  void onInit() {
    super.onInit();

    clear();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<bool> create({required int advertId}) async {
    reportData = await ReportRepository().create(
      email: emailController.text.trim(),
      reason: reason.value,
      content: contentController.text.trim(),
      advertId: advertId,
      token: box.read('token')
    );

    if (reportData!.status == '201') {
      return true;
    }

    return false;
  }

  void clear() {
    reason.value = '';
    contentController.text = '';
    emailController.text = '';
    reasonValidatorState.value = '';
  }
}
