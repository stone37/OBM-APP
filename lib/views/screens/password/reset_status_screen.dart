import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:obm_market/views/screens/password/reset_password_screen.dart';

import '../../../constants/app_theme.dart';
import '../../common/btn_bulk.dart';
import '../../common/footer.dart';
import '../menu/menu_screen.dart';

class ResetStatusScreen extends StatelessWidget {
  const ResetStatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();

    return Scaffold(
        body: Container(
          color: AppTheme.background,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: MediaQuery.of(context).padding.top),
                    SizedBox(height: 10.0),
                    Container(
                      child: Text(
                        'Un petit effort ...',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primary,
                          letterSpacing: 0.3
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'Veuillez vérifier votre adresse e-mail ${box.read('user_email')} pour réinitialiser votre mot de passe.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.darkText,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      width: MediaQuery.of(context).size.width*.9,
                      height: 3.0,
                      color: AppTheme.primary,
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: 'Si',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.darkText,
                              letterSpacing: 0.3,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' ${box.read('user_email')} ',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.defaults,
                                  letterSpacing: 0.3,
                                ),
                              ),
                              TextSpan(text: ' n\'est pas votre adresse mail, veuiller revenir en arrière '),
                              TextSpan(
                                text: 'et saisir la bonne',
                              ),
                            ]
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'Si vous n\'avez pas recu notre e-mail dans 15 minutes, veuillez vérifier votre dossier spam.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.darkText,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                    SizedBox(height: 40.0),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width*0.48,
                            child: PageButton(
                              text: 'Retour en arrière',
                              textColor: AppTheme.primary,
                              backgroundColor: AppTheme.white,
                              borderColor: AppTheme.primary,
                              iconPosition: 'left',
                              icon: Icons.arrow_back,
                              callback: () => Get.to(() => ResetPasswordScreen())
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*0.38,
                            child: PageButton(
                              text: 'Accueil',
                              textColor: AppTheme.white,
                              backgroundColor: AppTheme.primary,
                              borderColor: AppTheme.primary,
                              callback: () => Get.off(() => MenuScreen())
                            ),
                          )
                        ],
                      )
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Footer(
                      text: 'Power by',
                      logo: 'assets/images/logo/logo.png',
                      funFooterLogin: () {},
                      textColor: AppTheme.darkText
                    ),
                    SizedBox(height: 20.0)
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}



