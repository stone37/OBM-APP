import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:obm_market/constants/app_theme.dart';
import 'package:obm_market/modules/advert/controllers/advert_create_controller.dart';
import 'package:obm_market/modules/advert/models/entities/category.dart';
import 'package:obm_market/views/screens/advert/create/advert_sub_division_choice_screen.dart';

class AdvertCategoryView extends StatelessWidget {
  const AdvertCategoryView({Key? key, required this.controller, required this.category}) : super(key: key);

  final AdvertCreateController controller;
  final Category category;

  @override
  Widget build(BuildContext context) {

    return Container(
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
        child: Column(
            children: <Widget>[
              Theme(
                data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent,
                  colorScheme: ColorScheme.dark(primary: AppTheme.dark_grey),
                  splashColor: AppTheme.primary.withOpacity(0.1)
                ),
                child: Material(
                  color: AppTheme.background,
                  child: ExpansionTile(
                    childrenPadding: EdgeInsets.only(left: 10.0),
                    title: Row(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: CachedNetworkImageProvider('https://oblackmarket.com/public'+category.imageUrl!),
                              fit: BoxFit.fill,
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: AppTheme.grey.withOpacity(0.4),
                                offset: const Offset(5, 5),
                                blurRadius: 8.0
                              ),
                            ]
                          ),
                          width: 50,
                          height: 50,
                          child: null,
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          category.name,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.dark_grey,
                            letterSpacing: 0.3
                          ),
                        )
                      ]
                    ),
                    children: <Widget>[

                      CategoryChildrenListView(
                        controller: controller,
                        category: category
                      )
                    ],
                  )
                )
              )
            ]
        )
    );
  }
}


class CategoryChildrenListView extends StatelessWidget {
  const CategoryChildrenListView({
    Key? key,
    required this.category,
    required this.controller
  }) : super(key: key);

  final Category category;
  final AdvertCreateController controller;
  //final List<Map<String, dynamic>> categories;

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: category.children!.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  final children = category.children![index];
                  final hasChild = (children['children'] == 0);

                  return Material(
                      color: AppTheme.background,
                      child: ListTile(
                        title: Row(
                          children: <Widget>[
                            (hasChild) ?
                            Container(
                              child: Icon(FontAwesomeIcons.longArrowAltRight, size: 16.0),
                            ) : const SizedBox(width: 12.0),
                            SizedBox(width: 10.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                          ],
                        ),
                        onTap: () {
                          if (hasChild) {

                            controller.category.value = new Category(id: children['id'], name: children['name'], slug: children['slug']);
                            controller.categoryParent.value = new Category(id: category.id, name: category.name, slug: category.slug);

                            controller.activeStepIndex.value++;
                          } else {
                            Get.to(
                              () => AdvertSubDivisionChoiceScreen(),
                              arguments: {
                                'id': children['id'].toString(),
                                'parentId': category.id.toString(),
                                'parentName': category.name,
                                'parentSlug': category.slug,
                              }
                            );
                          }
                        },
                      )
                  );
                }
            );
          }
        }
    );
  }
}

