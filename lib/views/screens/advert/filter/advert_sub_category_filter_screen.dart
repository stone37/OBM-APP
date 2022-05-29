import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:obm_market/constants/app_theme.dart';
import 'package:obm_market/views/common/btn_bulk.dart';
import 'package:obm_market/views/screens/advert/form/marque_screen.dart';
import 'package:obm_market/views/screens/advert/index/advert_sub_category_screen.dart';
import '../../../../modules/advert/controllers/advert_sub_category_controller.dart';
import '../../../common/form_advert_data.dart';
import '../../../widgets/message/voidMessage.dart';
import '../form/auto_year_screen.dart';
import '../form/brand_screen.dart';
import '../form/city_screen.dart';
import '../form/model_screen.dart';
import '../form/nombre_piece_screen.dart';
import '../form/type_carburant_screen.dart';
import '../form/zone_screen.dart';

class AdvertSubCategoryFilterScreen extends StatelessWidget {

  final GlobalKey<FormState> _formKeys = GlobalKey<FormState>();
  final AdvertSubCategoryController controller = Get.find();
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {

    return
      Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppTheme.primary,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light,
          ),
          titleSpacing: 0.0,
          elevation: 3.0,
          backgroundColor: AppTheme.primary,
          centerTitle: true,
          title: Text(
            'Filter',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            splashRadius: 20.0,
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
                  child: Form(
                    key: _formKeys,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(height: 15.0),
                        (box.read('category_parent') == 'acheter-et-vendre') ?
                        TypeExtendFiel(controller: controller) : TypeFiel(controller: controller),
                        SizedBox(height: 15.0),
                        // Auto
                        if (controller.category.value.slug == 'voiture-doccasion' || controller.category.value.slug == 'location-de-voiture' ||
                            controller.category.value.slug == 'motocross' || controller.category.value.slug == 'scooters-et-minimotos' ||
                            controller.category.value.slug == 'motos-sport' || controller.category.value.slug == 'routieres' ||
                            controller.category.value.slug == 'autres-motos' || controller.category.value.slug == 'pieces-de-carrosserie' ||
                            controller.category.value.slug == 'transmission-et-train-roulant' || controller.category.value.slug == 'pieces-et-accessoires-pour-motos' ||
                            controller.category.value.slug == 'moteur-pieces-de-moteurs' || controller.category.value.slug == 'vedettes-et-bateaux-a-moteur' ||
                            controller.category.value.slug == 'jet-ski-scooter-des-mers')
                          MarqueField(controller: controller),

                        if (controller.category.value.slug == 'voiture-doccasion' || controller.category.value.slug == 'location-de-voiture')
                          ModelField(controller: controller),

                        if (controller.category.value.slug == 'voiture-doccasion' || controller.category.value.slug == 'location-de-voiture' ||
                            controller.category.value.slug == 'vedettes-et-bateaux-a-moteur' || controller.category.value.slug == 'scooters-et-minimotos' ||
                            controller.category.value.slug == 'motocross' || controller.category.value.slug == 'routieres' ||
                            controller.category.value.slug == 'location-de-voiture' || controller.category.value.slug == 'jet-ski-scooter-des-mers' ||
                            controller.category.value.slug == 'autres-motos')
                          TypeCarburantField(controller: controller),

                        if (controller.category.value.slug == 'voiture-doccasion' ||
                            controller.category.value.slug == 'motos-sport' ||
                            controller.category.value.slug == 'camions-lourd' ||
                            controller.category.value.slug == 'scooters-et-minimotos' ||
                            controller.category.value.slug == 'motocross' ||
                            controller.category.value.slug == 'routieres' ||
                            controller.category.value.slug == 'autres-motos')
                          KiloField(controller: controller),

                        if (controller.category.value.slug == 'voiture-doccasion' || controller.category.value.slug == 'location-de-voiture' ||
                            controller.category.value.slug == 'motocross' || controller.category.value.slug == 'scooters-et-minimotos' ||
                            controller.category.value.slug == 'motos-sport' || controller.category.value.slug == 'routieres' ||
                            controller.category.value.slug == 'autres-motos' || controller.category.value.slug == 'vedettes-et-bateaux-a-moteur' ||
                            controller.category.value.slug == 'jet-ski-scooter-des-mers' || controller.category.value.slug == 'equipement-agricole' ||
                            controller.category.value.slug == 'camions-lourd')
                          AutoYearField(controller: controller),

                        // Immobilier
                        if (controller.category.value.slug == 'appartement-1' || controller.category.value.slug == 'appartement' ||
                            controller.category.value.slug == 'autre-1' || controller.category.value.slug == 'autre' ||
                            controller.category.value.slug == 'chambre' || controller.category.value.slug == 'colocation' ||
                            controller.category.value.slug == 'duplex-triplex-1' || controller.category.value.slug == 'duplex-triplex' ||
                            controller.category.value.slug == 'espaces-commerciaux-et-bureaux-1' || controller.category.value.slug == 'espaces-commerciaux-et-bureaux' ||
                            controller.category.value.slug == 'maison-1' || controller.category.value.slug == 'maison' ||
                            controller.category.value.slug == 'parking-garage' || controller.category.value.slug == 'studio-1' ||
                            controller.category.value.slug == 'studio' || controller.category.value.slug == 'studio-americain-1' ||
                            controller.category.value.slug == 'studio-americain' || controller.category.value.slug == 'terrain-1' ||
                            controller.category.value.slug == 'terrain' || controller.category.value.slug == 'villa-1' ||
                            controller.category.value.slug == 'villa')
                          SurfaceField(controller: controller),

                        if (controller.category.value.slug == 'appartement-1' || controller.category.value.slug == 'appartement' ||
                            controller.category.value.slug == 'chambre' || controller.category.value.slug == 'colocation' ||
                            controller.category.value.slug == 'duplex-triplex-1' || controller.category.value.slug == 'duplex-triplex' ||
                            controller.category.value.slug == 'espaces-commerciaux-et-bureaux-1' || controller.category.value.slug == 'espaces-commerciaux-et-bureaux' ||
                            controller.category.value.slug == 'maison-1' || controller.category.value.slug == 'maison' ||
                            controller.category.value.slug == 'studio-1' || controller.category.value.slug == 'studio' ||
                            controller.category.value.slug == 'studio-americain-1' || controller.category.value.slug == 'studio-americain' ||
                            controller.category.value.slug == 'villa-1' || controller.category.value.slug == 'villa' ||
                            controller.category.value.slug == 'parking-garage' || controller.category.value.slug == 'autre' ||
                            controller.category.value.slug == 'autre-1' )
                          ImmoStateFiel(controller: controller),

                        if (controller.category.value.slug == 'appartement-1' || controller.category.value.slug == 'appartement' ||
                            controller.category.value.slug == 'colocation' || controller.category.value.slug == 'duplex-triplex-1' ||
                            controller.category.value.slug == 'duplex-triplex' || controller.category.value.slug == 'maison-1' ||
                            controller.category.value.slug == 'maison' || controller.category.value.slug == 'villa-1' ||
                            controller.category.value.slug == 'villa')
                          NombrePieceField(controller: controller),

                        if (controller.category.value.slug == 'appartement-1' || controller.category.value.slug == 'appartement' ||
                            controller.category.value.slug == 'duplex-triplex-1' || controller.category.value.slug == 'duplex-triplex' ||
                            controller.category.value.slug == 'maison-1' || controller.category.value.slug == 'maison' ||
                            controller.category.value.slug == 'colocation' || controller.category.value.slug == 'villa-1' ||
                            controller.category.value.slug == 'villa')
                          NbrChambreAndNbrSalleBainField(controller: controller),

                        // Acheter et vendre
                        if (box.read('category_parent') == 'acheter-et-vendre')
                          StateFiel(controller: controller),

                        if (controller.category.value.slug == 'telephones-portables' ||
                            controller.category.value.slug == 'ipad-et-tablettes' ||
                            controller.category.value.slug == 'ordinateurs-de-bureau' ||
                            controller.category.value.slug == 'portables')
                          BrandField(controller: controller),

                        BudgetFieldData(controller: controller),
                        SizedBox(height: 15.0),
                        LocationField(controller: controller),
                        SizedBox(height: 15.0),
                      ],
                    ),
                  )
                ),
              ),
              const Divider(height: 1),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width*0.42,
                      child: PageButton(
                        text: 'Réinitialiser',
                        backgroundColor: AppTheme.white,
                        borderColor: AppTheme.defaults,
                        textColor: AppTheme.defaults,
                        callback: () {
                          controller.clear();

                          Get.off(() => AdvertSubCategoryScreen());
                        },
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*0.42,
                      child: PageButton(
                        text: 'Mettre à jour',
                        backgroundColor: AppTheme.primary,
                        borderColor: AppTheme.primary,
                        textColor: AppTheme.white,
                        callback: () {
                          Map<String, dynamic> data = {
                            'type': controller.type.value,
                            'priceMin': controller.priceMinController.text,
                            'priceMax': controller.priceMaxController.text,
                            'city': controller.city.value,
                            'zone': controller.zone.value,
                            'marque': controller.marque.value,
                            'model': controller.model.value,
                            'typeCarburant': controller.typeCarburant.value,
                            'kiloMin': controller.kiloMinController.text,
                            'kiloMax': controller.kiloMaxController.text,
                            'autoYearMin': controller.autoYearMin.value,
                            'autoYearMax': controller.autoYearMax.value,
                            'surfaceMin': controller.surfaceMinController.text,
                            'surfaceMax': controller.surfaceMaxController.text,
                            'immoState': controller.immobilierState.value,
                            'nombrePiece': controller.nombrePiece.value,
                            'nombreChambre': controller.nombreChambreController.text,
                            'nombreSalleBain': controller.nombreSalleBainController.text,
                            'brand': controller.brand.value,
                            'state': controller.stateD.value
                          };

                          controller.filter.addAll(data);

                          Get.back();
                        },
                      ),
                    ),
                  ],
                )
              )
            ],
          ),
        )
    );
  }
}

