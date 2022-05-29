import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:obm_market/modules/auth/models/entities/user.dart';

import '../../../../views/widgets/message/successMessage.dart';
import '../../../auth/repository/user_repository.dart';

class PasswordEditController extends GetxController {

  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordRepeatController = TextEditingController();
  RxBool isSecret = true.obs;
  RxBool isSecretRepeat = true.obs;
  User? user;

  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    passwordRepeatController.dispose();
  }

  passwordUpdate() async {
    user = await UserRepository().passwordChange(
        token: box.read('token'),
        id: box.read('user_id'),
        password: passwordController.text.trim());

    if (user!.status == '200') {
      passwordController.text = '';
      passwordRepeatController.text = '';

      Get.back();

      showSuccessMessage(message: 'Vos mot de passe a bien été modifier.');
    }
  }

}

