import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../views/widgets/message/successMessage.dart';
import '../../../auth/models/entities/user.dart';
import '../../../auth/repository/user_repository.dart';

class AccountDeleteController extends GetxController {

  TextEditingController passwordController = TextEditingController();
  RxBool isSecret = true.obs;
  final box = GetStorage();
  RxBool deleteAt = false.obs;
  User? user;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
  }

  delete() async {
    user = await UserRepository()
        .delete(token: box.read('token'), id: box.read('user_id'), password: passwordController.text.trim());

    if (user!.status == '200') {
      passwordController.text = '';
      await box.write('user_delete_at', user!.deleteAt);

      Get.back();

      showSuccessMessage(message: 'Votre demande de suppression de compte a bien été prise en compte.');
    }
  }

  cancel() async {
    user = await UserRepository()
        .deleteCancel(token: box.read('token'), id: box.read('user_id'), deleteAt: box.read('user_delete_at').toString());

    if (user!.status == '200') {
      await box.write('user_delete_at', null);

      Get.back();

      showSuccessMessage(message: 'La suppression de votre compte a bien été annulée.');
    }
  }

}