class TypeFiel extends StatelessWidget {
  const TypeFiel({Key? key, required this.controller}) : super(key: key);

  final AdvertSubCategoryController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 2.0, bottom: 5.0),
            child: Text(
              'Type d\'annonce',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                color: AppTheme.darkerText,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Row(
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                  splashColor: AppTheme.nearlyBlue.withOpacity(0.2),
                  onTap: () {
                    controller.typeOffertState.value = true;
                    controller.typeSearchState.value = false;

                    controller.type.value = controller.typeList[0];
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      color: (controller.typeOffertState.value) ? AppTheme.amber_dark : AppTheme.amber,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        bottomLeft:  Radius.circular(20.0),
                      ),
                      boxShadow: <BoxShadow>[
                        (controller.typeOffertState.value) ?
                        BoxShadow(color: AppTheme.grey.withOpacity(0.4), offset: const Offset(5, 5), blurRadius: 5) :
                        BoxShadow(color: AppTheme.grey.withOpacity(0.4), offset: const Offset(1.1, 1.1), blurRadius: 3.75),
                      ],
                    ),
                    child: Text(
                      'offre',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.white,
                        letterSpacing: 0.3
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 0.5),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    controller.typeOffertState.value = false;
                    controller.typeSearchState.value = true;

                    controller.type.value = controller.typeList[1];
                  },
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                  splashColor: AppTheme.nearlyBlue.withOpacity(0.2),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      color: (controller.typeSearchState.value) ? AppTheme.amber_dark : AppTheme.amber,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        bottomRight:  Radius.circular(20.0),
                      ),
                      boxShadow: <BoxShadow>[
                        (controller.typeSearchState.value) ?
                        BoxShadow(color: AppTheme.grey.withOpacity(0.4), offset: const Offset(5, 5), blurRadius: 5) :
                        BoxShadow(color: AppTheme.grey.withOpacity(0.4), offset: const Offset(1.1, 1.1), blurRadius: 3.75),
                      ],
                    ),
                    child: Text(
                      'Recherche',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.white,
                        letterSpacing: 0.3
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10.0),
        ],
      ))

    );
  }
}

