import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:obm_market/constants/app_theme.dart';
import 'package:obm_market/modules/advert/controllers/advert_category_controller.dart';
import 'package:obm_market/modules/advert/controllers/advert_create_controller.dart';
import 'package:obm_market/modules/location/controllers/zone_controller.dart';
import 'package:obm_market/modules/location/models/entities/zone.dart';
import 'package:obm_market/views/common/btn_bulk.dart';
import '../../../../modules/advert/controllers/advert_sub_category_controller.dart';
import '../../../../modules/advert/controllers/advert_sub_division_controller.dart';


class ZoneScreen extends StatelessWidget {
  ZoneScreen({this.type = 'create'});

  final String type;
  final ZoneController controller = Get.find();
  final AdvertCreateController advertCreateController = Get.put(AdvertCreateController());
  final AdvertCategoryController advertCategoryController = Get.find();
  final AdvertSubCategoryController advertSubCategoryController = Get.find();
  final AdvertSubDivisionController advertSubDivisionController = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    var name = Get.arguments['name'];

    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppTheme.background,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
          ),
          toolbarHeight: 70.0,
          titleSpacing: 0.0,
          elevation: 0.0,
          backgroundColor: AppTheme.background,
          title: _textBox(_formKey),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            splashRadius: 25.0,
            onPressed: () {
              controller.name.text = '';
              Get.back(result: {'name': name});
            },
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.height,
          color: AppTheme.background,
          child: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      FutureBuilder<List<Zone>?>(
                        future: controller.getZones(name),
                        builder: (BuildContext context, AsyncSnapshot<List<Zone>?> snapshot) {
                          if (!snapshot.hasData) {
                            return Padding(
                              padding: EdgeInsets.only(top: 30.0),
                              child: Center(
                                child: CircularProgressIndicator(color: AppTheme.primary),
                              ),
                            );
                          } else {
                            return (snapshot.data!.isEmpty) ?
                              const SizedBox() :
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 24.0, top: 10.0, bottom: 8.0),
                                    child: Text(
                                      'Suggestion de zone',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.3
                                      ),
                                    ),
                                  ),
                                  _buildZoneView(context, snapshot.data)
                                ],
                              );
                          }
                        },
                      )
                    ],
                  ),
                )
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15.0, left: 20.0, right: 20.0, top: 10.0),
                child: PageButton(
                  text: 'Valider',
                  textColor: AppTheme.white,
                  backgroundColor: AppTheme.primary,
                  borderColor: AppTheme.primary,
                  callback: () {
                    if (type == 'create') {
                      advertCreateController.zone.value = controller.name.value.text;
                    } else if (type == 'edit') {

                    } else if (type == 'filter-category') {
                      advertCategoryController.zone.value = controller.name.value.text;
                    } else if (type == 'filter-sub-category') {
                      advertSubCategoryController.zone.value = controller.name.value.text;
                    } else {
                      advertSubDivisionController.zone.value = controller.name.value.text;
                    }

                    Get.back(result: {'name': name});
                  },
                ),
              )
            ],
          )
        )
    );
  }

  Widget _buildZoneView(BuildContext context, List<Zone>? zones) {

    return Theme(
      data: ThemeData(splashColor: AppTheme.primary.withOpacity(0.1)),
      child: Column(
        children: <Widget>[
          ListView.builder(
              shrinkWrap: true,
              itemCount: zones?.length,
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                final zone = zones?[index];

                return Material(
                  color: AppTheme.background,
                  child: ListTile(
                    title: Text(
                      zone!.name,
                      style: TextStyle(
                        fontSize: 15.0,
                        letterSpacing: 0.3
                      ),
                    ),
                    contentPadding: EdgeInsets.only(left: 23.0),
                    dense: true,
                    onTap: () {
                      controller.name.text = zone.name;
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
          onChanged: null,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppTheme.grey.withOpacity(0.15),
            prefixIcon: Icon(FontAwesomeIcons.filter, color: AppTheme.grey, size: 18.0),
            border: InputBorder.none,
            hintText: 'Insérer une zone ?',
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


