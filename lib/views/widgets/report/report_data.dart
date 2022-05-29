import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_theme.dart';
import '../../../modules/report/controllers/report_controller.dart';

class ReportReasonFielData extends StatelessWidget {
  const ReportReasonFielData({Key? key, required this.controller}) : super(key: key);

  final ReportController controller;

  @override
  Widget build(BuildContext context) {

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 5.0, bottom: 5.0),
              child: Text(
                'Raison le l\'abus',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.darkerText,
                  letterSpacing: 0.3,
                ),
              ),
            ),
            Column(
              children: <Widget>[
                FormRadioField(
                  title: "Le prix de l'annonce ne semble pas cohérent par rapport au marché",
                  value: "Le prix de l'annonce ne semble pas cohérent par rapport au marché",
                  data: controller.reason.value,
                  callback: (String? value) {
                    controller.reason.value = value!;
                  }
                ),
                SizedBox(height: 3.0),
                FormRadioField(
                  title: "L'annonceur vous parait suspect. ex: demande un mandat cash, non joignable par téléphone.....",
                  value: "L'annonceur vous parait suspect. ex: demande un mandat cash, non joignable par téléphone.....",
                  data: controller.reason.value,
                  callback: (String? value) {
                    controller.reason.value = value!;
                  }
                ),
                SizedBox(height: 3.0),
                FormRadioField(
                  title: "L'annonceur n'est pas un particulier mais un professionnel",
                  value: "L'annonceur n'est pas un particulier mais un professionnel",
                  data: controller.reason.value,
                  callback: (String? value) {
                    controller.reason.value = value!;
                  }
                ),
                SizedBox(height: 3.0),
                FormRadioField(
                  title: "Le bien vous semble etre une contrefaçon ou correspond à une vente interdite",
                  value: "Le bien vous semble etre une contrefaçon ou correspond à une vente interdite",
                  data: controller.reason.value,
                  callback: (String? value) {
                    controller.reason.value = value!;
                  }
                ),
                SizedBox(height: 3.0),
                FormRadioField(
                  title: "Cette annonce correspond à une atteinte à la vie privée ou au droit à l'image",
                  value: "Cette annonce correspond à une atteinte à la vie privée ou au droit à l'image",
                  data: controller.reason.value,
                  callback: (String? value) {
                    controller.reason.value = value!;
                  }
                ),
                SizedBox(height: 3.0),
                FormRadioField(
                  title: "Cette annonce n'est pas dans la bonne rubrique ou contient des informations erronées",
                  value: "Cette annonce n'est pas dans la bonne rubrique ou contient des informations erronées",
                  data: controller.reason.value,
                  callback: (String? value) {
                    controller.reason.value = value!;
                  }
                ),
              ],
            ),
            (controller.reasonValidatorState.value == 'error') ?
            Padding(
              padding: EdgeInsets.only(top: 6.0, left: 10.0),
              child: Text(
                'Veuillez choisir une raison de signalement.',
                style: TextStyle(
                  fontSize: 11.6,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.danger_color
                ),
              ),
            ) : SizedBox()
          ],
        ))
    );
  }
}

class FormRadioField extends StatelessWidget {
  FormRadioField({
    Key? key,
    required this.title,
    required this.value,
    required this.callback,
    required this.data
  }) : super(key: key);

  final String title;
  final String value;
  final  Function(String?) callback;
  final String? data;

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Radio(
            value: value,
            groupValue: data,
            onChanged: callback,
            activeColor: AppTheme.defaults,
            visualDensity: VisualDensity.comfortable,
          ),
          Container(
            width: MediaQuery.of(context).size.width * .8,
            child: Text(
              title,
              maxLines: 3,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: AppTheme.grey,
                letterSpacing: 0.3
              ),
            ),
          )
        ],
      ),
    );
  }
}





