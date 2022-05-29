import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:obm_market/constants/app_theme.dart';
import 'package:obm_market/modules/advert/controllers/premium_controller.dart';
import 'package:obm_market/views/screens/advert/index/advert_sub_category_screen.dart';
import 'package:obm_market/views/screens/advert/index/advert_sub_division_screen.dart';
import 'package:obm_market/views/widgets/loading/premium_menu_shimmer.dart';

import '../../../modules/advert/controllers/advert_sub_category_controller.dart';
import '../../../modules/advert/controllers/advert_sub_division_controller.dart';
import '../../../modules/advert/models/entities/category.dart';

class Premium extends StatelessWidget {

  final PremiumController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 3.0, right: 3.0),
      child: controller.obx(
        (premiumState) => ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 0.0, bottom: 0.0, right: 16.0, left: 16.0),
          itemCount: premiumState?.length,
          physics: NeverScrollableScrollPhysics(), //BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {

            final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: controller.animationController,
                  curve: Interval((1 / premiumState!.length) * index, 1.0, curve: Curves.fastOutSlowIn)
              )
            );

            controller.animationController.forward();

            final premium = premiumState[index];

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    'Populaire dans ${premium.name.toLowerCase()}',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                      letterSpacing: 0.3,
                      color: AppTheme.primary,
                    ),
                  ),
                ),

                Container(
                  child: PremiumListView(
                    categories: premium.categories,
                    animation: animation,
                    animationController: controller.animationController
                  ),
                ),
              ]
            );
          }
        ),
        onLoading: PremiumMenuShimmer(),
        onEmpty: SizedBox(),
        onError: (error) => Text(error!),
      ),
    );
  }
}

class PremiumListView extends StatelessWidget {
  PremiumListView(
      {Key? key,
        required this.categories,
        this.animationController,
        this.animation}
      )
      : super(key: key);

  final List<Map<String, dynamic>> categories;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final AdvertSubCategoryController advertSubCategoryController = Get.find();
  final AdvertSubDivisionController advertSubDivisionController = Get.find();

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();

    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 28.0),
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
                  categories.length,
                    (int index) {
                    final int count = categories.length;
                    final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: animationController!,
                        curve: Interval((1 / count) * index, 1.0, curve: Curves.fastOutSlowIn),
                      ),
                    );
                    animationController?.forward();

                    final category = categories[index];

                    return PremiumView(
                      category: category,
                      animation: animation,
                      animationController: animationController,
                      callback: () {
                        final Map<String, dynamic> data = {'category': category['slug'], 'levelDepth': category['levelDepth'], 'positionOrder': 'desc'};

                        box.write('category_parent', category['parent']['slug']);

                        box.write('category_id', category['parent']['id'].toString());
                        box.write('category_name', category['parent']['name']);
                        box.write('category_slug', category['parent']['slug']);
                        box.write('category_levelDepth', category['parent']['levelDepth']);

                        if (categories[index]['levelDepth'] == 1) {
                          box.write('sub_category_id', category['id'].toString());
                          box.write('sub_category_name', category['name']);
                          box.write('sub_category_slug', category['slug']);
                          box.write('sub_category_levelDepth', category['levelDepth']);

                          advertSubCategoryController.categoryParent.value = new Category(
                              id: category['parent']['id'],
                              name:category['parent']['name'],
                              slug: category['parent']['slug'],
                              levelDepth: category['parent']['levelDepth']);

                          advertSubCategoryController.category.value = new Category(id: category['id'], name: category['name'], slug: category['slug'], levelDepth: category['levelDepth']);
                          advertSubCategoryController.fetch(data);
                        } else {
                          box.write('sub_category_id', category['parent']['current_id'].toString());
                          box.write('sub_category_name', category['parent']['current_name']);
                          box.write('sub_category_slug', category['parent']['current_slug']);
                          box.write('sub_category_levelDepth', category['parent']['current_level_depth']);

                          print(category['parent']['name']);
                          print(category['parent']['current_name']);

                          advertSubCategoryController.categoryParent.value = new Category(
                              id: category['parent']['id'],
                              name:category['parent']['name'],
                              slug: category['parent']['slug'],
                              levelDepth: category['parent']['levelDepth']);

                          advertSubDivisionController.categoryParent.value = new Category(
                              id: category['parent']['current_id'],
                              name: category['parent']['current_name'],
                              slug: category['parent']['current_slug'],
                              levelDepth: category['parent']['current_level_depth']);

                          advertSubDivisionController.category.value = new Category(id: category['id'], name: category['name'], slug: category['slug'], levelDepth: category['levelDepth']);
                          advertSubDivisionController.fetch(data);
                        }

                        (categories[index]['levelDepth'] == 1) ?
                          Get.to(() => AdvertSubCategoryScreen()) :
                          Get.to(() => AdvertSubDivisionScreen());
                      },
                    );
                  }
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 20.0,
                childAspectRatio: 1.4,
              ),
            );
          }
        },
      ),
    );
  }

}

class PremiumView extends StatelessWidget {
  const PremiumView(
      {Key? key,
        required this.category,
        this.animationController,
        this.animation,
        this.callback})
      : super(key: key);

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
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                      topRight: Radius.circular(30.0)
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: AppTheme.grey.withOpacity(0.4),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 3.75
                      ),
                    ],
                    image: DecorationImage(
                      image: CachedNetworkImageProvider('https://oblackmarket.com/public'+category['image']),
                      //NetworkImage('https://oblackmarket.com/public'+category['image']),
                      fit: BoxFit.fill,
                    )
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                      splashColor: AppTheme.nearlyBlue.withOpacity(0.2),
                      onTap: callback,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(left: 20, right: 20),
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                                decoration: BoxDecoration(
                                  color: AppTheme.primary.withOpacity(0.8),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(30.0),
                                    bottomLeft: Radius.circular(30.0),
                                    bottomRight: Radius.circular(30.0),
                                    topRight: Radius.circular(30.0)
                                  )
                                ),
                                child: Text(
                                  category['name'],
                                  style: TextStyle(
                                    color: AppTheme.white,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.3,
                                    fontSize: 13.0
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
          );
        }
    );
  }
}

