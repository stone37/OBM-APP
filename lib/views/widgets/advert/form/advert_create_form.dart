import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:obm_market/modules/advert/controllers/advert_create_controller.dart';
import 'package:obm_market/utils/validator.dart';
import 'package:obm_market/views/screens/advert/form/city_screen.dart';
import 'package:obm_market/views/screens/advert/form/zone_screen.dart';

import '../../../../constants/app_theme.dart';
import '../../../../utils/advert_field_state.dart';
import '../../../common/form_advert_data.dart';
import '../../../screens/advert/form/auto_state_screen.dart';
import '../../../screens/advert/form/auto_type_screen.dart';
import '../../../screens/advert/form/auto_year_screen.dart';
import '../../../screens/advert/form/boite_vitesse_screen.dart';
import '../../../screens/advert/form/brand_screen.dart';
import '../../../screens/advert/form/color_screen.dart';
import '../../../screens/advert/form/cuisine_screen.dart';
import '../../../screens/advert/form/date_construction_screen.dart';
import '../../../screens/advert/form/marque_screen.dart';
import '../../../screens/advert/form/model_screen.dart';
import '../../../screens/advert/form/nombre_piece_screen.dart';
import '../../../screens/advert/form/nombre_place_screen.dart';
import '../../../screens/advert/form/nombre_porte_screen.dart';
import '../../../screens/advert/form/transmission_screen.dart';
import '../../../screens/advert/form/type_carburant_screen.dart';
import '../../message/voidMessage.dart';

class CityFieldData extends StatelessWidget {
  const CityFieldData({Key? key, required this.controller}) : super(key: key);

  final AdvertCreateController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FormInputData(
            title: 'Choisir une ville',
            content: (controller.city.value.isEmpty) ?
            Text(
              'Choisir une ville',
              style: TextStyle(fontSize: 15.5, color: AppTheme.dark_grey.withOpacity(0.9), letterSpacing: 0.3),
            ):
            Text(
              controller.city.value,
              style: TextStyle(fontSize: 15.5, letterSpacing: 0.3,),
            ),
            icon: Icons.location_on,
            onTap: () {
              Get.to(() => CityScreen());
            },
            borderState: (controller.cityValidatorState.value == 'error'),
          ),
          (controller.cityValidatorState.value == 'error') ?
          Padding(
            padding: EdgeInsets.only(top: 6.0, left: 15.0),
            child: Text(
              'Veuillez choisir une ville.',
              style: TextStyle(
                  fontSize: 11.6,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.danger_color
              ),
            ),
          ) : SizedBox()
        ],
      )),
    );
  }
}

class ZoneFieldData extends StatelessWidget {
  const ZoneFieldData({Key? key, required this.controller}) : super(key: key);

  final AdvertCreateController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: Obx(() => FormInputData(
        title: 'Insérer une zone',
        content: (controller.zone.value.isEmpty) ?
        Text(
          'Insérer une zone',
          style: TextStyle(fontSize: 15.5, color: AppTheme.dark_grey.withOpacity(0.9), letterSpacing: 0.3),
        ):
        Text(
          controller.zone.value,
          style: TextStyle(fontSize: 15.5, letterSpacing: 0.3,),
        ),
        icon: Icons.location_on,
        onTap: () {
          (controller.city.isNotEmpty) ?
          Get.to(() => ZoneScreen(), arguments: {
            'name': controller.city.value,
          }) :
          showVoidMessage('Veuillez d\'abord choisir un ville');
        },
      )),
    );
  }
}

class TypeFielData extends StatelessWidget {
  const TypeFielData({Key? key, required this.controller}) : super(key: key);

  final AdvertCreateController controller;

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
                'Type d\'annonce',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.darkerText,
                  letterSpacing: 0.3,
                ),
              ),
            ),
            Row(
              children: <Widget>[
                FormRadioField(
                  title: 'J\'offre',
                  value: 'J\'offre',
                  data: controller.type.value,
                  callback: (String? value) {
                    controller.type.value = value!;
                  }
                ),
                SizedBox(width: 10.0),
                FormRadioField(
                  title: 'Je recherche',
                  value: 'Je recherche',
                  data: controller.type.value,
                  callback: (String? value) {
                    controller.type.value = value!;
                  }
                ),
              ],
            ),
            (controller.typeValidatorState.value == 'error') ?
            Padding(
              padding: EdgeInsets.only(top: 6.0, left: 10.0),
              child: Text(
                'Veuillez choisir un type d\'annonce.',
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

class TypeExtendFielData extends StatelessWidget {
  const TypeExtendFielData({Key? key, required this.controller}) : super(key: key);

  final AdvertCreateController controller;

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
                'Type d\'annonce',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.darkerText,
                  letterSpacing: 0.3,
                ),
              ),
            ),
            Row(
              children: <Widget>[
                FormRadioField(
                  title: 'J\'offre',
                  value: 'J\'offre',
                  data: controller.type.value,
                  callback: (String? value) {
                    controller.type.value = value!;
                  }
                ),
                SizedBox(width: 10.0),
                FormRadioField(
                  title: 'Je recherche',
                  value: 'Je recherche',
                  data: controller.type.value,
                  callback: (String? value) {
                    controller.type.value = value!;
                  }
                ),
                SizedBox(width: 10.0),
                FormRadioField(
                  title: 'Troc',
                  value: 'Troc',
                  data: controller.type.value,
                  callback: (String? value) {
                    controller.type.value = value!;
                  }
                ),
                SizedBox(width: 10.0),
                FormRadioField(
                  title: 'Don',
                  value: 'Don',
                  data: controller.type.value,
                  callback: (String? value) {
                    controller.type.value = value!;
                  }
                ),
              ],
            ),
            (controller.typeValidatorState.value == 'error') ?
            Padding(
              padding: EdgeInsets.only(top: 6.0, left: 10.0),
              child: Text(
                'Veuillez choisir un type d\'annonce.',
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

class TitleFieldData extends StatelessWidget {
  const TitleFieldData({Key? key, required this.controller}) : super(key: key);

  final AdvertCreateController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5.0, bottom: 5.0),
            child: Text(
              'Titre de l\'annonce',
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
              controller: controller.titleController,
              validator: AdvertValidator().title,
              keyboardType: TextInputType.text,
              prefix: Icon(Icons.table_chart_outlined, color: AppTheme.grey),
              hintText: 'Écrivez un titre pour l\'annonce',
              onChanged: (value) => null,
              onSaved: (value) => controller.titleController.text = value!,
            ),
          )
        ],
      ),
    );
  }
}