class TypeExtendFiel extends StatelessWidget {
  const TypeExtendFiel({Key? key, required this.controller}) : super(key: key);

  final AdvertSubCategoryController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 2.0, bottom: 5.0),
              child: Text(
                'Type d\'annonce',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.darkerText,
                  letterSpacing: 0.3,
                ),
              ),
            ),
            Row(
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                    splashColor: AppTheme.nearlyBlue.withOpacity(0.2),
                    onTap: () {
                      controller.typeOffertState.value = true;
                      controller.typeSearchState.value = false;
                      controller.typeTrocState.value = false;
                      controller.typeDonState.value = false;

                      controller.type.value = controller.typeList[0];
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        color: (controller.typeOffertState.value) ? AppTheme.amber_dark : AppTheme.amber,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          bottomLeft:  Radius.circular(20.0),
                        ),
                        boxShadow: <BoxShadow>[
                          (controller.typeOffertState.value) ?
                          BoxShadow(color: AppTheme.grey.withOpacity(0.4), offset: const Offset(5, 5), blurRadius: 5) :
                          BoxShadow(color: AppTheme.grey.withOpacity(0.4), offset: const Offset(1.1, 1.1), blurRadius: 3.75),
                        ],
                      ),
                      child: Text(
                        'offre',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.white,
                          letterSpacing: 0.3
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 0.5),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      controller.typeOffertState.value = false;
                      controller.typeSearchState.value = true;
                      controller.typeTrocState.value = false;
                      controller.typeDonState.value = false;

                      controller.type.value = controller.typeList[1];
                    },
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                    splashColor: AppTheme.nearlyBlue.withOpacity(0.2),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        color: (controller.typeSearchState.value) ? AppTheme.amber_dark : AppTheme.amber,
                        boxShadow: <BoxShadow>[
                          (controller.typeSearchState.value) ?
                          BoxShadow(color: AppTheme.grey.withOpacity(0.4), offset: const Offset(5, 5), blurRadius: 5) :
                          BoxShadow(color: AppTheme.grey.withOpacity(0.4), offset: const Offset(1.1, 1.1), blurRadius: 3.75),
                        ],
                      ),
                      child: Text(
                        'Recherche',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.white,
                          letterSpacing: 0.3
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 0.5),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      controller.typeOffertState.value = false;
                      controller.typeSearchState.value = false;
                      controller.typeTrocState.value = true;
                      controller.typeDonState.value = false;

                      controller.type.value = controller.typeList[2];
                    },
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                    splashColor: AppTheme.nearlyBlue.withOpacity(0.2),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        color: (controller.typeTrocState.value) ? AppTheme.amber_dark : AppTheme.amber,
                        boxShadow: <BoxShadow>[
                          (controller.typeTrocState.value) ?
                          BoxShadow(color: AppTheme.grey.withOpacity(0.4), offset: const Offset(5, 5), blurRadius: 5) :
                          BoxShadow(color: AppTheme.grey.withOpacity(0.4), offset: const Offset(1.1, 1.1), blurRadius: 3.75),
                        ],
                      ),
                      child: Text(
                        'Troc',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.white,
                          letterSpacing: 0.3
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 0.5),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      controller.typeOffertState.value = false;
                      controller.typeSearchState.value = false;
                      controller.typeTrocState.value = false;
                      controller.typeDonState.value = true;

                      controller.type.value = controller.typeList[3];
                    },
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                    splashColor: AppTheme.nearlyBlue.withOpacity(0.2),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        color: (controller.typeDonState.value) ? AppTheme.amber_dark : AppTheme.amber,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.0),
                          bottomRight:  Radius.circular(20.0),
                        ),
                        boxShadow: <BoxShadow>[
                          (controller.typeDonState.value) ?
                          BoxShadow(color: AppTheme.grey.withOpacity(0.4), offset: const Offset(5, 5), blurRadius: 5) :
                          BoxShadow(color: AppTheme.grey.withOpacity(0.4), offset: const Offset(1.1, 1.1), blurRadius: 3.75),
                        ],
                      ),
                      child: Text(
                        'Don',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.white,
                          letterSpacing: 0.3
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 10.0),
          ],
        ))

    );
  }
}

