import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:obm_market/constants/app_theme.dart';
import 'package:obm_market/modules/advert/controllers/advert_category_controller.dart';
import 'package:obm_market/views/common/btn_bulk.dart';
import 'package:obm_market/views/screens/advert/index/advert_category_screen.dart';

import '../../../common/form_advert_data.dart';
import '../../../widgets/message/voidMessage.dart';
import '../form/city_screen.dart';
import '../form/zone_screen.dart';

class AdvertCategoryFilterScreen extends StatelessWidget {

  final GlobalKey<FormState> _formKeys = GlobalKey<FormState>();
  final AdvertCategoryController controller = Get.find();
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
            icon: Icon(Icons.arrow_back, color: Colors.white,),
            splashRadius: 20.0,
            onPressed: () => Get.back()
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
                        TypeExtendFiel(controller: controller) :
                        TypeFiel(controller: controller),
                        SizedBox(height: 15.0),
                        BudgetFieldData(controller: controller),
                        SizedBox(height: 15.0),
                        LocationField(controller: controller),
                      ],
                    ),
                  ),
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

                          Get.off(() => AdvertCategoryScreen());
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
        ),
    );
  }
}


class TypeFiel extends StatelessWidget {
  const TypeFiel({Key? key, required this.controller}) : super(key: key);

  final AdvertCategoryController controller;

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

  final AdvertCategoryController controller;

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
  const BudgetFieldData({Key? key, required this.controller}) : super(key: key);

  final AdvertCategoryController controller;

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

  final AdvertCategoryController controller;

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
                Get.to(() => CityScreen(type: 'filter-category'));
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
                  Get.to(() => ZoneScreen(type: 'filter-category'), arguments: {'name': controller.city.value}) :
                  showVoidMessage('Veuillez d\'abord choisir un ville');
              },
            ),
          ),
        ],
      )),
    );
  }
}




