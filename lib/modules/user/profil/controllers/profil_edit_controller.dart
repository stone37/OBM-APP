import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../views/widgets/message/successMessage.dart';
import '../../../auth/models/entities/user.dart';
import '../../../auth/repository/user_repository.dart';

class ProfilEditController extends GetxController {

  TextEditingController usernameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  RxBool isChecked = false.obs;

  final box = GetStorage();
  User? user;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    lastnameController.dispose();
    firstnameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    cityController.dispose();
  }

  init() {
    usernameController.text = box.read('user_username');
    lastnameController.text = box.read('user_lastname');
    firstnameController.text = box.read('user_firstname');
    emailController.text = box.read('user_email');
    phoneController.text = box.read('user_phone');
    addressController.text = box.read('user_address');
    cityController.text = box.read('user_city');
  }

  profilUpdate() async {
    user = await UserRepository().edit(
        token: box.read('token'),
        id: box.read('user_id'),
        username: usernameController.text.trim(),
        email: emailController.text.trim(),
        firstname: firstnameController.text.trim(),
        lastname: lastnameController.text.trim(),
        phone: phoneController.text.trim(),
        phoneStatus: isChecked.value,
        city: cityController.text.trim(),
        address: addressController.text.trim());

    if (user!.status == '200') {
      await box.write('user_username', user!.username);
      await box.write('user_firstname', user!.firstname);
      await box.write('user_lastname', user!.lastname);
      await box.write('user_email', user!.email);
      await box.write('user_phone', user!.phone);
      await box.write('user_address', user!.address);
      await box.write('user_city', user!.city);

      Get.back();

      showSuccessMessage(message: 'Vos informations ont bien été modifier.');
    }
  }
}

