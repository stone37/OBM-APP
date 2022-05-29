import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:obm_market/modules/auth/controllers/reset_password_controller.dart';
import 'package:obm_market/utils/validator.dart';
import 'package:obm_market/views/common/btn_bulk.dart';
import 'package:obm_market/views/common/footer.dart';
import 'package:obm_market/views/common/form_input_field_with_icon.dart';
import 'package:obm_market/views/common/form_vertical_spacing.dart';
import 'package:obm_market/views/screens/security/login_screen.dart';

import '../../../constants/app_theme.dart';

class ResetPasswordScreen extends GetView<ResetPasswordController> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
            'Récupérer mon mot de passe',
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
          ),
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
                        height: MediaQuery.of(context).size.height * 0.715,
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
                          children: [
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Text(
                                      'Ne t\'inquiète pas !',
                                      style: TextStyle(
                                        color: AppTheme.darkText,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 6.0),
                                    child: Text(
                                      'On va vous envoyer un lien pour réinitialiser votre mot de passe a votre adresse email.',
                                      style: TextStyle(
                                        color: AppTheme.dark_grey,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15.0
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(height: 15.0),
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        SizedBox(height: 15.0),
                                        Container(
                                          child: FormInputFieldWithIcon(
                                            controller: controller.emailController,
                                            iconPrefix: FontAwesomeIcons.solidEnvelope,
                                            labelText: 'Entrer votre adresse e-mail',
                                            validator: RegisterValidator().email,
                                            keyboardType: TextInputType.emailAddress,
                                            onChanged: (value) => null,
                                            onSaved: (value) => controller.emailController.text = value!,
                                          ),
                                        ),

                                        FormVerticalSpace(),
                                        BtnBulk(
                                          text: 'M\'envoyer les instructions',
                                          backgroundColor: AppTheme.primary,
                                          color: AppTheme.white,
                                          borderColor: AppTheme.primary,
                                          callback: () async {
                                            if (_formKey.currentState!.validate()) {
                                              await controller.reset(context);
                                            }
                                          },
                                        ),
                                      ]
                                    )
                                  )
                                ]
                              )
                            ),
                            Footer(
                              text: 'Power by',
                              logo: 'assets/images/logo/logo.png',
                              funFooterLogin: () {},
                              textColor: AppTheme.dark_grey
                            )
                          ],
                        )
                      )
                    ]
                  )
                )
              )
            ]
          ),
        )
    );
  }
}