class DescriptionFielData extends StatelessWidget {
  const DescriptionFielData({Key? key, required this.controller}) : super(key: key);

  final AdvertCreateController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5.0, bottom: 5.0),
            child: Text(
              'Description de annonce',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: AppTheme.darkerText,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Container(
            child: FormDataTextarea(
              controller: controller.descriptionController,
              validator: AdvertValidator().description,
              maxLines: 8,
              hintText: 'Décrivez précisement votre bien, en indiquant son état, ses caractéristiques, ainsi tout aure information importante pour l\'acquéreur.',
              onChanged: (value) => null,
              onSaved: (value) => controller.descriptionController.text = value!,
            ),
          )
        ],
      ),
    );
  }
}

class TraitementFieldData extends StatelessWidget {
  const TraitementFieldData({Key? key, required this.controller}) : super(key: key);

  final AdvertCreateController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 4.0, bottom: 5.0),
              child: Text(
                'Traitement (facultatif)',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.darkerText,
                  letterSpacing: 0.3,
                ),
              ),
            ),
            Obx(() => Row(
              children: <Widget>[
                FormRadioField(
                  title: 'Livraison possible',
                  value: 'Livraison possible',
                  data: controller.traitement.value,
                  callback: (String? value) {
                    controller.traitement.value = value!;
                  }
                ),
                SizedBox(width: 10.0),
                FormRadioField(
                  title: 'Expédition possible',
                  value: 'Expédition possible',
                  data: controller.traitement.value,
                  callback: (String? value) {
                    controller.traitement.value = value!;
                  }
                ),
              ],
            )),
          ],
        )
    );
  }
}

class PriceFieldData extends StatelessWidget {
  const PriceFieldData({Key? key, required this.controller}) : super(key: key);

  final AdvertCreateController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5.0, bottom: 4.0),
            child: Text(
              'Prix',
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
              controller: controller.priceController,
              validator: AdvertValidator().notBlank,
              keyboardType: TextInputType.number,
              prefix: Icon(Icons.filter_alt, color: AppTheme.grey, size: 23.0),
              iconSuffix: Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Text(
                  'CFA',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.grey
                  ),
                ),
              ),
              hintText: 'Écriver le prix',
              onChanged: (value) => null,
              onSaved: (value) => controller.priceController.text = value!,
            ),
          ),
        ],
      ),
    );
  }
}

class MarqueFieldData extends StatelessWidget {
  const MarqueFieldData({Key? key, required this.controller}) : super(key: key);

  final AdvertCreateController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
      child: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FormInputData(
            title: AdvertTitleFieldState(controller: controller).marqueState() ?
            'Marque (facultatif)' : 'Marque',
            content: (controller.marque.value.isEmpty) ?
            Text(
              'Selectionner une marque',
              style: TextStyle(fontSize: 15.5, color: AppTheme.dark_grey.withOpacity(0.9), letterSpacing: 0.3),
            ):
            Text(
              controller.marque.value,
              style: TextStyle(fontSize: 15.5, letterSpacing: 0.3,),
            ),
            iconSuffix: FontAwesomeIcons.arrowAltCircleRight,
            onTap: () {
              Get.to(() => MarqueScreen());
            },
            borderState: (controller.marqueValidatorState.value == 'error'),
          ),
          (controller.marqueValidatorState.value == 'error') ?
          Padding(
            padding: EdgeInsets.only(top: 6.0, left: 15.0),
            child: Text(
              'Veuillez selectionner une marque.',
              style: TextStyle(
                fontSize: 11.6,
                fontWeight: FontWeight.w500,
                color: AppTheme.danger_color
              ),
            ),
          ) : SizedBox()
        ],
      )),
    );
  }
}


class ModelFieldData extends StatelessWidget {
  const ModelFieldData({Key? key, required this.controller}) : super(key: key);

  final AdvertCreateController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
      child: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FormInputData(
            title: 'Modèle',
            content: (controller.model.value.isEmpty) ?
            Text(
              'Selectionner un modèle',
              style: TextStyle(fontSize: 15.5, color: AppTheme.dark_grey.withOpacity(0.9), letterSpacing: 0.3),
            ):
            Text(
              controller.model.value,
              style: TextStyle(fontSize: 15.5, letterSpacing: 0.3,),
            ),
            iconSuffix: FontAwesomeIcons.arrowAltCircleRight,
            onTap: () {
              (controller.marque.isNotEmpty) ?
                Get.to(() => ModelScreen(), arguments: {
                  'marque': controller.marque.value,
                }) :
                showVoidMessage('Veuillez d\'abord selectionner une marque');
            },
            borderState: (controller.modelValidatorState.value == 'error'),
          ),
          (controller.modelValidatorState.value == 'error') ?
          Padding(
            padding: EdgeInsets.only(top: 6.0, left: 15.0),
            child: Text(
              'Veuillez selectionner un modèle.',
              style: TextStyle(
                fontSize: 11.6,
                fontWeight: FontWeight.w500,
                color: AppTheme.danger_color
              ),
            ),
          ) : SizedBox()
        ],
      )),
    );
  }
}

class AutoYearFieldData extends StatelessWidget {
  const AutoYearFieldData({Key? key, required this.controller}) : super(key: key);

