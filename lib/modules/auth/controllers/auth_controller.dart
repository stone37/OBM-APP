import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:obm_market/modules/auth/models/entities/user.dart';
import 'package:obm_market/modules/auth/repository/user_auth_repository.dart';
import 'package:obm_market/modules/auth/repository/user_repository.dart';
import 'package:obm_market/modules/menu/controllers/menu_controller.dart';
import 'package:obm_market/views/screens/menu/menu_screen.dart';
import 'package:obm_market/views/widgets/loading/loading.dart';
import 'package:obm_market/views/widgets/message/successMessage.dart';

class AuthController extends GetxController {

  MenuController menuController = Get.find();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final box = GetStorage();
  UserAuth? auth;
  User? user;
  bool connected = false;
  RxBool isSecret = true.obs;

  Future login(BuildContext context) async {
    connected = true;

    update();

    auth = await UserAuthRepository().authenticate(username: usernameController.text.trim(), password: passwordController.text.trim());

    if (auth!.status == '200') {

      showLoading();

      getUser(auth!.token);

      await box.write('token', auth!.token);
      await box.write('refresh_token', auth!.refreshToken);

      update();

      usernameController.clear();
      passwordController.clear();

      stopLoading();

      showSuccessMessage(message: 'Vous êtes maintenant connecté.');

      Get.off(() => MenuScreen());
    } else {
      connected = false;
      update();
    }
  }

  logout() async {

    menuController.goToHome();
    Get.off(() => MenuScreen());

    box.remove('token');
    box.remove('refresh_token');

    showSuccessMessage(message: 'Vous êtes maintenant deconnecté.');

    connected = false;
    update();
  }

  autoLogin() async {
    if (box.hasData('refresh_token') == true) {
      auth = await UserAuthRepository().refresh(refreshToken: box.read('refresh_token'));

      if (auth!.status == '200') {

        getUser(auth!.token);

        await box.write('token', auth!.token);
        await box.write('refresh_token', auth!.refreshToken);

        connected = true;
        update();

        Get.off(() => MenuScreen());
      } else if (auth!.status == '401') {
        box.remove('token');
        box.remove('refresh_token');

        Get.off(() => MenuScreen());
      } else {
        box.remove('token');
        box.remove('refresh_token');

        Get.off(() => MenuScreen());
      }
    } else {
      Get.off(() => MenuScreen());
    }
  }

  getUser(String data) async {
    var user = await UserRepository().find(token: data);

    await box.write('user_id', user.id);
    await box.write('user_username', user.username);
    await box.write('user_firstname', user.firstname);
    await box.write('user_lastname', user.lastname);
    await box.write('user_email', user.email);
    await box.write('user_phone', user.phone);
    await box.write('user_address', user.address);
    await box.write('user_city', user.city);
    await box.write('user_delete_at', user.deleteAt);
    (user.imageUrl.isNotEmpty) ?
      await box.write('user_file', user.imageUrl) :
      await box.write('user_file', null);
    return user;
  }

  refreshToken({required String token}) async {
    auth = await UserAuthRepository().refresh(refreshToken: token);

      if (auth!.status == '200') {

        await box.write('token', auth!.token);
        await box.write('refresh_token', auth!.refreshToken);

      } else if (auth!.status == '401') {

        connected = false;

        box.remove('token');
        box.remove('refresh_token');

        Get.off(() => MenuScreen());
      } else {

        connected = false;

        box.remove('token');
        box.remove('refresh_token');

        Get.off(() => MenuScreen());
      }
    }
}