class BudgetFieldData extends StatelessWidget {
  const BudgetFieldData({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final AdvertSubCategoryController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5.0, bottom: 7.0),
            child: Text(
              'Budget',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                color: AppTheme.darkerText,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5.0, bottom: 1.0),
                    child: Text(
                      'Min',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.darkerText,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.43,
                    child: FormDataField(
                      controller: controller.priceMinController,
                      validator: null,
                     keyboardType: TextInputType.number,
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
                      hintText: 'De',
                      onChanged: (value) => null,
                      onSaved: (value) => controller.priceMinController.text = value!,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 6.0, right: 6.0, top: 12.0),
                child: Icon(FontAwesomeIcons.minus, size: 12.0, color: AppTheme.grey),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5.0, bottom: 1.0),
                    child: Text(
                      'Max',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.darkerText,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.43,
                    child: FormDataField(
                      controller: controller.priceMaxController,
                      validator: null,
                      keyboardType: TextInputType.number,
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
                      hintText: 'à',
                      onChanged: (value) => null,
                      onSaved: (value) => controller.priceMaxController.text = value!,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class LocationField extends StatelessWidget {
  const LocationField({Key? key, required this.controller}) : super(key: key);

  final AdvertSubCategoryController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: Obx(() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5.0, bottom: 7.0),
            child: Text(
              'Lieu',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                color: AppTheme.darkerText,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Container(
            child: FormFilterInputData(
              title: 'Ville',
              content: (controller.city.value.isEmpty) ?
              Text(
                'Ville',
                style: TextStyle(
                  fontSize: 15.5,
                  color: AppTheme.dark_grey.withOpacity(0.9),
                  letterSpacing: 0.3
                ),
              ):
              Text(
                controller.city.value,
                style: TextStyle(fontSize: 15.5, letterSpacing: 0.3),
              ),
              icon: Icons.location_on,
              onTap: () {
                Get.to(() => CityScreen(type: 'filter-sub-category'));
              },
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            child: FormFilterInputData(
              title: 'Zone',
              content: (controller.zone.value.isEmpty) ?
              Text(
                'Zone',
                style: TextStyle(
                  fontSize: 15.5,
                  color: AppTheme.dark_grey.withOpacity(0.9),
                  letterSpacing: 0.3
                ),
              ) :
              Text(
                controller.zone.value,
                style: TextStyle(fontSize: 15.5, letterSpacing: 0.3),
              ),
              icon: Icons.location_on,
              onTap: () {
                (controller.city.isNotEmpty) ?
                  Get.to(() => ZoneScreen(type: 'filter-sub-category'), arguments: {'name': controller.city.value}) :
                  showVoidMessage('Veuillez d\'abord choisir un ville');
              },
            ),
          ),
        ],
      )),
    );
  }
}

class MarqueField extends StatelessWidget {
  const MarqueField({Key? key, required this.controller}) : super(key: key);