  final AdvertCreateController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
      child: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FormInputData(
            title: AdvertTitleFieldState(controller: controller).autoYearState() ?
            'Année (facultatif)' : 'Année',
            content: (controller.autoYear.value.isEmpty) ?
            Text(
              'Selectionner une année',
              style: TextStyle(fontSize: 15.5, color: AppTheme.dark_grey.withOpacity(0.9), letterSpacing: 0.3),
            ):
            Text(
              controller.autoYear.value,
              style: TextStyle(fontSize: 15.5, letterSpacing: 0.3,),
            ),
            iconSuffix: FontAwesomeIcons.arrowAltCircleRight,
            onTap: () {
              Get.to(() => AutoYearScreen());
            },
            borderState: (controller.autoYearValidatorState.value == 'error'),
          ),
          (controller.autoYearValidatorState.value == 'error') ?
          Padding(
            padding: EdgeInsets.only(top: 6.0, left: 15.0),
            child: Text(
              'Veuillez selectionner une année.',
              style: TextStyle(
                fontSize: 11.6,
                fontWeight: FontWeight.w500,
                color: AppTheme.danger_color
              ),
            ),
          ) : SizedBox()
        ],
      )),
    );
  }
}


class AutoTypeFieldData extends StatelessWidget {
  const AutoTypeFieldData({Key? key, required this.controller}) : super(key: key);

  final AdvertCreateController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
      child: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FormInputData(
            title: 'Type de véhicule',
            content: (controller.autoType.value.isEmpty) ?
            Text(
              'Selectionner un type de véhicule',
              style: TextStyle(fontSize: 15.5, color: AppTheme.dark_grey.withOpacity(0.9), letterSpacing: 0.3),
            ):
            Text(
              controller.autoType.value,
              style: TextStyle(fontSize: 15.5, letterSpacing: 0.3,),
            ),
            iconSuffix: FontAwesomeIcons.arrowAltCircleRight,
            onTap: () {
              Get.to(() => AutoTypeScreen());
            },
            borderState: (controller.autoTypeValidatorState.value == 'error'),
          ),
          (controller.autoTypeValidatorState.value == 'error') ?
          Padding(
            padding: EdgeInsets.only(top: 6.0, left: 15.0),
            child: Text(
              'Veuillez selectionner un type de véhicule.',
              style: TextStyle(
                  fontSize: 11.6,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.danger_color
              ),
            ),
          ) : SizedBox()
        ],
      )),
    );
  }
}


class AutoStateFieldData extends StatelessWidget {
  const AutoStateFieldData({Key? key, required this.controller}) : super(key: key);

  final AdvertCreateController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
      child: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FormInputData(
            title: AdvertTitleFieldState(controller: controller).autoStateState() ?
            'Etat de véhicule (facultatif)' : 'Etat de véhicule',
            content: (controller.autoState.value.isEmpty) ?
            Text(
              'Selectionner un état de véhicule',
              style: TextStyle(fontSize: 15.5, color: AppTheme.dark_grey.withOpacity(0.9), letterSpacing: 0.3),
            ):
            Text(
              controller.autoState.value,
              style: TextStyle(fontSize: 15.5, letterSpacing: 0.3,),
            ),
            iconSuffix: FontAwesomeIcons.arrowAltCircleRight,
            onTap: () {
              Get.to(() => AutoStateScreen());
            },
            borderState: (controller.autoStateValidatorState.value == 'error'),
          ),
          (controller.autoStateValidatorState.value == 'error') ?
          Padding(
            padding: EdgeInsets.only(top: 6.0, left: 15.0),
            child: Text(
              'Veuillez selectionner un état de véhicule.',
              style: TextStyle(
                fontSize: 11.6,
                fontWeight: FontWeight.w500,
                color: AppTheme.danger_color
              ),
            ),
          ) : SizedBox()
        ],
      )),
    );
  }
}

class KiloFieldData extends StatelessWidget {
  const KiloFieldData({Key? key, required this.controller}) : super(key: key);

  final AdvertCreateController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5.0, bottom: 4.0),
            child: Text(
              AdvertTitleFieldState(controller: controller).kiloState() ? 'Kilométrage (facultatif)' : 'Kilométrage',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: AppTheme.darkerText,
                letterSpacing: 0.3
              ),
            ),
          ),
          Container(
            child: FormDataField(
              controller: controller.kiloController,
              validator: AdvertValidateFieldState(controller: controller).kiloState() ? AdvertValidator().notBlank : null,
              keyboardType: TextInputType.number,
              prefix: Icon(Icons.filter_alt, color: AppTheme.grey, size: 23.0),
              iconSuffix: Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Text(
                  'Km',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.grey
                  ),
                ),
              ),
              hintText: 'Écriver le kilométrage',
              onChanged: (value) => null,
              onSaved: (value) => controller.kiloController.text = value!,
            ),
          ),
        ],
      ),
    );
  }
}

class CylindreFieldData extends StatelessWidget {
  const CylindreFieldData({Key? key, required this.controller}) : super(key: key);

  final AdvertCreateController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5.0, bottom: 4.0),
            child: Text(
              'Cylindrée (facultatif)',
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
              controller: controller.cylindreController,
              keyboardType: TextInputType.number,
              prefix: Icon(Icons.filter_alt, color: AppTheme.grey, size: 23.0),
              iconSuffix: Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Text(
                  'Cm3',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.grey
                  ),
                ),
              ),
              hintText: 'Écriver le cylindrée',
              onChanged: (value) => null,
              onSaved: (value) => controller.cylindreController.text = value!,
            ),
          ),
        ],
      ),
    );
  }
}

class BoiteVitesseFieldData extends StatelessWidget {
  const BoiteVitesseFieldData({Key? key, required this.controller}) : super(key: key);

  final AdvertCreateController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
      child: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FormInputData(
            title: 'Boite à vitesse (facultatif)',
            content: (controller.boiteVitesse.value.isEmpty) ?
            Text(
              'Selectionner une boite à vitesse',
              style: TextStyle(fontSize: 15.5, color: AppTheme.dark_grey.withOpacity(0.9), letterSpacing: 0.3),
            ):
            Text(
              controller.boiteVitesse.value,
              style: TextStyle(fontSize: 15.5, letterSpacing: 0.3,),
            ),
            iconSuffix: FontAwesomeIcons.arrowAltCircleRight,
            onTap: () {
              Get.to(() => BoiteVitesseScreen());
            },
          )
        ],
      )),
    );
  }
}

