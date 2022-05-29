import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:obm_market/constants/app_theme.dart';
import 'package:obm_market/modules/user/profil/controllers/account_delete_controller.dart';
import '../../../../../utils/validator.dart';
import '../../../../common/btn_bulk.dart';
import '../../../../common/form_advert_data.dart';

class AccountCloseScreen extends StatelessWidget {

  final AccountDeleteController controller = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    controller.deleteAt.value = (box.read('user_delete_at') != null);

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
            'Fermeture du compte',
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Container(
                      child: Obx(() => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 15.0, bottom: 15.0),
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Suppression de votre compte',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.darkerText,
                                letterSpacing: 0.3
                              ),
                            ),
                          ),
                          (!controller.deleteAt.value) ?
                            Container(
                              padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Vous êtes sur le point de supprimer votre compte OBM. Pour confirmer cette demande merci de rentrer votre mot de passe. Le compte sera automatiquement supprimé au bout de 5 jours',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w500,
                                    color: AppTheme.grey,
                                    letterSpacing: 0.3
                                ),
                              ),
                            ) : Container(
                                padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                                alignment: Alignment.topLeft,
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Votre compte sera supprimé automatiquement le ',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                      color: AppTheme.darkerText,
                                      letterSpacing: 0.3
                                    ),
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text: (controller.deleteAt.value) ? '${formatDate(box.read('user_delete_at'), [dd, '/', mm, '/', yyyy])}.' : '',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500,
                                          color: AppTheme.primary,
                                          letterSpacing: 0.3
                                        ),
                                      )
                                    ]
                                  )
                                ),
                              ) ,

                          (!controller.deleteAt.value) ?
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
                                            'Mot de passe',
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
                                            hintText: 'Entrez votre mot de passe pour confirmer',
                                            onChanged: (value) => null,
                                            maxLines: 1,
                                            onSaved: (value) => controller.passwordController.text = value!,
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                                  SizedBox(height: 10.0),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: BtnBulk(
                                      text: 'Confirmer la suppression',
                                      backgroundColor: AppTheme.danger_color,
                                      color: AppTheme.white,
                                      borderColor: AppTheme.danger_color,
                                      callback: () async {
                                        if (_formKey.currentState!.validate()) {
                                          await controller.delete();
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 20.0),
                                ],
                              ),
                            ) : Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: BtnBulk(
                              text: 'Annuler la suppression',
                              backgroundColor: AppTheme.defaults,
                              color: AppTheme.white,
                              borderColor: AppTheme.defaults,
                              icon: FontAwesomeIcons.trash,
                              iconPosition: 'left',
                              callback: () async {
                                await controller.cancel();
                              },
                            ),
                          ),
                        ],
                      ))
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}
