import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:obm_market/constants/app_theme.dart';
import 'package:obm_market/modules/advert/controllers/advert_search_controller.dart';
import 'package:obm_market/modules/advert/controllers/category_controller.dart';
import 'package:obm_market/modules/advert/models/entities/category.dart';

class SearchCategoryScreen extends StatelessWidget {

  final CategoryController controller = Get.find();
  final AdvertSearchController searchController = Get.find();

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
              'Choisir une catégorie',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500
              ),
            ),
            //leadingWidth: 45.0,
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
              color: AppTheme.background,
              padding: EdgeInsets.symmetric(vertical: 10.0),
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          controller.obx(
                            (categoryState) => Flexible(child: _buildCategoryView(context, categoryState)),
                            onLoading: const Center(child: CircularProgressIndicator(color: AppTheme.primary)),
                            onEmpty: SizedBox(),
                            onError: (error) => Text(error!),
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


  _buildCategoryView(
      BuildContext context,
      List<Category>? categoryState) {

    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            itemCount: categoryState!.length,
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return CategoryExpansionTileView(category: categoryState[index], controller: searchController);
            }
          )
        ]
    );
  }
}

class CategoryExpansionTileView extends StatelessWidget {
  const CategoryExpansionTileView({Key? key, this.controller, this.category}) : super(key: key);

  final AdvertSearchController? controller;
  final Category? category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0),
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
                childrenPadding: EdgeInsets.only(left: 50.0),
                title: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider('https://oblackmarket.com/public'+category!.imageUrl!) ,//NetworkImage('https://oblackmarket.com/public'+category!.imageUrl!),
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
                      category!.name,
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
                  CategoryChildrenListView(controller: controller, categoryParent: category!, categories: category!.children!)
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
    Key? key, this.controller,
    required this.categoryParent,
    required this.categories
  }) : super(key: key);

  final Category categoryParent;
  final AdvertSearchController? controller;
  final List<Map<String, dynamic>> categories;

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
            itemCount: categories.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              final children = categories[index];

              return (children.containsKey('image')) ?
              imageData(controller!, children, context) :
              notImageData(controller!, children, context);
            }
          );
        }
      }
    );
  }

  Widget imageData(AdvertSearchController controller, Map<String, dynamic> children, BuildContext context) {
    return Material(
        color: AppTheme.background,
        child: ListTile(
          title: Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider('https://oblackmarket.com/public'+children['image']), //NetworkImage('https://oblackmarket.com/public'+children['image']),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(width: 1.4, color: AppTheme.primary),
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: AppTheme.grey.withOpacity(0.4),
                      offset: const Offset(3, 3),
                      blurRadius: 5.0
                    ),
                  ]
                ),
                width: 42,
                height: 42,
                child: null,
              ),
              SizedBox(width: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.62,
                    child: Text(
                      children['name'],
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.3,
                        color: AppTheme.dark_grey
                      ),
                    ),
                  ),
                  SizedBox(height: 3.0),
                  Text(
                    "${children['advert']} annonces",
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.3,
                      color: AppTheme.grey
                    ),
                  )
                ],
              ),
            ],
          ),
          onTap: () {
            controller.changeCategory(new Category(
              id: children['id'],
              name: children['name'],
              slug: children['slug'],
              imageUrl: children['image'],
              advert: children['advert'],
              levelDepth: children['levelDepth'],
              parentId: categoryParent.id,
              parentName: categoryParent.name,
              parentSlug: categoryParent.slug,
              parentLevelDepth: categoryParent.levelDepth,
            ));

            Get.back();
          },
        )
    );
  }

  Widget notImageData(AdvertSearchController controller, Map<String, dynamic> children, BuildContext context) {
    return Material(
        color: AppTheme.background,
        child: ListTile(
          title: Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.background,
                  border: Border.all(width: 1.4, color: AppTheme.primary),
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: AppTheme.grey.withOpacity(0.4),
                      offset: const Offset(3, 3),
                      blurRadius: 5.0
                    ),
                  ]
                ),
                alignment: Alignment.center,
                width: 42,
                height: 42,
                child: FaIcon(FontAwesomeIcons.tags, color: AppTheme.primary, size: 16.0),
              ),
              SizedBox(width: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.62,
                    child: Text(
                      children['name'],
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.3,
                        color: AppTheme.dark_grey
                      ),
                    ),
                  ),
                  SizedBox(height: 3.0),
                  Text(
                    "${children['advert']} annonces",
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.3,
                      color: AppTheme.grey
                    ),
                  )
                ],
              ),
            ],
          ),
          onTap: () {
            controller.changeCategory(new Category(
              id: children['id'],
              name: children['name'],
              slug: children['slug'],
              imageUrl: '',
              advert: children['advert'],
              levelDepth: children['levelDepth'],
              parentSlug: categoryParent.slug
            ));

            Get.back();
          },
        )
    );
  }

}