class TransmissionFieldData extends StatelessWidget {
  const TransmissionFieldData({Key? key, required this.controller}) : super(key: key);

  final AdvertCreateController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
      child: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FormInputData(
            title: 'Transmission (facultatif)',
            content: (controller.transmission.value.isEmpty) ?
            Text(
              'Selectionner une transmission',
              style: TextStyle(fontSize: 15.5, color: AppTheme.dark_grey.withOpacity(0.9), letterSpacing: 0.3),
            ):
            Text(
              controller.transmission.value,
              style: TextStyle(fontSize: 15.5, letterSpacing: 0.3,),
            ),
            iconSuffix: FontAwesomeIcons.arrowAltCircleRight,
            onTap: () {
              Get.to(() => TransmissionScreen());
            },
          ),
        ],
      )),
    );
  }
}

class ColorFieldData extends StatelessWidget {
  const ColorFieldData({Key? key, required this.controller}) : super(key: key);

  final AdvertCreateController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
      child: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FormInputData(
            title: 'Couleur (facultatif)',
            content: (controller.autoColor.value.isEmpty) ?
            Text(
              'Selectionner une couleur',
              style: TextStyle(fontSize: 15.5, color: AppTheme.dark_grey.withOpacity(0.9), letterSpacing: 0.3),
            ):
            Text(
              controller.autoColor.value,
              style: TextStyle(fontSize: 15.5, letterSpacing: 0.3,),
            ),
            iconSuffix: FontAwesomeIcons.arrowAltCircleRight,
            onTap: () {
              Get.to(() => ColorScreen());
            },
          )
        ],
      )),
    );
  }
}

class TypeCarburantFieldData extends StatelessWidget {
  const TypeCarburantFieldData({Key? key, required this.controller}) : super(key: key);

  final AdvertCreateController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
      child: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FormInputData(
            title: 'Type de carburant (facultatif)',
            content: (controller.typeCarburant.value.isEmpty) ?
            Text(
              'Selectionner un type de carburant',
              style: TextStyle(fontSize: 15.5, color: AppTheme.dark_grey.withOpacity(0.9), letterSpacing: 0.3),
            ):
            Text(
              controller.typeCarburant.value,
              style: TextStyle(fontSize: 15.5, letterSpacing: 0.3,),
            ),
            iconSuffix: FontAwesomeIcons.arrowAltCircleRight,
            onTap: () {
              Get.to(() => TypeCarburantScreen());
            },
          )
        ],
      )),
    );
  }
}

class NombrePorteFieldData extends StatelessWidget {
  const NombrePorteFieldData({Key? key, required this.controller}) : super(key: key);

  final AdvertCreateController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
      child: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FormInputData(
            title: 'Nombre de portes (facultatif)',
            content: (controller.nombrePorte.value.isEmpty) ?
            Text(
              'Selectionner le nombre de portes',
              style: TextStyle(fontSize: 15.5, color: AppTheme.dark_grey.withOpacity(0.9), letterSpacing: 0.3),
            ):
            Text(
              controller.nombrePorte.value,
              style: TextStyle(fontSize: 15.5, letterSpacing: 0.3,),
            ),
            iconSuffix: FontAwesomeIcons.arrowAltCircleRight,
            onTap: () {
              Get.to(() => NombrePorteScreen());
            },
          )
        ],
      )),
    );
  }
}

class NombrePlaceFieldData extends StatelessWidget {
  const NombrePlaceFieldData({Key? key, required this.controller}) : super(key: key);

  final AdvertCreateController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
      child: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FormInputData(
            title: 'Nombre de places (facultatif)',
            content: (controller.nombrePlace.value.isEmpty) ?
            Text(
              'Selectionner le nombre de places',
              style: TextStyle(fontSize: 15.5, color: AppTheme.dark_grey.withOpacity(0.9), letterSpacing: 0.3),
            ):
            Text(
              controller.nombrePlace.value,
              style: TextStyle(fontSize: 15.5, letterSpacing: 0.3,),
            ),
            iconSuffix: FontAwesomeIcons.arrowAltCircleRight,
            onTap: () {
              Get.to(() => NombrePlaceScreen());
            },
          )
        ],
      )),
    );
  }
}

class AutreInformationFieldData extends StatelessWidget {
  const AutreInformationFieldData({
    Key? key,
    required this.controller,
    required this.data
  }) : super(key: key);

  final AdvertCreateController controller;
  final List data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5.0, bottom: 4.0),
            child: Text(
              'Autres informations (facultatif)',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: AppTheme.darkerText,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.zero,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Obx(() => SizedBox(
                  //height: 33.0,
                  child: CheckboxListTile(
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    title: Text(
                      data[index],
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.dark_grey,
                        letterSpacing: 0.3
                      ),
                    ),
                    value: controller.autreInformation.contains(data[index]),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.all(0),
                    checkColor: AppTheme.white,
                    activeColor: AppTheme.defaults,
                    onChanged: (bool? selected) {
                      controller.onAutreInformationSelected(selected, data[index]);
                    },
                  ),
                ));
              }
            ),
          )
        ],
      ),
    );
  }
}

class AutoSecurityFieldData extends StatelessWidget {
  const AutoSecurityFieldData({
    Key? key,
    required this.controller,
    required this.data
  }) : super(key: key);

  final AdvertCreateController controller;
  final List data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5.0, bottom: 4.0),
            child: Text(
              'Sécurité et confort (facultatif)',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: AppTheme.darkerText,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.zero,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Obx(() => SizedBox(
                    child: CheckboxListTile(
                      visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                      title: Text(
                        data[index],
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.dark_grey,
                          letterSpacing: 0.3
                        ),
                      ),
                      value: controller.autoSecurity.contains(data[index]),
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.all(0),
                      checkColor: AppTheme.white,
                      activeColor: AppTheme.defaults,
                      onChanged: (bool? selected) {
                        controller.onAutoSecuritySelected(selected, data[index]);
                      },
                    ),
                  ));
                }
            ),
          )
        ],
      ),
    );
  }
}