  final AdvertSubCategoryController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 15.0),
      child: Obx(() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: FormFilterInputData(
              title: 'Marque',
              content: (controller.marque.value.isEmpty) ?
              Text(
                'Marque',
                style: TextStyle(
                  fontSize: 15.5,
                  color: AppTheme.dark_grey.withOpacity(0.9),
                  letterSpacing: 0.3
                ),
              ):
              Text(
                controller.marque.value,
                style: TextStyle(fontSize: 15.5, letterSpacing: 0.3),
              ),
              iconSuffix: FontAwesomeIcons.arrowAltCircleRight,
              onTap: () {
                Get.to(() => MarqueScreen(type: 'filter-sub-category'));
              },
            ),
          ),
        ],
      )),
    );
  }
}

class ModelField extends StatelessWidget {
  const ModelField({Key? key, required this.controller}) : super(key: key);

  final AdvertSubCategoryController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 15.0),
      child: Obx(() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: FormFilterInputData(
              title: 'Modèle',
              content: (controller.model.value.isEmpty) ?
              Text(
                'Modèle',
                style: TextStyle(
                  fontSize: 15.5,
                  color: AppTheme.dark_grey.withOpacity(0.9),
                  letterSpacing: 0.3
                ),
              ) :
              Text(
                controller.model.value,
                style: TextStyle(fontSize: 15.5, letterSpacing: 0.3),
              ),
              iconSuffix: FontAwesomeIcons.arrowAltCircleRight,
              onTap: () {
                (controller.marque.isNotEmpty) ?
                  Get.to(() => ModelScreen(type: 'filter-sub-category'), arguments: {'marque': controller.marque.value}) :
                  showVoidMessage('Veuillez d\'abord choisir une marque');
              },
            ),
          ),
        ],
      )),
    );
  }
}

class TypeCarburantField extends StatelessWidget {
  const TypeCarburantField({Key? key, required this.controller}) : super(key: key);

  final AdvertSubCategoryController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 15.0),
      child: Obx(() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: FormFilterInputData(
              title: 'Type de carburant',
              content: (controller.typeCarburant.value.isEmpty) ?
              Text(
                'Type de carburant',
                style: TextStyle(
                  fontSize: 15.5,
                  color: AppTheme.dark_grey.withOpacity(0.9),
                  letterSpacing: 0.3
                ),
              ):
              Text(
                controller.typeCarburant.value,
                style: TextStyle(fontSize: 15.5, letterSpacing: 0.3),
              ),
              iconSuffix: FontAwesomeIcons.arrowAltCircleRight,
              onTap: () {
                Get.to(() => TypeCarburantScreen(type: 'filter-sub-category'));
              },
            ),
          ),
        ],
      )),
    );
  }
}

class KiloField extends StatelessWidget {
  const KiloField({Key? key, required this.controller}) : super(key: key);

