import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:obm_market/constants/app_theme.dart';
import 'package:obm_market/modules/advert/controllers/advert_create_controller.dart';
import 'package:obm_market/modules/advert/models/entities/category.dart';

import '../../../../modules/advert/controllers/advert_sub_category_controller.dart';
import '../../../../modules/advert/controllers/advert_sub_division_controller.dart';
import '../../../../utils/avert_data.dart';

class BrandScreen extends StatelessWidget {
  BrandScreen({this.type = 'create'});

  final String type;
  final AdvertCreateController advertCreateController = Get.put(AdvertCreateController());
  final AdvertSubCategoryController advertSubCategoryController = Get.find();
  final AdvertSubDivisionController advertSubDivisionController = Get.find();

  @override
  Widget build(BuildContext context) {
    Category category;

    if (type == 'create') {
      category = advertCreateController.category.value;
    } else if (type == 'edit') {
      category = advertCreateController.category.value;
    } else if (type == 'filter-sub-category') {
      category = advertSubCategoryController.category.value;
    } else {
      category = advertSubDivisionController.category.value;
    }

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
          title: Text(
            'Selectionner une marque',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500
            ),
          ),
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
                          Flexible(child: _buildMarqueView(context, getMarque(category)))
                        ],
                      ),
                    )
                )
              ],
            )
        ),
    );
  }

  Widget _buildMarqueView(BuildContext context, List<String>? marques) {

    return Theme(
      data: ThemeData(splashColor: AppTheme.primary.withOpacity(0.1)),
      child: Column(
        children: <Widget>[
          ListView.builder(
              shrinkWrap: true,
              itemCount: marques?.length,
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                final marque = marques?[index];

                return Material(
                  color: AppTheme.background,
                  child: ListTile(
                    title: Text(
                      marque!,
                      style: TextStyle(
                          fontSize: 15.0,
                          letterSpacing: 0.3
                      ),
                    ),
                    contentPadding: EdgeInsets.only(left: 23.0),
                    dense: true,
                    onTap: () {
                      if (type == 'create') {
                        advertCreateController.brand.value = marque;
                      } else if (type == 'edit') {
                        advertCreateController.brand.value = marque;
                      } else if (type == 'filter-sub-category') {
                        advertSubCategoryController.brand.value = marque;
                      } else {
                       advertSubDivisionController.brand.value = marque;
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

  List<String>? getMarque(Category category) {

    List<String>? marques = [];

    if (category.slug == 'telephones-portables' || category.slug == 'ipad-et-tablettes') {
      marques = AdvertCreateData().brandList['phone'];
    } else if (category.slug == 'ordinateurs-de-bureau' || category.slug == 'portables') {
      marques = AdvertCreateData().brandList['ordinateur'];
    }

    return marques;
  }
}