class InformationExtFieldData extends StatelessWidget {
  const InformationExtFieldData({
    Key? key,
    required this.controller,
    required this.data
  }) : super(key: key);

  final AdvertCreateController controller;
  final List data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5.0, bottom: 4.0),
            child: Text(
              'Elements extérieurs (facultatif)',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: AppTheme.darkerText,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.zero,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Obx(() => SizedBox(
                    child: CheckboxListTile(
                      visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                      title: Text(
                        data[index],
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.dark_grey,
                          letterSpacing: 0.3
                        ),
                      ),
                      value: controller.informationExt.contains(data[index]),
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.all(0),
                      checkColor: AppTheme.white,
                      activeColor: AppTheme.defaults,
                      onChanged: (bool? selected) {
                        controller.onInformationExtSelected(selected, data[index]);
                      },
                    ),
                  ));
                }
            ),
          )
        ],
      ),
    );
  }
}


class ModelTextFieldData extends StatelessWidget {
  const ModelTextFieldData({Key? key, required this.controller}) : super(key: key);

  final AdvertCreateController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5.0, bottom: 4.0),
            child: Text(
              'Modèle (facultatif)',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: AppTheme.darkerText,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Container(
            height: 45.0,
            child: FormDataField(
              controller: controller.modelController,
              keyboardType: TextInputType.text,
              prefix: Icon(Icons.filter_alt, color: AppTheme.grey, size: 23.0),
              hintText: 'Écriver le modèle',
              onChanged: (value) => null,
              onSaved: (value) => controller.modelController.text = value!,
            ),
          ),
        ],
      ),
    );
  }
}


class StateFielData extends StatelessWidget {
  const StateFielData({Key? key, required this.controller}) : super(key: key);

  final AdvertCreateController controller;

  @override
  Widget build(BuildContext context) {
    if (controller.state.value.isEmpty) controller.initState();

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 5.0, bottom: 5.0),
              child: Text(
                'État du produit',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.darkerText,
                  letterSpacing: 0.3,
                ),
              ),
            ),
            Row(
              children: <Widget>[
                FormRadioField(
                    title: 'Neuf',
                    value: 'Neuf',
                    data: controller.state.value,
                    callback: (String? value) {
                      controller.state.value = value!;
                    }
                ),
                SizedBox(width: 10.0),
                FormRadioField(
                    title: 'Quasi neuf',
                    value: 'Quasi neuf',
                    data: controller.state.value,
                    callback: (String? value) {
                      controller.state.value = value!;
                    }
                ),
                SizedBox(width: 10.0),
                FormRadioField(
                  title: 'Occasion',
                  value: 'Occasion',
                  data: controller.state.value,
                  callback: (String? value) {
                    controller.state.value = value!;
                  }
                ),
                SizedBox(width: 10.0),
                FormRadioField(
                  title: 'A rénover',
                  value: 'A rénover',
                  data: controller.state.value,
                  callback: (String? value) {
                    controller.state.value = value!;
                  }
                ),
              ],
            ),
            (controller.stateValidatorState.value == 'error') ?
            Padding(
              padding: EdgeInsets.only(top: 6.0, left: 10.0),
              child: Text(
                'Veuillez choisir un état de produit.',
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


class BrandFieldData extends StatelessWidget {
  const BrandFieldData({Key? key, required this.controller}) : super(key: key);

  final AdvertCreateController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
      child: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FormInputData(
            title: 'Marque',
            content: (controller.brand.value.isEmpty) ?
            Text(
              'Selectionner une marque',
              style: TextStyle(fontSize: 15.5, color: AppTheme.dark_grey.withOpacity(0.9), letterSpacing: 0.3),
            ):
            Text(
              controller.brand.value,
              style: TextStyle(fontSize: 15.5, letterSpacing: 0.3),
            ),
            iconSuffix: FontAwesomeIcons.arrowAltCircleRight,
            onTap: () {
              Get.to(() => BrandScreen());
            },
            borderState: (controller.brandValidatorState.value == 'error'),
          ),
          (controller.brandValidatorState.value == 'error') ?
          Padding(
            padding: EdgeInsets.only(top: 6.0, left: 15.0),
            child: Text(
              'Veuillez selectionner une marque.',
              style: TextStyle(
                fontSize: 11.6,
                fontWeight: FontWeight.w500,
                color: AppTheme.danger_color
              ),
            ),
          ) : SizedBox()
        ],
      )),
    );
  }
}

class SurfaceFieldData extends StatelessWidget {
  const SurfaceFieldData({Key? key, required this.controller}) : super(key: key);

  final AdvertCreateController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5.0, bottom: 4.0),
            child: Text(
              (controller.category.value.slug == 'terrain-1' ||
                  controller.category.value.slug == 'terrain') ? 'Superficie' : 'Surface',
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
              controller: controller.surfaceController,
              validator: AdvertValidateFieldState(controller: controller).surfaceState() ?
                  AdvertValidator().notBlank : null,
              keyboardType: TextInputType.number,
              prefix: Icon(Icons.filter_alt, color: AppTheme.grey, size: 23.0),
              iconSuffix: Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Text(
                  'm²',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.grey
                  ),
                ),
              ),
              hintText: (controller.category.value.slug == 'terrain-1' ||
                  controller.category.value.slug == 'terrain') ? 'Écriver la Superficie' : 'Écriver la surface',
              onChanged: (value) => null,
              onSaved: (value) => controller.surfaceController.text = value!,
            ),
          ),
        ],
      ),
    );
  }
}

class NombreChambreFieldData extends StatelessWidget {
  const NombreChambreFieldData({Key? key, required this.controller}) : super(key: key);

  final AdvertCreateController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5.0, bottom: 4.0),
            child: Text(
              AdvertTitleFieldState(controller: controller).nombreChambreState() ? 'Nombre de chambre(s) (facultatif)' : 'Nombre de chambre(s)',
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
              controller: controller.nombreChambreController,
              validator: AdvertValidateFieldState(controller: controller).nombreChambreState() ?
                    AdvertValidator().notBlank : null,
              keyboardType: TextInputType.number,
              prefix: Icon(Icons.filter_alt, color: AppTheme.grey, size: 23.0),
              hintText: 'Écriver le nombre de chambre',
              onChanged: (value) => null,
              onSaved: (value) => controller.nombreChambreController.text = value!,
            ),
          ),
        ],
      ),
    );
  }
}

