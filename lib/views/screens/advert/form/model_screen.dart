import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:obm_market/constants/app_theme.dart';
import 'package:obm_market/modules/advert/controllers/advert_create_controller.dart';

import '../../../../modules/advert/controllers/advert_category_controller.dart';
import '../../../../modules/advert/controllers/advert_sub_category_controller.dart';
import '../../../../modules/advert/controllers/advert_sub_division_controller.dart';
import '../../../../utils/avert_data.dart';

class ModelScreen extends StatelessWidget {
  ModelScreen({this.type = 'create'});

  final String type;
  final AdvertCreateController advertCreateController = Get.put(AdvertCreateController());
  final AdvertCategoryController advertCategoryController = Get.find();
  final AdvertSubCategoryController advertSubCategoryController = Get.find();
  final AdvertSubDivisionController advertSubDivisionController = Get.find();

  @override
  Widget build(BuildContext context) {

    var marque = Get.arguments['marque'];

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
            'Selectionner un modèle',
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
                      Flexible(child: _buildModelView(context, getModel(marque)))
                    ],
                  ),
                )
              )
            ],
          )
        )
    );
  }

  Widget _buildModelView(BuildContext context, List<String>? marques) {

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
                final model = marques?[index];

                return Material(
                  color: AppTheme.background,
                  child: ListTile(
                    title: Text(
                      model!,
                      style: TextStyle(
                        fontSize: 15.0,
                        letterSpacing: 0.3
                      ),
                    ),
                    contentPadding: EdgeInsets.only(left: 23.0),
                    dense: true,
                    onTap: () {

                      if (type == 'create') {
                        advertCreateController.model.value = model;
                      } else if (type == 'edit') {
                        advertCreateController.model.value = model;
                      } else if (type == 'filter-sub-category') {
                        advertSubCategoryController.model.value = model;
                      } else {
                        advertSubDivisionController.model.value = model;
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

  List<String>? getModel(String marque) {
    return AdvertCreateData().modelList[marque];
  }
}




