import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:obm_market/modules/auth/controllers/social_auth_controller.dart';

import '../../../constants/app_theme.dart';
import '../../../modules/auth/models/entities/user.dart';
import '../../../utils/validator.dart';
import '../../common/btn_bulk.dart';
import '../../common/form_input_field.dart';
import '../security/login_screen.dart';

class SocialRegisterScreen extends StatelessWidget {
  SocialRegisterScreen({required this.data, Key? key}) : super(key: key);

  final UserSocialData data;
  final SocialAuthController controller = Get.put(SocialAuthController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    controller.usernameController.text = '${data.firstname} ${data.lastname}';

    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppTheme.background,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
          ),
          elevation: 0,
          backgroundColor: AppTheme.background,
          title: Text(
            'Se connecter avec ${data.service}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.3,
              color: AppTheme.darkText
            )
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            splashRadius: 20.0,
            onPressed: () => Get.off(() => LoginScreen()),
          )
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                       Container(
                         margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                         padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                         color: AppTheme.info_color,
                         child: Text(
                           'Vous y êtes presque, il ne vous reste plus qu\'à choisir votre nom d\'utilisateur et votre numero de telephone',
                           style: TextStyle(
                             fontSize: 14.0,
                             fontWeight: FontWeight.w500,
                             color: AppTheme.darkText,
                             letterSpacing: 0.3
                           )
                         )
                       ),
                      Obx(() => (controller.violations.isNotEmpty) ?
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.violations.length,
                          padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
                          itemBuilder: (BuildContext context, int index) {
                            final message = controller.violations[index];

                            return Container(
                              padding: EdgeInsets.only(top: 4.0),
                              child: Text(
                                message,
                                style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.danger_color,
                                  letterSpacing: 0.3
                                )
                              )
                            );
                          },
                        ) :
                        SizedBox()
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              SizedBox(height: 15.0),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.0),
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
                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                child: FormInputField(
                                  controller: controller.phoneController,
                                  labelText: 'Teléphone',
                                  validator: RegisterValidator().phone,
                                  keyboardType: TextInputType.phone,
                                  onChanged: (value) => null,
                                  onSaved: (value) => controller.phoneController.text = value!,
                                ),
                              ),
                              SizedBox(height: 20.0),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                child: BtnBulk(
                                  text: 'Se connecter avec ${data.service}',
                                  backgroundColor: AppTheme.primary,
                                  color: AppTheme.white,
                                  borderColor: AppTheme.primary,
                                  callback: () async {
                                    if (_formKey.currentState!.validate()) {
                                      await controller.register(
                                        service: data.service,
                                        id: data.id,
                                        email: data.email,
                                        firstname: data.firstname,
                                        lastname: data.lastname
                                      );
                                    }
                                  },
                                ),
                              ),
                            ]
                        ),
                      )
                    ],
                  )
                ),
              )
            ],
          ),
        )
    );
  }
}