class NombreSalleBainFieldData extends StatelessWidget {
  const NombreSalleBainFieldData({Key? key, required this.controller}) : super(key: key);

  final AdvertCreateController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5.0, bottom: 4.0),
            child: Text(
              AdvertTitleFieldState(controller: controller).nombreSalleState() ? 'Nombre de salle(s) de bain (facultatif)' : 'Nombre de salle(s) de bain',
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
              controller: controller.nombreSalleBainController,
              validator: AdvertValidateFieldState(controller: controller).nombreSalleState() ?
                  AdvertValidator().notBlank : null,
              keyboardType: TextInputType.number,
              prefix: Icon(Icons.filter_alt, color: AppTheme.grey, size: 23.0),
              hintText: 'Écriver le nombre de salle(s) de bain',
              onChanged: (value) => null,
              onSaved: (value) => controller.nombreSalleBainController.text = value!,
            ),
          ),
        ],
      ),
    );
  }
}

class NombrePieceFieldData extends StatelessWidget {
  const NombrePieceFieldData({Key? key, required this.controller}) : super(key: key);

  final AdvertCreateController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
      child: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FormInputData(
            title: AdvertTitleFieldState(controller: controller).nombrePieceState() ? 'Nombre de pièces (facultatif)' : 'Nombre de pièces',
            content: (controller.nombrePiece.value.isEmpty) ?
            Text(
              'Nombre de pièces',
              style: TextStyle(fontSize: 15.5, color: AppTheme.dark_grey.withOpacity(0.9), letterSpacing: 0.3),
            ):
            Text(
              controller.nombrePiece.value,
              style: TextStyle(fontSize: 15.5, letterSpacing: 0.3),
            ),
            iconSuffix: FontAwesomeIcons.arrowAltCircleRight,
            onTap: () {
              Get.to(() => NombrePieceScreen());
            },
            borderState: (controller.nombrePieceValidatorState.value == 'error'),
          ),
          (controller.nombrePieceValidatorState.value == 'error') ?
          Padding(
            padding: EdgeInsets.only(top: 6.0, left: 15.0),
            child: Text(
              'Veuillez selectionner le nombre de pièces.',
              style: TextStyle(
                  fontSize: 11.6,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.danger_color
              ),
            ),
          ) : SizedBox()
        ],
      )),
    );
  }
}

class ImmobilierStateFielData extends StatelessWidget {
  const ImmobilierStateFielData({Key? key, required this.controller}) : super(key: key);

  final AdvertCreateController controller;

  @override
  Widget build(BuildContext context) {

    if (controller.immobilierState.value.isEmpty) controller.initImmoState();

    return Padding(
        padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
        child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 5.0, bottom: 5.0),
              child: Text(
                AdvertTitleFieldState(controller: controller).immoStateState() ? 'État (facultatif)' : 'État',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.darkerText,
                  letterSpacing: 0.3,
                ),
              ),
            ),
            Row(
              children: <Widget>[
                FormRadioField(
                  title: 'Meuble',
                  value: 'Meuble',
                  data: controller.immobilierState.value,
                  callback: (String? value) {
                    controller.immobilierState.value = value!;
                  }
                ),
                SizedBox(width: 10.0),
                FormRadioField(
                  title: 'Vide',
                  value: 'Vide',
                  data: controller.immobilierState.value,
                  callback: (String? value) {
                    controller.immobilierState.value = value!;
                  }
                ),
              ],
            ),
            (controller.immobilierStateValidatorState.value == 'error') ?
            Padding(
              padding: EdgeInsets.only(top: 6.0, left: 10.0),
              child: Text(
                'Veuillez choisir un état.',
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

class SurfaceBalconFieldData extends StatelessWidget {
  const SurfaceBalconFieldData({Key? key, required this.controller}) : super(key: key);

  final AdvertCreateController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5.0, bottom: 4.0),
            child: Text(
              'Surface du balcon (facultatif)',
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
              controller: controller.surfaceBalconController,
              validator: null,
              keyboardType: TextInputType.number,
              prefix: Icon(Icons.filter_alt, color: AppTheme.grey, size: 23.0),
              iconSuffix: Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Text(
                  'm²',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.grey
                  ),
                ),
              ),
              hintText: 'Écriver la surface du balcon',
              onChanged: (value) => null,
              onSaved: (value) => controller.surfaceBalconController.text = value!,
            ),
          ),
        ],
      ),
    );
  }
}

class NombrePlacardFieldData extends StatelessWidget {
  const NombrePlacardFieldData({Key? key, required this.controller}) : super(key: key);

  final AdvertCreateController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5.0, bottom: 4.0),
            child: Text(
              'Nombre de placard(s) (facultatif)',
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
              controller: controller.nombrePlacardController,
              validator: null,
              keyboardType: TextInputType.number,
              prefix: Icon(Icons.filter_alt, color: AppTheme.grey, size: 23.0),
              hintText: 'Écriver le nombre de placard(s)',
              onChanged: (value) => null,
              onSaved: (value) => controller.nombrePlacardController.text = value!,
            ),
          ),
        ],
      ),
    );
  }
}

class DateConstructionFieldData extends StatelessWidget {
  const DateConstructionFieldData({Key? key, required this.controller}) : super(key: key);

  final AdvertCreateController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
      child: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FormInputData(
            title: 'Date de construction (facultatif)',
            content: (controller.dateConstruction.value.isEmpty) ?
            Text(
              'Selectionner la date de construction',
              style: TextStyle(fontSize: 15.5, color: AppTheme.dark_grey.withOpacity(0.9), letterSpacing: 0.3),
            ):
            Text(
              controller.dateConstruction.value,
              style: TextStyle(fontSize: 15.5, letterSpacing: 0.3,),
            ),
            iconSuffix: FontAwesomeIcons.arrowAltCircleRight,
            onTap: () {
              Get.to(() => DateConstructionScreen());
            },
          )
        ],
      )),
    );
  }
}

