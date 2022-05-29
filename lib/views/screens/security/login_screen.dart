import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:obm_market/modules/auth/controllers/auth_controller.dart';
import 'package:obm_market/utils/validator.dart';
import 'package:obm_market/views/common/btn_bulk.dart';
import 'package:obm_market/views/common/footer.dart';
import 'package:obm_market/views/common/form_input_field_with_icon.dart';
import 'package:obm_market/views/common/form_vertical_spacing.dart';
import 'package:obm_market/views/screens/register/register_screen.dart';
import 'package:obm_market/views/screens/password/reset_password_screen.dart';
import '../../../constants/app_theme.dart';
import '../../../modules/auth/controllers/social_auth_controller.dart';
import '../menu/menu_screen.dart';

class LoginScreen extends GetWidget<AuthController> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SocialAuthController socialAuthController = Get.put(SocialAuthController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppTheme.primary,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light,
          ),
          elevation: 0.0,
          backgroundColor: AppTheme.primary,
          title: Text(
           'Se connecter',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.3
            )
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            splashRadius: 20.0,
            onPressed: () => Get.off(() => MenuScreen()),
          )
        ),
        body: Container(
          decoration: BoxDecoration(color: AppTheme.primary),
          height: double.infinity,
          child: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.zero,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.14,
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Center(
                              child: Image.asset(
                                'assets/images/logo/logo_write.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                        margin: EdgeInsets.only(top: 15.0),
                        height: MediaQuery.of(context).size.height * 0.98,
                        width: MediaQuery.of(context).size.width,
                        decoration: new BoxDecoration(
                          color: AppTheme.white,
                          borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(50.0),
                            topRight: const Radius.circular(50.0),
                          )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Text(
                                      'Connectez-vous pour découvrir toutes nos fonctionnalités.',
                                      style: TextStyle(
                                        color: AppTheme.darkText,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15.0
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(height: 15.0),
                                  BtnBulkImg(
                                    text: 'Se connecter avec Google',
                                    color: AppTheme.dark_grey,
                                    backgroundColor: AppTheme.white,
                                    borderColor: AppTheme.grey.withOpacity(0.2),
                                    image: Image.asset('assets/images/socials/google.png', fit: BoxFit.cover),
                                    imagePosition: 'left',
                                    callback: () async {
                                      await socialAuthController.authenticateGoogle();
                                    }
                                  ),
                                  SizedBox(height: 15.0),
                                  BtnBulk(
                                    text: 'Se connecter avec Facebook',
                                    color: AppTheme.white,
                                    backgroundColor: AppTheme.facebook,
                                    borderColor: AppTheme.facebook,
                                    iconPosition: 'left',
                                    icon: FontAwesomeIcons.facebookSquare,
                                    callback: () async {
                                      await socialAuthController.authenticateFB();
                                    }
                                  ),
                                  SizedBox(height: 15.0),
                                  Container(
                                    child: Text(
                                      'Ou',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                        color: AppTheme.darkText
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        SizedBox(height: 15.0),
                                        Container(
                                          child: FormInputFieldWithIcon(
                                            controller: controller.usernameController,
                                            iconPrefix: FontAwesomeIcons.solidEnvelope,
                                            labelText: 'Nom d\'utilisateur ou e-mail',
                                            validator: Validator().notBlank,
                                            keyboardType: TextInputType.emailAddress,
                                            onChanged: (value) => null,
                                            onSaved: (value) => controller.usernameController.text = value!,
                                          ),
                                        ),
                                        FormVerticalSpace(),
                                        Obx(() => Container(
                                            child: FormInputFieldWithIcon(
                                              controller: controller.passwordController,
                                              iconPrefix: FontAwesomeIcons.unlock,
                                              iconSuffix: InkWell(
                                                onTap: () => controller.isSecret.value = !controller.isSecret.value,
                                                child: Icon(controller.isSecret.value ? Icons.visibility_off : Icons.visibility, color: AppTheme.primary),
                                              ),
                                              labelText: 'Mot de passe',
                                              validator: Validator().password,
                                              obscureText: controller.isSecret.value,
                                              onChanged: (value) => null,
                                              onSaved: (value) => controller.passwordController.text = value!,
                                              maxLines: 1,
                                            )
                                        )),
                                        FormVerticalSpace(),
                                        BtnBulk(
                                          text: 'Se connecter',
                                          backgroundColor: AppTheme.primary,
                                          color: AppTheme.white,
                                          borderColor: AppTheme.primary,
                                          callback: () async {
                                            if (_formKey.currentState!.validate()) {
                                              await controller.login(context);
                                            }
                                          },
                                        ),
                                        SizedBox(height: 30.0),
                                        Container(
                                          alignment: Alignment.center,
                                          child: InkWell(
                                            onTap: () {
                                              Get.to(ResetPasswordScreen(), transition: Transition.rightToLeftWithFade);
                                            },
                                            child: Text(
                                              'Mot de passe oublié ?',
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w500,
                                                color: AppTheme.secondary,
                                                letterSpacing: 0.3,
                                                decoration: TextDecoration.underline
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 30.0),
                                        Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Vous n\'avez pas de compte ?',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w600,
                                              color: AppTheme.darkText,
                                              letterSpacing: 0.3,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10.0),
                                        BtnBulk(
                                          text: 'S\'inscrire',
                                          backgroundColor: AppTheme.white,
                                          color: AppTheme.primary,
                                          borderColor: AppTheme.primary,
                                          callback: () {
                                            Get.to(RegisterScreen(), transition: Transition.upToDown);
                                          },
                                        )
                                      ],
                                    )
                                  ),
                                ],
                              ),
                            ),
                            Footer(
                              text: 'Power by',
                              logo: 'assets/images/logo/logo.png',
                              funFooterLogin: () {},
                              textColor: AppTheme.darkText
                            )
                          ],
                        )
                      )
                    ],
                  ),
                )
              )
            ],
          ),
        ),
    );
  }
}

