import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:obm_market/modules/auth/models/entities/user.dart';
import 'package:obm_market/modules/auth/repository/user_repository.dart';

import '../../../views/screens/register/register_status_screen.dart';

class RegisterController extends GetxController {

  TextEditingController usernameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordRepeatController = TextEditingController();
  RxBool isChecked = false.obs;
  RxBool isSecret = true.obs;
  RxBool isSecretRepeat = true.obs;
  final box = GetStorage();
  User? user;

  register(BuildContext context) async {
    user = await UserRepository().add(
      username: usernameController.text.trim(),
      email: emailController.text.trim(),
      firstname: firstnameController.text.trim(),
      lastname: lastnameController.text.trim(),
      phone: phoneController.text.trim(),
      phoneStatus: isChecked.value,
      password: passwordController.text.trim()
    );

    if (user!.status == '201') {

      await box.write("user_id", user!.id);
      await box.write('user_email', user!.email);

      usernameController.clear();
      emailController.clear();
      firstnameController.clear();
      lastnameController.clear();
      phoneController.clear();
      passwordController.clear();
      passwordRepeatController.clear();
      isChecked.value = false;

      Get.off(() => RegisterStatusScreen());
    }
  }
}
