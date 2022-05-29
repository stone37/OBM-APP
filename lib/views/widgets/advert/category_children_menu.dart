import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:obm_market/constants/app_theme.dart';
import 'package:obm_market/modules/advert/controllers/advert_sub_category_controller.dart';
import 'package:obm_market/modules/advert/controllers/advert_sub_division_controller.dart';
import 'package:obm_market/modules/advert/controllers/category_controller.dart';
import 'package:obm_market/modules/advert/models/entities/category.dart';
import 'package:obm_market/views/screens/advert/index/advert_sub_category_screen.dart';
import 'package:obm_market/views/screens/advert/index/advert_sub_division_screen.dart';
import 'package:obm_market/views/widgets/loading/category_menu_shimmer.dart';


class CategoryChildrenMenu extends StatelessWidget {
  CategoryChildrenMenu({Key? key, required this.id}) : super(key: key);

  final int id;
  final AdvertSubCategoryController advertSubCategoryController = Get.find();
  final AdvertSubDivisionController advertSubDivisionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: GetBuilder<CategoryController>(
        builder: (controller) => FutureBuilder<Category?>(
          future: controller.getCategory(id),
          builder: (BuildContext context, AsyncSnapshot<Category?> snapshot) {
            if (!snapshot.hasData) {
              return CategoryMenuShimmer();
            } else {
              return (snapshot.data!.children!.isEmpty) ?
              const SizedBox() :
              _buildCategoryView(context, controller.animationController, snapshot.data!);
            }
          },
        )
      )
    );
  }

  Widget _buildCategoryView(
      BuildContext context,
      AnimationController animationController,
      Category category) {

    final box = GetStorage();

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      width: double.infinity,
      height: 130.0,
      child: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 0.0, bottom: 0.0, right: 16.0, left: 10.0),
        itemCount: category.children!.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {

          final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animationController,
              curve: Interval((1 / category.children!.length) * index, 1.0, curve: Curves.fastOutSlowIn)
            )
          );
          animationController.forward();

          return CategoryView(
            category: category.children![index],
            animation: animation,
            animationController: animationController,
            callback: () {
              final categoryChild =  category.children![index];
              final Map<String, dynamic> data = {'category': categoryChild['slug'], 'levelDepth': categoryChild['levelDepth'], 'positionOrder': 'desc'};

              if (categoryChild['levelDepth'] == 1) {
                box.write('sub_category_id', categoryChild['id'].toString());
                box.write('sub_category_name', categoryChild['name']);
                box.write('sub_category_slug', categoryChild['slug']);
                box.write('sub_category_levelDepth', categoryChild['levelDepth']);

                advertSubCategoryController.categoryParent.value = category;
                advertSubCategoryController.category.value = new Category(id: categoryChild['id'], name: categoryChild['name'], slug: categoryChild['slug'], levelDepth: categoryChild['levelDepth']);
                advertSubCategoryController.fetch(data);
              } else {
                advertSubDivisionController.categoryParent.value = category;
                advertSubDivisionController.category.value = new Category(id: categoryChild['id'], name: categoryChild['name'], slug: categoryChild['slug'], levelDepth: categoryChild['levelDepth']);
                advertSubDivisionController.fetch(data);
              }

              (category.children![index]['levelDepth'] == 1) ?
                Get.to(() => AdvertSubCategoryScreen()) :
                Get.to(() => AdvertSubDivisionScreen());
            },
          );
        }
      ),
    );
  }
}

class CategoryView extends StatelessWidget {
  const CategoryView(
      {Key? key,
        required this.category,
        this.animationController,
        this.animation,
        this.callback}
        )
      : super(key: key);

  final VoidCallback? callback;
  final Map<String, dynamic> category;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController!,
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(
              opacity: animation!,
              child: Transform(
                transform: Matrix4.translationValues(100 * (1.0 - animation!.value), 0.0, 0.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  onTap: callback,
                  child: SizedBox(
                    width: 80,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                             (category.containsKey('image')) ?
                                imageData(category['image']) : notImageData(),
                              Container(
                                padding: EdgeInsets.only(top: 8.0, right: 5.0, left: 5.0),
                                child: Text(
                                  category['name'],
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                  style: TextStyle(
                                    color: AppTheme.darkText,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.0,
                                    letterSpacing: 0.3,
                                    overflow: TextOverflow.ellipsis
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                )
              )
          );
        },
    );
  }


  Widget imageData(String url) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      width: 60,
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(50.0)),
        border: Border.all(width: 2.0, color: AppTheme.primary),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppTheme.grey.withOpacity(0.4),
            offset: const Offset(5, 5),
            blurRadius: 8.0
          ),
        ],
        image: DecorationImage(
          image: CachedNetworkImageProvider('https://oblackmarket.com/public/' + url),
          fit: BoxFit.cover,
        )
      ),
    );
  }

  Widget notImageData() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 9.0),
      width: 60.0,
      height: 60.0,
      decoration: BoxDecoration(
        color: AppTheme.background,
        borderRadius: const BorderRadius.all(Radius.circular(30.0)),
        border: Border.all(width: 2.0, color: AppTheme.primary),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppTheme.grey.withOpacity(0.4),
            offset: const Offset(5, 5),
            blurRadius: 8.0
          ),
        ]
      ),
      alignment: Alignment.center,
      child: FaIcon(FontAwesomeIcons.tag, color: AppTheme.primary, size: 19.0),
    );
  }
}