class CuisineFieldData extends StatelessWidget {
  const CuisineFieldData({Key? key, required this.controller}) : super(key: key);

  final AdvertCreateController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
      child: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FormInputData(
            title: 'Cuisine (facultatif)',
            content: (controller.cuisine.value.isEmpty) ?
            Text(
              'Selectionner la cuisine',
              style: TextStyle(fontSize: 15.5, color: AppTheme.dark_grey.withOpacity(0.9), letterSpacing: 0.3),
            ):
            Text(
              controller.cuisine.value,
              style: TextStyle(fontSize: 15.5, letterSpacing: 0.3,),
            ),
            iconSuffix: FontAwesomeIcons.arrowAltCircleRight,
            onTap: () {
              Get.to(() => CuisineScreen());
            },
          )
        ],
      )),
    );
  }
}


class StandingFielData extends StatelessWidget {
  const StandingFielData({Key? key, required this.controller}) : super(key: key);

  final AdvertCreateController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
        child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 5.0, bottom: 5.0),
              child: Text(
                'Standing (facultatif)',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.darkerText,
                  letterSpacing: 0.3,
                ),
              ),
            ),
            Row(
              children: <Widget>[
                FormRadioField(
                  title: 'Très bon',
                  value: 'Très bon',
                  data: controller.standing.value,
                  callback: (String? value) {
                    controller.standing.value = value!;
                  }
                ),
                SizedBox(width: 10.0),
                FormRadioField(
                  title: 'Bon',
                  value: 'Bon',
                  data: controller.standing.value,
                  callback: (String? value) {
                    controller.standing.value = value!;
                  }
                ),
                SizedBox(width: 10.0),
                FormRadioField(
                  title: 'Moyen',
                  value: 'Moyen',
                  data: controller.standing.value,
                  callback: (String? value) {
                    controller.standing.value = value!;
                  }
                ),
              ],
            ),
          ],
        ))
    );
  }
}


class SituationFielData extends StatelessWidget {
  const SituationFielData({Key? key, required this.controller}) : super(key: key);

  final AdvertCreateController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
        child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 5.0, bottom: 5.0),
              child: Text(
                'Situation (facultatif)',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.darkerText,
                  letterSpacing: 0.3,
                ),
              ),
            ),
            Row(
              children: <Widget>[
                FormRadioField(
                  title: 'Rez-de-chaussée',
                  value: 'Rez-de-chaussée',
                  data: controller.situation.value,
                  callback: (String? value) {
                    controller.situation.value = value!;
                  }
                ),
                SizedBox(width: 10.0),
                FormRadioField(
                  title: 'Etage',
                  value: 'Etage',
                  data: controller.situation.value,
                  callback: (String? value) {
                    controller.situation.value = value!;
                  }
                ),
              ],
            )
          ],
        ))
    );
  }
}


class SalleMangerFielData extends StatelessWidget {
  const SalleMangerFielData({Key? key, required this.controller}) : super(key: key);

  final AdvertCreateController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
        child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 5.0, bottom: 5.0),
              child: Text(
                'Salle à manger (facultatif)',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.darkerText,
                  letterSpacing: 0.3,
                ),
              ),
            ),
            Row(
              children: <Widget>[
                FormRadioField(
                  title: 'Oui',
                  value: 'Oui',
                  data: controller.salleManger.value,
                  callback: (String? value) {
                    controller.salleManger.value = value!;
                  }
                ),
                SizedBox(width: 10.0),
                FormRadioField(
                  title: 'Non',
                  value: 'Non',
                  data: controller.salleManger.value,
                  callback: (String? value) {
                    controller.salleManger.value = value!;
                  }
                ),
              ],
            )
          ],
        ))
    );
  }
}

class StateGeneraleFielData extends StatelessWidget {
  const StateGeneraleFielData({Key? key, required this.controller}) : super(key: key);

  final AdvertCreateController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
        child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 5.0, bottom: 5.0),
              child: Text(
                'Etat général (facultatif)',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.darkerText,
                  letterSpacing: 0.3,
                ),
              ),
            ),
            Row(
              children: <Widget>[
                FormRadioField(
                  title: 'Très bon',
                  value: 'Très bon',
                  data: controller.stateGenerale.value,
                  callback: (String? value) {
                    controller.stateGenerale.value = value!;
                  }
                ),
                SizedBox(width: 10.0),
                FormRadioField(
                  title: 'Bon',
                  value: 'Bon',
                  data: controller.stateGenerale.value,
                  callback: (String? value) {
                    controller.stateGenerale.value = value!;
                  }
                ),
                SizedBox(width: 10.0),
                FormRadioField(
                  title: 'Moyen',
                  value: 'Moyen',
                  data: controller.stateGenerale.value,
                  callback: (String? value) {
                    controller.stateGenerale.value = value!;
                  }
                ),
              ],
            )
          ],
        ))
    );
  }
}

class ProximiteFieldData extends StatelessWidget {
  const ProximiteFieldData({
    Key? key,
    required this.controller,
    required this.data
  }) : super(key: key);

  final AdvertCreateController controller;
  final List data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5.0, bottom: 4.0),
            child: Text(
              'Proximité (facultatif)',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: AppTheme.darkerText,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.zero,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Obx(() => SizedBox(
                    child: CheckboxListTile(
                      visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                      title: Text(
                        data[index],
                        style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.dark_grey,
                            letterSpacing: 0.3
                        ),
                      ),
                      value: controller.proximite.contains(data[index]),
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.all(0),
                      checkColor: AppTheme.white,
                      activeColor: AppTheme.defaults,
                      onChanged: (bool? selected) {
                        controller.onProximiteSelected(selected, data[index]);
                      },
                    ),
                  ));
                }
            ),
          )
        ],
      ),
    );
  }
}

class ServiceInclusFieldData extends StatelessWidget {
  const ServiceInclusFieldData({
    Key? key,
    required this.controller,
    required this.data
  }) : super(key: key);

