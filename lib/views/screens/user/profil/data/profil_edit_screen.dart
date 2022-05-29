import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:obm_market/constants/app_theme.dart';
import 'package:obm_market/modules/user/profil/controllers/profil_edit_controller.dart';

import '../../../../../utils/validator.dart';
import '../../../../common/btn_bulk.dart';
import '../../../../common/form_advert_data.dart';

class ProfilEditScreen extends StatelessWidget {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ProfilEditController controller = Get.find();

    controller.init();

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
            'Modification du profil',
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
                          padding: EdgeInsets.only(left: 15.0, bottom: 13.0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Modifier vos imformations',
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
                              Padding(
                                padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.0, bottom: 5.0),
                                      child: Text(
                                        'Nom d\'utilisateur',
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
                                        controller: controller.usernameController,
                                        validator: Validator().notBlank,
                                        keyboardType: TextInputType.text,
                                        prefix: Icon(FontAwesomeIcons.user, color: AppTheme.grey),
                                        hintText: 'Écrivez votre nom d\'utilisateur',
                                        onChanged: (value) => null,
                                        onSaved: (value) => controller.usernameController.text = value!,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.0, bottom: 5.0),
                                      child: Text(
                                        'Nom',
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
                                        controller: controller.lastnameController,
                                        validator: Validator().notBlank,
                                        keyboardType: TextInputType.text,
                                        prefix: Icon(FontAwesomeIcons.user, color: AppTheme.grey),
                                        hintText: 'Écrivez votre nom',
                                        onChanged: (value) => null,
                                        onSaved: (value) => controller.lastnameController.text = value!,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.0, bottom: 5.0),
                                      child: Text(
                                        'Prénom',
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
                                        controller: controller.firstnameController,
                                        validator: Validator().notBlank,
                                        keyboardType: TextInputType.text,
                                        prefix: Icon(FontAwesomeIcons.user, color: AppTheme.grey),
                                        hintText: 'Écrivez votre prénom',
                                        onChanged: (value) => null,
                                        onSaved: (value) => controller.firstnameController.text = value!,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.0, bottom: 5.0),
                                      child: Text(
                                        'Email',
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
                                        controller: controller.emailController,
                                        validator: Validator().notBlank,
                                        keyboardType: TextInputType.text,
                                        prefix: Icon(FontAwesomeIcons.envelope, color: AppTheme.grey),
                                        hintText: 'Écrivez votre email',
                                        onChanged: (value) => null,
                                        onSaved: (value) => controller.emailController.text = value!,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.0, bottom: 5.0),
                                      child: Text(
                                        'Numéro de telephone',
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
                                        controller: controller.phoneController,
                                        validator: Validator().notBlank,
                                        keyboardType: TextInputType.text,
                                        prefix: Icon(FontAwesomeIcons.phoneAlt, color: AppTheme.grey),
                                        hintText: 'Écrivez votre numéro de telephone',
                                        onChanged: (value) => null,
                                        onSaved: (value) => controller.phoneController.text = value!,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.0, bottom: 5.0),
                                      child: Text(
                                        'Adresse',
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
                                        controller: controller.addressController,
                                        validator: null,
                                        keyboardType: TextInputType.text,
                                        prefix: Icon(FontAwesomeIcons.addressBook, color: AppTheme.grey),
                                        hintText: 'Écrivez votre adresse',
                                        onChanged: (value) => null,
                                        onSaved: (value) => controller.addressController.text = value!,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.0, bottom: 5.0),
                                      child: Text(
                                        'Ville',
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
                                        controller: controller.cityController,
                                        validator: null,
                                        keyboardType: TextInputType.text,
                                        prefix: Icon(FontAwesomeIcons.mapMarkerAlt, color: AppTheme.grey),
                                        hintText: 'Écrivez votre ville',
                                        onChanged: (value) => null,
                                        onSaved: (value) => controller.cityController.text = value!,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: BtnBulk(
                                  text: 'Modifier mon profil',
                                  backgroundColor: AppTheme.primary,
                                  color: AppTheme.white,
                                  borderColor: AppTheme.primary,
                                  callback: () async {
                                    if (_formKey.currentState!.validate()) {
                                      await controller.profilUpdate();
                                    }
                                  },
                                ),
                              ),
                              SizedBox(height: 20.0),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ),
              )
            ],
          ),
        )
    );
  }
}
