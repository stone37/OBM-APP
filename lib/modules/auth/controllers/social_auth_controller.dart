import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:obm_market/modules/auth/models/entities/user.dart';
import 'package:obm_market/modules/auth/repository/user_auth_repository.dart';
import 'package:obm_market/modules/auth/repository/user_repository.dart';
import 'package:obm_market/modules/menu/controllers/menu_controller.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:obm_market/views/widgets/message/errorMessage.dart';

import '../../../views/screens/menu/menu_screen.dart';
import '../../../views/screens/register/social_register_screen.dart';
import '../../../views/widgets/message/successMessage.dart';
import 'auth_controller.dart';

class SocialAuthController extends GetxController {

  final AuthController controller = Get.find();
  final FacebookLogin facebookLogin = FacebookLogin();
  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/user.emails.read',
      'https://www.googleapis.com/auth/user.phonenumbers.read',
      'https://www.googleapis.com/auth/userinfo.profile'
    ],
    clientId: '949979683990-v8neljhlg3jjj46s409tsfslj8p3bq7d.apps.googleusercontent.com'
  );

  MenuController menuController = Get.find();
  final box = GetStorage();
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  RxList violations = [].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  authenticateGoogle() async {
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if (await googleSignIn.isSignedIn()) {
      try {
        final response = await Dio().get('https://people.googleapis.com/v1/people/me?personFields=names,emailAddresses,phoneNumbers',
            options: Options(headers: await googleSignInAccount?.authHeaders));

        if (response.statusCode == 200) {
          final results = Map<String, dynamic>.from(response.data);

          final String firstname = results['names'][0]['givenName'];
          final String lastname = results['names'][0]['familyName'];
          final bool verified = results['emailAddresses'][0]['metadata']['verified'];

          final UserSocialAuth? authenticateResponse = await UserAuthRepository().socialAuthenticate(
              service: 'google',
              id: googleSignInAccount!.id,
              email: googleSignInAccount.email,
              emailVerified: verified
            );

          print(authenticateResponse);

          if (authenticateResponse!.status == '200') {
            controller.connected = true;
            getUser(authenticateResponse.token!);

            await box.write('token', authenticateResponse.token);
            await box.write('refresh_token', authenticateResponse.refreshToken);

            controller.update();

            showSuccessMessage(message: 'Vous êtes maintenant connecté.');

            Get.off(() => MenuScreen());
          } else if (authenticateResponse.status == '202') {
            violations.value = [];

            Get.off(() => SocialRegisterScreen(data: UserSocialData(
                  service: 'google',
                  id: googleSignInAccount.id,
                  email: googleSignInAccount.email,
                  firstname: firstname,
                  lastname: lastname
                )
              )
            );
          } else {
            controller.connected = false;
            update();
          }
        }
      } on DioError catch (err) {
        print(err.response);
      }
    }
  }

  Future authenticateFB() async {
    final FacebookLoginResult facebookLoginResult = await facebookLogin.logIn(
      permissions: [FacebookPermission.publicProfile, FacebookPermission.email]
    );

    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.success:
        final FacebookUserProfile? profile = await facebookLogin.getUserProfile();
        final String? email = await facebookLogin.getUserEmail();

        final UserSocialAuth? authenticateResponse = await UserAuthRepository().socialAuthenticate(
          service: 'facebook',
          id: profile!.userId,
          email: email!,
          emailVerified: true
        );

        print(authenticateResponse);

        if (authenticateResponse!.status == '200') {
          controller.connected = true;
          getUser(authenticateResponse.token!);

          await box.write('token', authenticateResponse.token);
          await box.write('refresh_token', authenticateResponse.refreshToken);

          controller.update();

          showSuccessMessage(message: 'Vous êtes maintenant connecté.');

          Get.off(() => MenuScreen());
        } else if (authenticateResponse.status == '202') {
          violations.value = [];

          await Get.off(() => SocialRegisterScreen(data: UserSocialData(
                service: 'facebook',
                id: profile.userId,
                email: email,
                firstname: profile.firstName!,
                lastname:profile.lastName!
              )
            )
          );
        } else {
          controller.connected = false;
          update();
        }
        break;
      case FacebookLoginStatus.cancel:
        break;
      case FacebookLoginStatus.error:
        print('Error while log in: ${facebookLoginResult.error}');
        break;
    }
  }

  register({
    required String service,
    required String id,
    required String email,
    required String firstname,
    required String lastname,
  }) async {
    final registerResponse = await UserAuthRepository().socialRegister(
        service: service,
        id: id,
        email: email,
        firstname: firstname,
        lastname: lastname,
        username: usernameController.text.trim(),
        phone: phoneController.text.trim()
    );

    if (registerResponse!.status == '200') {
      controller.connected = true;
      getUser(registerResponse.token!);

      await box.write('token', registerResponse.token);
      await box.write('refresh_token', registerResponse.refreshToken);

      controller.update();

      showSuccessMessage(message: 'Vous êtes maintenant connecté.');

      Get.off(() => MenuScreen());
    } else {
      showErrorMessage('Il existe déjà un compte avec cet nom d\'utilisateur cet numéro de téléphone...');

      controller.connected = false;
      update();
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
}
