import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:obm_market/constants/app_theme.dart';
import 'package:obm_market/modules/advert/controllers/advert_create_controller.dart';
import '../../../../modules/advert/controllers/advert_category_controller.dart';
import '../../../../modules/advert/controllers/advert_sub_category_controller.dart';
import '../../../../modules/advert/controllers/advert_sub_division_controller.dart';
import '../../../../utils/avert_data.dart';

class AutoYearScreen extends StatelessWidget {
  AutoYearScreen({this.type = 'create', this.state});

  final String type;
  final String? state;
  final AdvertCreateController advertCreateController = Get.put(AdvertCreateController());
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
          title: Text(
            'Selectionner une année',
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
                      Flexible(child: _buildYearView(context, getYear()))
                    ],
                  ),
                )
              )
            ],
          )
        ),
    );
  }

  Widget _buildYearView(BuildContext context, List<String>? years) {

    return Theme(
      data: ThemeData(splashColor: AppTheme.primary.withOpacity(0.1)),
      child: Column(
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            itemCount: years?.length,
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              final year = years?[index];

              return Material(
                color: AppTheme.background,
                child: ListTile(
                  title: Text(
                    year!,
                    style: TextStyle(
                      fontSize: 15.0,
                      letterSpacing: 0.3
                    ),
                  ),
                  contentPadding: EdgeInsets.only(left: 23.0),
                  dense: true,
                  onTap: () {

                    if (type == 'create') {
                      advertCreateController.autoYear.value = year;
                    } else if (type == 'edit') {
                      advertCreateController.autoYear.value = year;
                    } else if (type == 'filter-sub-category') {
                      if (state == 'min')
                        advertSubCategoryController.autoYearMin.value = year;
                      else
                        advertSubCategoryController.autoYearMax.value = year;
                    } else {
                      if (state == 'max')
                        advertSubDivisionController.autoYearMin.value = year;
                      else
                        advertSubDivisionController.autoYearMax.value = year;
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

  List<String>? getYear() {
    return AdvertCreateData().yearList;
  }
}