  final AdvertSubCategoryController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5.0, bottom: 7.0),
            child: Text(
              'Kilométrage',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                color: AppTheme.darkerText,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5.0, bottom: 1.0),
                    child: Text(
                      'Min',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.darkerText,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.43,
                    child: FormDataField(
                      controller: controller.kiloMinController,
                      validator: null,
                      keyboardType: TextInputType.number,
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
                      hintText: 'Ex: 10000',
                      onChanged: (value) => null,
                      onSaved: (value) => controller.kiloMinController.text = value!,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 6.0, right: 6.0, top: 12.0),
                child: Icon(FontAwesomeIcons.minus, size: 12.0, color: AppTheme.grey),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5.0, bottom: 1.0),
                    child: Text(
                      'Max',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.darkerText,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.43,
                    child: FormDataField(
                      controller: controller.kiloMaxController,
                      validator: null,
                      keyboardType: TextInputType.number,
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
                      hintText: 'Ex: 20000',
                      onChanged: (value) => null,
                      onSaved: (value) => controller.kiloMaxController.text = value!,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class AutoYearField extends StatelessWidget {
  const AutoYearField({Key? key, required this.controller}) : super(key: key);

  final AdvertSubCategoryController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 15.0),
      child: Obx(() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5.0, bottom: 7.0),
            child: Text(
              'Année',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                color: AppTheme.darkerText,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width*0.43,
                  child: FormFilterInputData(
                    title: 'Min',
                    content: (controller.autoYearMin.value.isEmpty) ?
                    Text(
                      'Min',
                      style: TextStyle(
                          fontSize: 15.5,
                          color: AppTheme.dark_grey.withOpacity(0.9),
                          letterSpacing: 0.3
                      ),
                    ):
                    Text(
                      controller.autoYearMin.value,
                      style: TextStyle(fontSize: 15.5, letterSpacing: 0.3),
                    ),
                    iconSuffix: FontAwesomeIcons.arrowAltCircleRight,
                    onTap: () {
                      Get.to(() => AutoYearScreen(type: 'filter-sub-category', state: 'min'));
                    },
                  )
              ),
              Container(
                padding: EdgeInsets.only(left: 6.0, right: 6.0, top: 12.0),
                child: Icon(FontAwesomeIcons.minus, size: 12.0, color: AppTheme.grey),
              ),
              Container(
                width: MediaQuery.of(context).size.width*0.43,
                child: FormFilterInputData(
                  title: 'Max',
                  content: (controller.autoYearMax.value.isEmpty) ?
                  Text(
                    'Max',
                    style: TextStyle(
                      fontSize: 15.5,
                      color: AppTheme.dark_grey.withOpacity(0.9),
                      letterSpacing: 0.3
                    ),
                  ):
                  Text(
                    controller.autoYearMax.value,
                    style: TextStyle(fontSize: 15.5, letterSpacing: 0.3),
                  ),
                  iconSuffix: FontAwesomeIcons.arrowAltCircleRight,
                  onTap: () {
                    Get.to(() => AutoYearScreen(type: 'filter-sub-category', state: 'max'));
                  },
                ),
              )
            ],
          )
        ],
      ))
    );
  }
}


class SurfaceField extends StatelessWidget {
  const SurfaceField({Key? key, required this.controller}) : super(key: key);

  final AdvertSubCategoryController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5.0, bottom: 7.0),
            child: Text(
              'Surface',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                color: AppTheme.darkerText,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5.0, bottom: 1.0),
                    child: Text(
                      'Min',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.darkerText,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.43,
                    child: FormDataField(
                      controller: controller.surfaceMinController,
                      validator: null,
                      keyboardType: TextInputType.number,
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
                      hintText: 'Min',
                      onChanged: (value) => null,
                      onSaved: (value) => controller.surfaceMinController.text = value!,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 6.0, right: 6.0, top: 12.0),
                child: Icon(FontAwesomeIcons.minus, size: 12.0, color: AppTheme.grey),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5.0, bottom: 1.0),
                    child: Text(
                      'Max',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.darkerText,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.43,
                    child: FormDataField(
                      controller: controller.surfaceMaxController,
                      validator: null,
                      keyboardType: TextInputType.number,
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
                      hintText: 'Max',
                      onChanged: (value) => null,
                      onSaved: (value) => controller.surfaceMaxController.text = value!,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class ImmoStateFiel extends StatelessWidget {
  const ImmoStateFiel({Key? key, required this.controller}) : super(key: key);

  final AdvertSubCategoryController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 15.0),
        child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 2.0, bottom: 5.0),
              child: Text(
                'État',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.darkerText,
                  letterSpacing: 0.3,
                ),
              ),
            ),
            Row(
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                    splashColor: AppTheme.nearlyBlue.withOpacity(0.2),
                    onTap: () {
                      controller.immoInState.value = true;
                      controller.immoVoidState.value = false;

                      controller.immobilierState.value = controller.immoStateList[0];
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        color: (controller.immoInState.value) ? AppTheme.amber_dark : AppTheme.amber,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          bottomLeft:  Radius.circular(20.0),
                        ),
                        boxShadow: <BoxShadow>[
                          (controller.immoInState.value) ?
                          BoxShadow(color: AppTheme.grey.withOpacity(0.4), offset: const Offset(5, 5), blurRadius: 5) :
                          BoxShadow(color: AppTheme.grey.withOpacity(0.4), offset: const Offset(1.1, 1.1), blurRadius: 3.75),
                        ],
                      ),
                      child: Text(
                        'Meuble',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.white,
                          letterSpacing: 0.3
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 0.5),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      controller.immoInState.value = false;
                      controller.immoVoidState.value = true;

                      controller.immobilierState.value = controller.immoStateList[1];
                    },
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                    splashColor: AppTheme.nearlyBlue.withOpacity(0.2),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        color: (controller.immoVoidState.value) ? AppTheme.amber_dark : AppTheme.amber,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.0),
                          bottomRight:  Radius.circular(20.0),
                        ),
                        boxShadow: <BoxShadow>[
                          (controller.immoVoidState.value) ?
                          BoxShadow(color: AppTheme.grey.withOpacity(0.4), offset: const Offset(5, 5), blurRadius: 5) :
                          BoxShadow(color: AppTheme.grey.withOpacity(0.4), offset: const Offset(1.1, 1.1), blurRadius: 3.75),
                        ],
                      ),
                      child: Text(
                        'Vide',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.white,
                          letterSpacing: 0.3
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 10.0),
          ],
        ))

    );
  }
}


