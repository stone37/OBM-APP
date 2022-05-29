import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:obm_market/constants/app_theme.dart';
import 'package:obm_market/modules/advert/controllers/advert_category_controller.dart';
import 'package:obm_market/modules/advert/controllers/advert_create_controller.dart';
import 'package:obm_market/modules/location/controllers/city_controller.dart';
import 'package:obm_market/modules/location/models/entities/city.dart';

import '../../../../modules/advert/controllers/advert_sub_category_controller.dart';
import '../../../../modules/advert/controllers/advert_sub_division_controller.dart';

class CityScreen extends StatelessWidget {
  CityScreen({this.type = 'create'});

  final String type;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CityController controller = Get.find();

  final AdvertCreateController advertCreateController = Get.put<AdvertCreateController>(AdvertCreateController());
  final AdvertCategoryController advertCategoryController = Get.find();
  final AdvertSubCategoryController advertSubCategoryController = Get.find();
  final AdvertSubDivisionController advertSubDivisionController = Get.find();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppTheme.background,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
          ),
          toolbarHeight: 70.0,
          titleSpacing: 0.0,
          elevation: 0,
          backgroundColor: AppTheme.background,
          title: _textBox(_formKey),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            splashRadius: 25.0,
            onPressed: () => Get.back(),
          ),
        ),
        body: Container(
          color: AppTheme.background,
          child: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      controller.obx(
                        (cityState) => Flexible(child: _buildCityView(context, cityState)),
                        onLoading: const Center(child: CircularProgressIndicator(color: AppTheme.primary)),
                        onEmpty: SizedBox(),
                        onError: (error) => Text(error!),
                      ),
                    ],
                  ),
                )
              )
            ],
          )
        )
    );
  }

  Widget _buildCityView(BuildContext context, List<City>? cities) {

    return Theme(
      data: ThemeData(splashColor: AppTheme.primary.withOpacity(0.1)),
      child: Column(
        children: <Widget>[
          ListView.builder(
              shrinkWrap: true,
              itemCount: cities?.length,
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                final city = cities?[index];

                return Material(
                  color: AppTheme.background,
                  child: ListTile(
                    title: Text(
                      city!.name,
                      style: TextStyle(
                          fontSize: 15.0,
                          letterSpacing: 0.3
                      ),
                    ),
                    contentPadding: EdgeInsets.only(left: 23.0),
                    dense: true,
                    onTap: () {
                      if (type == 'create') {
                        advertCreateController.city.value = city.name;
                        advertCreateController.zone.value = '';
                      } else if (type == 'edit') {

                      } else if (type == 'filter-category') {
                        advertCategoryController.city.value = city.name;
                        advertCategoryController.zone.value = '';
                      } else if (type == 'filter-sub-category') {
                        advertSubCategoryController.city.value = city.name;
                        advertSubCategoryController.zone.value = '';
                      } else {
                        advertSubDivisionController.city.value = city.name;
                        advertSubDivisionController.zone.value = '';
                      }

                      Get.back();
                    },
                  ),
                );
              }
          ),
          SizedBox(height: 30.0)
        ],
      ),
    );
  }

  Widget _textBox(GlobalKey<FormState> formKey) {
    return Container(
        alignment: Alignment.centerLeft,
        height: 50.0,
        margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 25.0),
        child: Form(
          key: formKey,
          child: TextField(
            controller: controller.name,
            onChanged: (value) {
              controller.getCities(value);
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: AppTheme.grey.withOpacity(0.15),
              prefixIcon: Icon(FontAwesomeIcons.filter, color: AppTheme.grey, size: 18.0),
              border: InputBorder.none,
              hintText: 'Rechercher une ville ?',
              hintStyle: TextStyle(
                  color: AppTheme.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                  letterSpacing: 0.5
              ),
              contentPadding: EdgeInsets.only(top: 8.0, left: 0.0),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                borderSide: BorderSide(width: 1.2, color: AppTheme.background),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                borderSide: BorderSide(width: 1.2, color: AppTheme.background),
              ),
            ),
            cursorHeight: 23.0,
          ),
        )
    );
  }
}


