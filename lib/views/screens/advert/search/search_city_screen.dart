import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:obm_market/constants/app_theme.dart';
import 'package:obm_market/modules/advert/controllers/advert_search_controller.dart';
import 'package:obm_market/modules/location/controllers/city_controller.dart';
import 'package:obm_market/modules/location/models/entities/city.dart';

class SearchCityScreen extends StatelessWidget {
  final CityController controller = Get.find();
  final AdvertSearchController searchController = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
          elevation: 0.0,
          backgroundColor: AppTheme.background,
          title: _textBox(_formKey),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      controller.obx(
                        (cityState) => Flexible(child: _buildCityView(context, cityState)),
                        onLoading: const Center(child: CircularProgressIndicator(color: AppTheme.primary)),
                        onEmpty: SizedBox(),
                        onError: (error) => Text(error!),
                      )
                    ],
                  )
                ),
              )
            ],
          )
        )
    );
  }

  Widget _buildCityView(BuildContext context, List<City>? cityState) {
    return Theme(
      data: ThemeData(splashColor: AppTheme.primary.withOpacity(0.1)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Material(
            color: AppTheme.background,
            child: ListTile(
              title: Text(
                'Toute la Côte d\'Ivoire',
                style: TextStyle(
                  fontSize: 15.0,
                  letterSpacing: 0.3
                ),
              ),
              contentPadding: EdgeInsets.only(left: 23.0),
              dense: true,
              onTap: () {
                searchController.changeCity(new City(
                  name: 'Pays',
                  countryCode: '',
                  slug: ''
                ));

                Get.back();
              },
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: cityState?.length,
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                final city = cityState?[index];

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
                      searchController.changeCity(new City(
                        name: city.name,
                        countryCode: city.countryCode,
                        slug: city.slug
                      ));

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


