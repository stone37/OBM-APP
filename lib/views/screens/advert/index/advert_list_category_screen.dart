import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:obm_market/constants/app_theme.dart';
import 'package:obm_market/modules/advert/controllers/advert_sub_category_controller.dart';
import 'package:obm_market/modules/advert/models/entities/category.dart';
import 'package:obm_market/views/screens/advert/index/advert_category_screen.dart';
import 'package:obm_market/views/screens/advert/index/advert_sub_category_screen.dart';
import 'package:obm_market/views/screens/advert/index/advert_sub_division_screen.dart';
import '../../../../modules/advert/controllers/category_controller.dart';

class AdvertListCategoryScreen extends GetView<CategoryController> {
  const AdvertListCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: controller.obx(
                        (categoryState) => _buildCategoryView(context, controller.animationController, categoryState),
                        onEmpty: SizedBox(),
                        onError: (error) => Text(error!)
                      ),
                    )
                  ),
                  SizedBox(height: 72.0)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget _buildCategoryView(
  BuildContext context,
  AnimationController animationController,
  List<Category>? categoryState) {

  final box = GetStorage();

  return Container(
    child: ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 0.0, bottom: 0.0, right: 12.0, left: 12.0),
      itemCount: categoryState?.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: animationController,
            curve: Interval((1 / categoryState!.length) * index, 1.0, curve: Curves.fastOutSlowIn)
          )
        );

        animationController.forward();

        final category = categoryState[index];

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 6.0, bottom: 6.0, right: 10.0, left: 10.0),
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                      border: Border.all(width: 1.0, color: AppTheme.darkText),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: AppTheme.grey.withOpacity(0.4),
                          offset: const Offset(5, 5),
                          blurRadius: 8.0
                        ),
                      ],
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(FontAwesomeIcons.tag, color: AppTheme.darkText, size: 12.0),
                        SizedBox(width: 5.0),
                        Text(
                          '${category.name}',
                          style: TextStyle(
                            color: AppTheme.darkText,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.0,
                            letterSpacing: 0.3,
                          ),
                        )
                      ],
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      splashColor: AppTheme.secondary.withOpacity(0.4),
                      borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                      onTap: () {
                        box.write('category_parent', category.slug);

                        Get.to(
                          () => AdvertCategoryScreen(),
                          arguments: {
                            'id': category.id.toString(),
                            'name': category.name,
                            'slug': category.slug,
                            'depth': category.levelDepth
                          }
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
                        child: Text(
                          'Voir tout',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: AppTheme.secondary,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                            letterSpacing: 0.3,
                          ),
                        ),
                      )
                    )
                  )
                ],
              )
            ),
            Container(
              child: CategoryListView(
                categoryParent: category,
                categories: category.children,
                animation: animation,
                animationController: animationController
              ),
            ),
          ]
        );
      }
    ),
  );
}

class CategoryListView extends StatelessWidget {
  const CategoryListView({
    Key? key,
    required this.categoryParent,
    required this.categories,
    this.animationController,
    this.animation
  }) : super(key: key);

  final Category categoryParent;
  final List<Map<String, dynamic>>? categories;
  final AnimationController? animationController;
  final Animation<double>? animation;

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {

    final box = GetStorage();
    final AdvertSubCategoryController advertSubCategoryController = Get.find();

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
          return const SizedBox();
          } else {
            return GridView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(3.0),
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: List<Widget>.generate(
                categories!.length,
                (int index) {
                  final int count = categories!.length;
                  final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animationController!,
                      curve: Interval((1 / count) * index, 1.0, curve: Curves.fastOutSlowIn),
                    ),
                  );
                  animationController?.forward();

                  final category = categories![index];

                  return CategoryView(
                    category: category,
                    animation: animation,
                    animationController: animationController,
                    callback: () {
                      final Map<String, dynamic> data = {'category': category['slug'], 'levelDepth': category['levelDepth'], 'positionOrder': 'desc'};

                      box.write('category_parent', categoryParent.slug);

                      box.write('category_id', categoryParent.id.toString());
                      box.write('category_name', categoryParent.name);
                      box.write('category_slug', categoryParent.slug);
                      box.write('category_levelDepth', categoryParent.levelDepth);

                      advertSubCategoryController.categoryParent.value = categoryParent;
                      advertSubCategoryController.category.value = new Category(id: category['id'], name: category['name'], slug: category['slug'], levelDepth: category['levelDepth']);
                      advertSubCategoryController.fetch(data);

                      (category['levelDepth'] == 1) ?
                        Get.to(() => AdvertSubCategoryScreen()) :
                        Get.to(() => AdvertSubDivisionScreen());
                    },
                  );
                }
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 0.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 0.71,
              ),
            );
          }
        }
      ),
    );
  }
}

class CategoryView extends StatelessWidget {
  const CategoryView({
    Key? key,
    required this.category,
    this.animationController,
    this.animation,
    this.callback
  }) : super(key: key);

  final Map<String, dynamic> category;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(0.0, 50 * (1.0 - animation!.value), 0.0),
            child: Container(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashColor: AppTheme.primary.withOpacity(0.1),
                  onTap: callback,
                  child: SizedBox(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                width: 80.0,
                                height: 100.0,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: AppTheme.grey.withOpacity(0.4),
                                      offset: const Offset(5, 5),
                                      blurRadius: 8.0
                                    ),
                                  ],
                                  image: (category['image'] == null) ?
                                    DecorationImage(
                                      image: ExactAssetImage('assets/images/no_photo.png'),
                                      fit: BoxFit.fill,
                                    ) :
                                    DecorationImage(
                                      image: CachedNetworkImageProvider('https://oblackmarket.com/public'+category['image']),
                                      fit: BoxFit.fill,
                                    )
                                ),
                                //child: FaIcon(category!.icon, color: AppTheme.white, size: 30.0),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 7.0, left: 7.0),
                                child: Text(
                                  category['name'],
                                  textAlign: TextAlign.left,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: AppTheme.darkText,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    letterSpacing: 0.3,
                                    overflow: TextOverflow.ellipsis
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  )
                ),
              )
            )
          ),
        );
      }
    );
  }
}


