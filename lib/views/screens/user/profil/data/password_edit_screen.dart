import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:obm_market/constants/app_theme.dart';
import 'package:obm_market/modules/user/profil/controllers/password_edit_controller.dart';

import '../../../../../utils/validator.dart';
import '../../../../common/btn_bulk.dart';
import '../../../../common/form_advert_data.dart';

class PasswordEditScreen extends StatelessWidget {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final PasswordEditController controller = Get.find();

    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppTheme.background,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
          ),
          titleSpacing: 0.0,
          elevation: 0,
          backgroundColor: AppTheme.background,
          title: Text(
            'Edition du mot de passe',
            style: TextStyle(
              color: AppTheme.darkerText
            )
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            splashRadius: 25.0,
            onPressed: () => Get.back(),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: AppTheme.background,
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 15.0, bottom: 15.0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Modifier votre mot de passe',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.darkerText,
                              letterSpacing: 0.3
                            ),
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Obx(() => Padding(
                                padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.0, bottom: 5.0),
                                      child: Text(
                                        'Nouveau mot de passe',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500,
                                          color: AppTheme.darkerText,
                                          letterSpacing: 0.3,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: FormDataField(
                                        controller: controller.passwordController,
                                        validator: RegisterValidator().password,
                                        keyboardType: TextInputType.text,
                                        prefix: Icon(FontAwesomeIcons.lock, color: AppTheme.grey),
                                        iconSuffix: InkWell(
                                          onTap: () => controller.isSecret.value = !controller.isSecret.value,
                                          child: Icon(controller.isSecret.value ? Icons.visibility_off : Icons.visibility, color: AppTheme.primary),
                                        ),
                                        obscureText: controller.isSecret.value,
                                        hintText: 'Écrivez votre nouveau mot de passe',
                                        onChanged: (value) => null,
                                        maxLines: 1,
                                        onSaved: (value) => controller.passwordController.text = value!,
                                      ),
                                    )
                                  ],
                                ),
                              )),
                              Obx(() => Padding(
                                padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.0, bottom: 5.0),
                                      child: Text(
                                        'Confirmer le mot de passe',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500,
                                          color: AppTheme.darkerText,
                                          letterSpacing: 0.3,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: FormDataField(
                                        controller: controller.passwordRepeatController,
                                        validator: RegisterValidator(passwordData: controller.passwordController.text).passwordRepeat,
                                        keyboardType: TextInputType.text,
                                        prefix: Icon(FontAwesomeIcons.lock, color: AppTheme.grey),
                                        iconSuffix: InkWell(
                                          onTap: () => controller.isSecretRepeat.value = !controller.isSecretRepeat.value,
                                          child: Icon(controller.isSecretRepeat.value ? Icons.visibility_off : Icons.visibility, color: AppTheme.primary),
                                        ),
                                        obscureText: controller.isSecretRepeat.value,
                                        hintText: 'Écrivez le meme mot de passe',
                                        onChanged: (value) => null,
                                        maxLines: 1,
                                        onSaved: (value) => controller.passwordRepeatController.text = value!,
                                      ),
                                    )
                                  ],
                                ),
                              )),
                              SizedBox(height: 10.0),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: BtnBulk(
                                  text: 'Modifier mon mot de passe',
                                  backgroundColor: AppTheme.primary,
                                  color: AppTheme.white,
                                  borderColor: AppTheme.primary,
                                  callback: () async {
                                    if (_formKey.currentState!.validate()) {
                                      await controller.passwordUpdate();
                                    }
                                  },
                                ),
                              ),
                              SizedBox(height: 20.0),
                            ],
                          ),
                        )
                      ],
                    )
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}
