import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:obm_market/constants/app_theme.dart';
import 'package:obm_market/modules/advert/controllers/advert_create_controller.dart';
import 'package:obm_market/modules/advert/controllers/category_controller.dart';
import 'package:obm_market/modules/advert/models/entities/category.dart';
import 'package:obm_market/views/screens/advert/create/advert_create_screen.dart';

class AdvertSubDivisionChoiceScreen extends StatelessWidget {
  const AdvertSubDivisionChoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CategoryController controller = Get.find();
    final AdvertCreateController advertCreateController = Get.find();

    var id = Get.arguments['id'];
    var parentId = Get.arguments['parentId'];
    var parentName = Get.arguments['parentName'];
    var parentSlug = Get.arguments['parentSlug'];

    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppTheme.background,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
          ),
          titleSpacing: 0.0,
          elevation: 0,
          backgroundColor: AppTheme.background,
          title: Text(
            'Choisir une catégorie',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            splashRadius: 25.0,
            onPressed: () => Get.back(),
          ),
        ),
        body: Container(
          color: AppTheme.background,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Flexible(
                        child: _buildCategoryView(
                          context,
                          controller,
                          advertCreateController,
                          int.parse(id),
                          int.parse(parentId),
                          parentName,
                          parentSlug
                        ),
                      ),
                      SizedBox(height: 50.0)
                    ],
                  ),
                )
              )
            ],
          )
        )
    );
  }

  Widget _buildCategoryView(
    BuildContext context,
    CategoryController controller,
    AdvertCreateController advertCreateController,
    int id, int parentId, String name, String slug) {

    return FutureBuilder<Category?>(
      future: controller.getCategory(id),
      builder: (BuildContext context, AsyncSnapshot<Category?> snapshot) {
        if (!snapshot.hasData) {
          return Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Center(
              child: CircularProgressIndicator(color: AppTheme.primary),
            ),
          );
        } else {
          return (snapshot.data!.children!.isEmpty) ?
            const SizedBox() :
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.children!.length,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    final children =  snapshot.data!.children![index];

                    return Material(
                      color: AppTheme.background,
                      child: ListTile(
                        title: Row(
                          children: <Widget>[
                            Container(
                              child: Icon(FontAwesomeIcons.longArrowAltRight, size: 16.0),
                            ),
                            SizedBox(width: 10.0),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.77,
                              child: Text(
                                children['name'],
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                softWrap: false,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.3,
                                  color: AppTheme.dark_grey
                                ),
                              ),
                            )
                          ],
                        ),
                        contentPadding: EdgeInsets.only(left: 23.0),
                        dense: true,
                        onTap: () {
                          //advertCreateController.categoryId.value = children['id'];
                          //advertCreateController.categoryParentId.value = parentId;
                          advertCreateController.category.value = new Category(
                            id: children['id'],
                            name: children['name'],
                            slug: children['slug']
                          );

                          advertCreateController.categoryParent.value = new Category(
                            id: id,
                            name: name,
                            slug: slug
                          );

                          advertCreateController.activeStepIndex.value++;

                          Get.off(() => AdvertCreateScreen());
                        },
                      ),
                    );
                  }
                )
              ]
            );
        }
      },
    );
  }
}


