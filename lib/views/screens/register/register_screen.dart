import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:obm_market/modules/auth/controllers/register_controller.dart';
import 'package:obm_market/utils/validator.dart';
import 'package:obm_market/views/common/btn_bulk.dart';
import 'package:obm_market/views/common/footer.dart';
import 'package:obm_market/views/common/form_checkbox_field.dart';
import 'package:obm_market/views/common/form_input_field.dart';
import 'package:obm_market/views/screens/security/login_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/app_theme.dart';
import '../../../modules/auth/controllers/social_auth_controller.dart';

class RegisterScreen extends GetView<RegisterController> {

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
          elevation: 0,
          backgroundColor: AppTheme.primary,
          title: Text(
            'S\'inscrire',
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
            onPressed: () => Get.off(() => LoginScreen()),
          )
        ),
        body: Container(
          decoration: BoxDecoration(
            color: AppTheme.primary
          ),
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
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        margin: EdgeInsets.only(top: 15.0),
                        height: MediaQuery.of(context).size.height * 1.55,
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
                                      'C\'est facile !',
                                      style: TextStyle(
                                        color: AppTheme.darkText,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Text(
                                      'Créez votre compte rapidement.',
                                      style: TextStyle(
                                        color: AppTheme.dark_grey,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15.0
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(height: 15.0),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: BtnBulkImg(
                                      text: 'S\'inscrire avec Google',
                                      color: AppTheme.dark_grey,
                                      backgroundColor: AppTheme.white,
                                      borderColor: AppTheme.grey.withOpacity(0.3),
                                      image: Image.asset('assets/images/socials/google.png', fit: BoxFit.cover),
                                      imagePosition: 'left',
                                      callback: () async {
                                        await socialAuthController.authenticateGoogle();
                                      }
                                    ),
                                  ),
                                  SizedBox(height: 15.0),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: BtnBulk(
                                      text: 'S\'inscrire avec Facebook',
                                      color: AppTheme.white,
                                      backgroundColor: AppTheme.facebook,
                                      borderColor: AppTheme.facebook,
                                      iconPosition: 'left',
                                      icon: FontAwesomeIcons.facebookSquare,
                                      callback: () async {
                                        await socialAuthController.authenticateFB();
                                      }
                                    ),
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
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        SizedBox(height: 15.0),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                                          child: FormInputField(
                                            controller: controller.usernameController,
                                            labelText: 'Nom d\'utilisateur',
                                            validator: RegisterValidator().username,
                                            keyboardType: TextInputType.text,
                                            onChanged: (value) => null,
                                            onSaved: (value) => controller.usernameController.text = value!,
                                          ),
                                        ),
                                        SizedBox(height: 15.0),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                                          child: FormInputField(
                                            controller: controller.lastnameController,
                                            labelText: 'Nom',
                                            validator: RegisterValidator().lastname,
                                            keyboardType: TextInputType.text,
                                            onChanged: (value) => null,
                                            onSaved: (value) => controller.firstnameController.text = value!,
                                          ),
                                        ),
                                        SizedBox(height: 15.0),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                                          child: FormInputField(
                                            controller: controller.firstnameController,
                                            labelText: 'Prénom',
                                            validator: RegisterValidator().firstname,
                                            keyboardType: TextInputType.text,
                                            onChanged: (value) => null,
                                            onSaved: (value) => controller.firstnameController.text = value!,
                                          ),
                                        ),
                                        SizedBox(height: 15.0),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                                          child: FormInputField(
                                            controller: controller.emailController,
                                            labelText: 'Adresse e-mail',
                                            validator: RegisterValidator().email,
                                            keyboardType: TextInputType.emailAddress,
                                            onChanged: (value) => null,
                                            onSaved: (value) => controller.emailController.text = value!,
                                          ),
                                        ),
                                        SizedBox(height: 15.0),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                                          child: FormInputField(
                                            controller: controller.phoneController,
                                            labelText: 'Teléphone',
                                            validator: RegisterValidator().phone,
                                            keyboardType: TextInputType.phone,
                                            onChanged: (value) => null,
                                            onSaved: (value) => controller.phoneController.text = value!,
                                          ),
                                        ),
                                        SizedBox(height: 15.0),
                                        Obx(() => Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                                          child: FormInputField(
                                            controller: controller.passwordController,
                                            labelText: 'Mot de passe',
                                            validator: RegisterValidator().password,
                                            keyboardType: TextInputType.text,
                                            iconSuffix: InkWell(
                                              onTap: () => controller.isSecret.value = !controller.isSecret.value,
                                              child: Icon(controller.isSecret.value ? Icons.visibility_off : Icons.visibility, color: AppTheme.primary),
                                            ),
                                            obscureText: controller.isSecret.value,
                                            onChanged: (value) => null,
                                            onSaved: (value) => controller.passwordController.text = value!,
                                            maxLines: 1,
                                          ),
                                        )),
                                        SizedBox(height: 15.0),
                                        Obx(() => Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                                          child: FormInputField(
                                            controller: controller.passwordRepeatController,
                                            labelText: 'Confirmer le mot de passe',
                                            iconSuffix: InkWell(
                                              onTap: () => controller.isSecretRepeat.value = !controller.isSecretRepeat.value,
                                              child: Icon(controller.isSecretRepeat.value ? Icons.visibility_off : Icons.visibility, color: AppTheme.primary),
                                            ),
                                            obscureText: controller.isSecretRepeat.value,
                                            validator: RegisterValidator(passwordData: controller.passwordController.text).passwordRepeat,
                                            keyboardType: TextInputType.text,
                                            onChanged: (value) => null,
                                            onSaved: (value) => controller.passwordRepeatController.text = value!,
                                            maxLines: 1,
                                          ),
                                        )),
                                        SizedBox(height: 20.0),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                                          child: BtnBulk(
                                            text: 'S\'inscrire',
                                            backgroundColor: AppTheme.primary,
                                            color: AppTheme.white,
                                            borderColor: AppTheme.primary,
                                            callback: () async {
                                              if (_formKey.currentState!.validate()) {
                                                await controller.register(context);
                                              }
                                            },
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                                          child: Wrap(
                                            alignment: WrapAlignment.center,
                                            children: [
                                              Text(
                                                'En vous inscrivant, vous acceptez notre',
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppTheme.darkText,
                                                  letterSpacing: 0.3,
                                                )
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  final Uri url = Uri.parse('https://oblackmarket.com/politique-de-confidentialite');

                                                  if (await canLaunchUrl(url)) {
                                                    await launchUrl(url);
                                                  }
                                                },
                                                child: Text(
                                                  'politique de confidentialité.',
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.w700,
                                                    color: AppTheme.secondary,
                                                    letterSpacing: 0.3,
                                                  )
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 30.0),
                                        Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Vous avez déja un compte ?',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w600,
                                              color: AppTheme.darkText,
                                              letterSpacing: 0.3,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10.0),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                                          child: BtnBulk(
                                            text: 'Connectez-vous',
                                            backgroundColor: AppTheme.white,
                                            color: AppTheme.primary,
                                            borderColor: AppTheme.primary,
                                            callback: () => Get.back()
                                          ),
                                        )
                                      ]
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Footer(
                              text: 'Power by',
                              logo: 'assets/images/logo/logo.png',
                              funFooterLogin: () {},
                              textColor: AppTheme.grey
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              )
            ],
          ),
        )
    );
  }

  Widget _checkboxInput(InkWell inkWell, bool isChecked, Function(bool?) onChanged) {

    return Padding(
      padding: EdgeInsets.only(left: 6.0),
      child: Row(
        children: [
          Transform.scale(
            scale: 1.23,
            child: FormCheckboxField(
              isChecked: isChecked,
              onChanged: onChanged,
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                inkWell,
                SizedBox(width: 7.0),
                Tooltip(
                  message: 'Il sera signifier dans vos annonces que votre numéro de téléphone est sur whatsapp.',
                  textStyle: TextStyle(
                    color: AppTheme.white,
                    letterSpacing: 0.3,
                    fontWeight: FontWeight.w400,
                    fontSize: 13.0
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    boxShadow: [
                      new BoxShadow(
                        color: AppTheme.grey.withOpacity(0.3),
                        blurRadius: 10.0,
                        offset: new Offset(6.0, 6.0),
                      ), //BoxShadow
                    ],
                    color: AppTheme.dark_grey
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 30.0),
                  showDuration: Duration(seconds: 3),
                  padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  verticalOffset: -80,
                  preferBelow: true,
                  child: Icon(FontAwesomeIcons.solidQuestionCircle, size: 18.0, color: AppTheme.grey.withOpacity(0.5)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

