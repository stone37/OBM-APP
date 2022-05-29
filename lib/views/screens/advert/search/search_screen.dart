import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:obm_market/constants/app_theme.dart';
import 'package:obm_market/modules/advert/controllers/advert_search_controller.dart';
import 'package:obm_market/modules/advert/controllers/advert_sub_category_controller.dart';
import 'package:obm_market/modules/advert/models/entities/category.dart';
import 'package:obm_market/views/screens/advert/search/search_category_screen.dart';
import 'package:obm_market/views/screens/advert/search/search_city_screen.dart';
import '../index/advert_search_screen.dart';
import '../index/advert_sub_category_screen.dart';

class SearchScreen extends GetWidget<AdvertSearchController> {

  final AdvertSearchController controller = Get.find();
  final AdvertSubCategoryController advertSubCategoryController = Get.find();
  final AdvertSearchController advertSearchController = Get.find();
  final box = GetStorage();

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
          title: TextBox(),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Theme(
                data: Theme.of(context).copyWith(splashColor: AppTheme.primary.withOpacity(0.1)),
                child: Container(
                  color: Colors.red,
                  child: Column(
                    children: <Widget>[
                      Material(
                        color: AppTheme.background,
                        child: ListTile(
                          visualDensity: VisualDensity.comfortable,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Obx(() {
                                    if (controller.category.value.name.isEmpty) {
                                      return Row(
                                        children: <Widget>[
                                          Icon(FontAwesomeIcons.th, color: AppTheme.dark_grey.withOpacity(0.5), size: 19.0),
                                          SizedBox(width: 30.0)
                                        ],
                                      );
                                    } else {
                                      return (controller.category.value.imageUrl!.isEmpty) ?
                                      Row(
                                        children: <Widget>[
                                          notImageData(),
                                          SizedBox(width: 20.0),
                                        ],
                                      ) : Row(
                                        children: <Widget>[
                                          imageData(controller.category.value.imageUrl!),
                                          SizedBox(width: 20.0),
                                        ],
                                      );
                                    }
                                  }),

                                  //SizedBox(width: 30.0),

                                  Obx(() {
                                    return (controller.category.value.name.isEmpty) ?
                                    Text(
                                      'Choisir une catégorie',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.3,
                                      ),
                                    ) :
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.65,
                                      child: Text(
                                        'Catégorie : ${controller.category.value.name}',
                                        maxLines: 1,
                                        overflow: TextOverflow.fade,
                                        softWrap: false,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0.3,
                                        ),
                                      ),
                                    );
                                  }),
                                ],
                              ),
                              Icon(FontAwesomeIcons.angleRight, color: AppTheme.dark_grey.withOpacity(0.5), size: 17.0),
                            ],
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 23.0, vertical: 6.0),
                          dense: true,
                          onTap: () {
                            Get.to(
                                () => SearchCategoryScreen(),
                              transition: Transition.cupertino,
                              duration: Duration(milliseconds: 300)
                            );
                          },
                        ),
                      ),
                      Divider(height: 0.0),
                      Material(
                        color: AppTheme.background,
                        child: ListTile(
                          visualDensity: VisualDensity.comfortable,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Obx(() => (controller.city.value.name.isEmpty) ? SizedBox(): SizedBox(width: 10.0)),
                                  Icon(FontAwesomeIcons.mapMarkerAlt, color: AppTheme.dark_grey.withOpacity(0.5), size: 20.0),
                                  SizedBox(width: 30.0),

                                  Obx(() {
                                    if (controller.city.value.name.isEmpty) {
                                      return Text(
                                        'Choisir une ville',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0.3,
                                        )
                                      );
                                    } else {
                                      return (controller.city.value.name == 'pays') ?
                                        Text(
                                          'Ville : Toutes les villes',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.3,
                                          )
                                        ) :
                                        Text(
                                          'Ville : ${controller.city.value.name}',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.3,
                                          )
                                        );
                                    }
                                  }),
                                ],
                              ),
                              Icon(FontAwesomeIcons.angleRight, color: AppTheme.dark_grey.withOpacity(0.5), size: 18.0),
                            ],
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 23.0, vertical: 6.0),
                          dense: true,
                          onTap: () {
                            Get.to(
                              () => SearchCityScreen(),
                              transition: Transition.cupertino,
                              duration: Duration(milliseconds: 600)
                            );
                          },
                        ),
                      ),
                      Divider(height: 0.0)
                    ],
                  ),
                ),
              ),
              Container(
                height: 45.0,
                width: MediaQuery.of(context).size.width ,
                margin: EdgeInsets.only(bottom: 10.0, left: 15.0, right: 15.0),
                child: ElevatedButton(
                  onPressed: () {
                    final Map<String, dynamic> data = {
                      'category': controller.category.value.slug,
                      'levelDepth': controller.category.value.levelDepth,
                      'positionOrder': 'desc',
                      if (controller.city.value.name.isNotEmpty)
                        if(controller.city.value.name == 'Pays') 'city': ''
                        else 'city': controller.city.value.name,
                    };


                    box.write('category_parent', controller.category.value.parentSlug);

                    box.write('category_id', controller.category.value.parentId.toString());
                    box.write('category_name', controller.category.value.parentName);
                    box.write('category_slug', controller.category.value.parentSlug);
                    box.write('category_levelDepth', controller.category.value.parentLevelDepth);

                    if (controller.category.value.id != 0) {
                      advertSubCategoryController.categoryParent.value = new Category(
                        id: controller.category.value.parentId!,
                        name: controller.category.value.parentName!,
                        slug: controller.category.value.parentSlug!,
                        levelDepth: controller.category.value.parentLevelDepth
                      );

                      advertSubCategoryController.city.value = controller.city.value.name;
                      advertSubCategoryController.category.value = controller.category.value;
                      advertSubCategoryController.fetch(data);

                      Get.off(() => AdvertSubCategoryScreen());
                    } else {
                      advertSearchController.filter.value = {
                        'positionOrder': 'desc',
                        'city': (controller.city.value.name == 'Pays') ? '' : controller.city.value.name,
                      };

                      advertSearchController.page.value = 1;

                      Get.off(() => AdvertSearchScreen());
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(AppTheme.primary),
                    padding: MaterialStateProperty.all(EdgeInsets.only(left: 14.0, right: 6.0, top: 9.0, bottom: 9.0)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      )
                    )
                  ),
                  child: Container(
                    padding: EdgeInsets.only(top: 1.0),
                    child: Obx(
                      () => (controller.category.value.name.isEmpty) ?
                      Text(
                        'Trouver ce que vous cherchez',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14
                        )
                      ) :
                      Text(
                        'Rechercher \t (${controller.category.value.advert} résultats)',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14
                        )
                      )
                    )
                  ),
                ),
              )
            ],
          ),
        )
    );
  }

  Widget imageData(String url) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://oblackmarket.com/public'+url),
          fit: BoxFit.cover,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(30.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppTheme.grey.withOpacity(0.4),
            offset: const Offset(5, 5),
            blurRadius: 8.0
          ),
        ]
      ),
      width: 42,
      height: 42,
      child: null,
    );
  }

  Widget notImageData() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.background,
        borderRadius: const BorderRadius.all(Radius.circular(30.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppTheme.grey.withOpacity(0.4),
            offset: const Offset(5, 5),
            blurRadius: 8.0
          ),
        ]
      ),
      alignment: Alignment.center,
      width: 42,
      height: 42,
      child: FaIcon(FontAwesomeIcons.tags, color: AppTheme.primary, size: 16.0),
    );
  }
}

class TextBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: 50.0,
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 25.0),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: AppTheme.grey.withOpacity(0.15),
          prefixIcon: Icon(Icons.search, color: AppTheme.grey, size: 22.0),
          border: InputBorder.none,
          hintText: 'Rechercher m\'importe quoi...',
          hintStyle: TextStyle(
            color: AppTheme.grey,
            fontWeight: FontWeight.w400,
            fontSize: 15.5,
            letterSpacing: 0.5
          ),
          contentPadding: EdgeInsets.only(top: 7.0, left: 0.0),
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
    );
  }
}