class NbrChambreAndNbrSalleBainField extends StatelessWidget {
  const NbrChambreAndNbrSalleBainField({Key? key, required this.controller}) : super(key: key);

  final AdvertSubCategoryController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5.0, bottom: 1.0),
                    child: Text(
                      'Nombre de chambres',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.darkerText,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.45,
                    child: FormDataField(
                      controller: controller.nombreChambreController,
                      validator: null,
                      keyboardType: TextInputType.number,
                      prefix: Icon(Icons.filter_alt, color: AppTheme.grey, size: 23.0),
                      onChanged: (value) => null,
                      onSaved: (value) => controller.nombreChambreController.text = value!,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 12.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5.0, bottom: 1.0),
                    child: Text(
                      'Nombre salle(s) bain',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.darkerText,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.45,
                    child: FormDataField(
                      controller: controller.nombreSalleBainController,
                      validator: null,
                      keyboardType: TextInputType.number,
                      prefix: Icon(Icons.filter_alt, color: AppTheme.grey, size: 23.0),
                      onChanged: (value) => null,
                      onSaved: (value) => controller.nombreSalleBainController.text = value!,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class NombrePieceField extends StatelessWidget {
  const NombrePieceField({Key? key, required this.controller}) : super(key: key);

  final AdvertSubCategoryController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: Obx(() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: FormFilterInputData(
              title: 'Nombre de pièces',
              content: (controller.nombrePiece.value.isEmpty) ?
              Text(
                'Nombre de pièces',
                style: TextStyle(
                  fontSize: 15.5,
                  color: AppTheme.dark_grey.withOpacity(0.9),
                  letterSpacing: 0.3
                ),
              ):
              Text(
                controller.nombrePiece.value,
                style: TextStyle(fontSize: 15.5, letterSpacing: 0.3),
              ),
              iconSuffix: FontAwesomeIcons.arrowAltCircleRight,
              onTap: () {
                Get.to(() => NombrePieceScreen(type: 'filter-sub-category'));
              },
            ),
          ),
        ],
      )),
    );
  }
}

class AccesField extends StatelessWidget {
  const AccesField({
    Key? key,
    required this.controller,
    required this.data
  }) : super(key: key);

