import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:obm_market/modules/auth/repository/user_auth_repository.dart';

import '../../../views/screens/password/reset_status_screen.dart';
import '../models/entities/user.dart';


class ResetPasswordController extends GetxController {

  TextEditingController emailController = TextEditingController();
  UserReset? resetUser;
  final box = GetStorage();

  Future reset(BuildContext context) async {
    resetUser = await UserAuthRepository().reset(email: emailController.text.trim());

    if (resetUser!.status == '204') {
      await box.write('user_email', emailController.text.trim());

      Get.off(() => ResetStatusScreen());
    }
  }

}
