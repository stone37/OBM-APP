import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:obm_market/constants/app_theme.dart';
import 'package:obm_market/modules/auth/controllers/auth_controller.dart';
import 'package:obm_market/views/common/not_authorisation.dart';

class CreditScreen extends StatelessWidget {
  const CreditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      child: GetBuilder<AuthController>(
          builder: (controller) => controller.connected == false ?
          NotAuthorisation(
              image: Image.asset('assets/images/credit.png'),
              title: 'Simplifiez vous la vie avec nos crédits.',
              description: 'Facilité vos achats d\'options pour vos annonces '
                  'par l\'utilisation de vos crédits.'
          ) :
          Container(child: Center(child: Text('Connecter !!!')))
      ),
    );
  }
}