  final AdvertSubCategoryController controller;
  final List data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5.0, bottom: 4.0),
            child: Text(
              'Accès',
              style: TextStyle(
                fontSize: 15.0,
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

class InteriorField extends StatelessWidget {
  const InteriorField({
    Key? key,
    required this.controller,
    required this.data
  }) : super(key: key);

  final AdvertSubCategoryController controller;
  final List data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5.0, bottom: 4.0),
            child: Text(
              'Intérieur',
              style: TextStyle(
                fontSize: 15.0,
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

class ExteriorField extends StatelessWidget {
  const ExteriorField({
    Key? key,
    required this.controller,
    required this.data
  }) : super(key: key);

  final AdvertSubCategoryController controller;
  final List data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5.0, bottom: 4.0),
            child: Text(
              'Extérieure',
              style: TextStyle(
                fontSize: 15.0,
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

class ProximiteField extends StatelessWidget {
  const ProximiteField({
    Key? key,
    required this.controller,
    required this.data
  }) : super(key: key);

  final AdvertSubCategoryController controller;
  final List data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5.0, bottom: 4.0),
            child: Text(
              'Proximité',
              style: TextStyle(
                fontSize: 15.0,
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


class StateFiel extends StatelessWidget {
  const StateFiel({Key? key, required this.controller}) : super(key: key);

  final AdvertSubCategoryController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 15.0),
        child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 2.0, bottom: 5.0),
              child: Text(
                'Etat du produit',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.darkerText,
                  letterSpacing: 0.3,
                ),
              ),
            ),
            Row(
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                    splashColor: AppTheme.nearlyBlue.withOpacity(0.2),
                    onTap: () {
                      controller.neufState.value = true;
                      controller.qNeufState.value = false;
                      controller.occasionState.value = false;
                      controller.renoverState.value = false;

                      controller.stateD.value = controller.stateDList[0];
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        color: (controller.neufState.value) ? AppTheme.amber_dark : AppTheme.amber,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          bottomLeft:  Radius.circular(20.0),
                        ),
                        boxShadow: <BoxShadow>[
                          (controller.neufState.value) ?
                          BoxShadow(color: AppTheme.grey.withOpacity(0.4), offset: const Offset(5, 5), blurRadius: 5) :
                          BoxShadow(color: AppTheme.grey.withOpacity(0.4), offset: const Offset(1.1, 1.1), blurRadius: 3.75),
                        ],
                      ),
                      child: Text(
                        'Neuf',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.white,
                          letterSpacing: 0.3
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 0.5),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      controller.neufState.value = false;
                      controller.qNeufState.value = true;
                      controller.occasionState.value = false;
                      controller.renoverState.value = false;

                      controller.stateD.value = controller.stateDList[1];
                    },
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                    splashColor: AppTheme.nearlyBlue.withOpacity(0.2),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        color: (controller.qNeufState.value) ? AppTheme.amber_dark : AppTheme.amber,
                        boxShadow: <BoxShadow>[
                          (controller.qNeufState.value) ?
                          BoxShadow(color: AppTheme.grey.withOpacity(0.4), offset: const Offset(5, 5), blurRadius: 5) :
                          BoxShadow(color: AppTheme.grey.withOpacity(0.4), offset: const Offset(1.1, 1.1), blurRadius: 3.75),
                        ],
                      ),
                      child: Text(
                        'Quasi neuf',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.white,
                          letterSpacing: 0.3
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 0.5),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      controller.neufState.value = false;
                      controller.qNeufState.value = false;
                      controller.occasionState.value = true;
                      controller.renoverState.value = false;

                      controller.stateD.value = controller.stateDList[2];
                    },
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                    splashColor: AppTheme.nearlyBlue.withOpacity(0.2),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        color: (controller.occasionState.value) ? AppTheme.amber_dark : AppTheme.amber,
                        boxShadow: <BoxShadow>[
                          (controller.occasionState.value) ?
                          BoxShadow(color: AppTheme.grey.withOpacity(0.4), offset: const Offset(5, 5), blurRadius: 5) :
                          BoxShadow(color: AppTheme.grey.withOpacity(0.4), offset: const Offset(1.1, 1.1), blurRadius: 3.75),
                        ],
                      ),
                      child: Text(
                        'Occasion',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.white,
                          letterSpacing: 0.3
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 0.5),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      controller.neufState.value = false;
                      controller.qNeufState.value = false;
                      controller.occasionState.value = false;
                      controller.renoverState.value = true;

                      controller.stateD.value = controller.stateDList[3];
                    },
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                    splashColor: AppTheme.nearlyBlue.withOpacity(0.2),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        color: (controller.renoverState.value) ? AppTheme.amber_dark : AppTheme.amber,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.0),
                          bottomRight:  Radius.circular(20.0),
                        ),
                        boxShadow: <BoxShadow>[
                          (controller.renoverState.value) ?
                          BoxShadow(color: AppTheme.grey.withOpacity(0.4), offset: const Offset(5, 5), blurRadius: 5) :
                          BoxShadow(color: AppTheme.grey.withOpacity(0.4), offset: const Offset(1.1, 1.1), blurRadius: 3.75),
                        ],
                      ),
                      child: Text(
                        'A rénover',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.white,
                          letterSpacing: 0.3
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 10.0),
          ],
        ))
    );
  }
}

class BrandField extends StatelessWidget {
  const BrandField({Key? key, required this.controller}) : super(key: key);

  final AdvertSubCategoryController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 15.0),
      child: Obx(() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: FormFilterInputData(
              title: 'Marque',
              content: (controller.brand.value.isEmpty) ?
              Text(
                'Marque',
                style: TextStyle(
                  fontSize: 15.5,
                  color: AppTheme.dark_grey.withOpacity(0.9),
                  letterSpacing: 0.3
                ),
              ):
              Text(
                controller.brand.value,
                style: TextStyle(fontSize: 15.5, letterSpacing: 0.3),
              ),
              iconSuffix: FontAwesomeIcons.arrowAltCircleRight,
              onTap: () {
                Get.to(() => BrandScreen(type: 'filter-sub-category'));
              },
            ),
          ),
        ],
      )),
    );
  }
}