  final AdvertCreateController controller;
  final List data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5.0, bottom: 4.0),
            child: Text(
              'Services inclus (facultatif)',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: AppTheme.darkerText,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.zero,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Obx(() => SizedBox(
                    child: CheckboxListTile(
                      visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                      title: Text(
                        data[index],
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.dark_grey,
                          letterSpacing: 0.3
                        ),
                      ),
                      value: controller.serviceInclus.contains(data[index]),
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.all(0),
                      checkColor: AppTheme.white,
                      activeColor: AppTheme.defaults,
                      onChanged: (bool? selected) {
                        controller.onServiceInclusSelected(selected, data[index]);
                      },
                    ),
                  ));
                }
            ),
          )
        ],
      ),
    );
  }
}

class TypeSolFieldData extends StatelessWidget {
  const TypeSolFieldData({
    Key? key,
    required this.controller,
    required this.data
  }) : super(key: key);

  final AdvertCreateController controller;
  final List data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5.0, bottom: 4.0),
            child: Text(
              'Type de sol (facultatif)',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: AppTheme.darkerText,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.zero,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Obx(() => SizedBox(
                    child: CheckboxListTile(
                      visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                      title: Text(
                        data[index],
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.dark_grey,
                          letterSpacing: 0.3
                        ),
                      ),
                      value: controller.typeSol.contains(data[index]),
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.all(0),
                      checkColor: AppTheme.white,
                      activeColor: AppTheme.defaults,
                      onChanged: (bool? selected) {
                        controller.onTypeSolSelected(selected, data[index]);
                      },
                    ),
                  ));
                }
            ),
          )
        ],
      ),
    );
  }
}

class InteriorFieldData extends StatelessWidget {
  const InteriorFieldData({
    Key? key,
    required this.controller,
    required this.data
  }) : super(key: key);

  final AdvertCreateController controller;
  final List data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5.0, bottom: 4.0),
            child: Text(
              'Intérieur (facultatif)',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: AppTheme.darkerText,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.zero,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Obx(() => SizedBox(
                    child: CheckboxListTile(
                      visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                      title: Text(
                        data[index],
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.dark_grey,
                          letterSpacing: 0.3
                        ),
                      ),
                      value: controller.interior.contains(data[index]),
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.all(0),
                      checkColor: AppTheme.white,
                      activeColor: AppTheme.defaults,
                      onChanged: (bool? selected) {
                        controller.onInteriorSelected(selected, data[index]);
                      },
                    ),
                  ));
                }
            ),
          )
        ],
      ),
    );
  }
}

class ExteriorFieldData extends StatelessWidget {
  const ExteriorFieldData({
    Key? key,
    required this.controller,
    required this.data
  }) : super(key: key);

  final AdvertCreateController controller;
  final List data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5.0, bottom: 4.0),
            child: Text(
              'Caractéristiques extérieures (facultatif)',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: AppTheme.darkerText,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.zero,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Obx(() => SizedBox(
                    child: CheckboxListTile(
                      visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                      title: Text(
                        data[index],
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.dark_grey,
                          letterSpacing: 0.3
                        ),
                      ),
                      value: controller.exterior.contains(data[index]),
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.all(0),
                      checkColor: AppTheme.white,
                      activeColor: AppTheme.defaults,
                      onChanged: (bool? selected) {
                        controller.onExteriorSelected(selected, data[index]);
                      },
                    ),
                  ));
                }
            ),
          )
        ],
      ),
    );
  }
}

class AccesFieldData extends StatelessWidget {
  const AccesFieldData({
    Key? key,
    required this.controller,
    required this.data
  }) : super(key: key);

  final AdvertCreateController controller;
  final List data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5.0, bottom: 4.0),
            child: Text(
              'Accès (facultatif)',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: AppTheme.darkerText,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.zero,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Obx(() => SizedBox(
                    child: CheckboxListTile(
                      visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                      title: Text(
                        data[index],
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.dark_grey,
                          letterSpacing: 0.3
                        ),
                      ),
                      value: controller.access.contains(data[index]),
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.all(0),
                      checkColor: AppTheme.white,
                      activeColor: AppTheme.defaults,
                      onChanged: (bool? selected) {
                        controller.onAccessSelected(selected, data[index]);
                      },
                    ),
                  ));
                }
            ),
          )
        ],
      ),
    );
  }
}

class FacadeFieldData extends StatelessWidget {
  const FacadeFieldData({
    Key? key,
    required this.controller,
    required this.data
  }) : super(key: key);

  final AdvertCreateController controller;
  final List data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5.0, bottom: 4.0),
            child: Text(
              'Façade (facultatif)',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: AppTheme.darkerText,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.zero,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Obx(() => SizedBox(
                    child: CheckboxListTile(
                      visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                      title: Text(
                        data[index],
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.dark_grey,
                          letterSpacing: 0.3
                        ),
                      ),
                      value: controller.facade.contains(data[index]),
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.all(0),
                      checkColor: AppTheme.white,
                      activeColor: AppTheme.defaults,
                      onChanged: (bool? selected) {
                        controller.onFacadeSelected(selected, data[index]);
                      },
                    ),
                  ));
                }
            ),
          )
        ],
      ),
    );
  }
}

class ToitureFieldData extends StatelessWidget {
  const ToitureFieldData({
    Key? key,
    required this.controller,
    required this.data
  }) : super(key: key);

  final AdvertCreateController controller;
  final List data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5.0, bottom: 4.0),
            child: Text(
              'Toiture (facultatif)',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: AppTheme.darkerText,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.zero,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Obx(() => SizedBox(
                    child: CheckboxListTile(
                      visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                      title: Text(
                        data[index],
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.dark_grey,
                          letterSpacing: 0.3
                        ),
                      ),
                      value: controller.toiture.contains(data[index]),
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.all(0),
                      checkColor: AppTheme.white,
                      activeColor: AppTheme.defaults,
                      onChanged: (bool? selected) {
                        controller.onToitureSelected(selected, data[index]);
                      },
                    ),
                  ));
                }
            ),
          )
        ],
      ),
    );
  }
}








