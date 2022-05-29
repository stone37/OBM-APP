import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:obm_market/constants/app_theme.dart';
import 'package:obm_market/modules/advert/controllers/advert_category_controller.dart';
import 'package:obm_market/modules/advert/controllers/category_controller.dart';
import 'package:obm_market/modules/advert/models/entities/category.dart';
import 'package:obm_market/views/screens/advert/index/advert_category_screen.dart';
import 'package:obm_market/views/widgets/loading/category_menu_shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CategoryMenu extends GetView<CategoryController> {

  final box = GetStorage();
  final AdvertCategoryController advertCategoryController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: controller.obx(
        (categoryState) => _buildCategoryView(context, controller.animationController, categoryState),
        onLoading: CategoryMenuShimmer(),
        onEmpty: SizedBox(),
        onError: (error) => Text(error!)
      )
    );
  }

  Widget _buildCategoryView(
      BuildContext context,
      AnimationController animationController,
      List<Category>? categories) {

    return Container(
      width: double.infinity,
      height: 110,
      child: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 0.0, bottom: 0.0, right: 16.0, left: 10.0),
        itemCount: categories?.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {

          final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animationController,
              curve: Interval((1 / categories!.length) * index, 1.0, curve: Curves.fastOutSlowIn)
            )
          );

          animationController.forward();

          return CategoryView(
            category: categories[index],
            animation: animation,
            animationController: animationController,
            callback: () {
              final category = categories[index];
              final Map<String, dynamic> data = {'category': category.slug, 'levelDepth': category.levelDepth, 'positionOrder': 'desc'};

              box.write('category_parent', category.slug);
              box.write('category_id', category.toString());
              box.write('category_name', category.name);
              box.write('category_slug', category.slug);
              box.write('category_levelDepth', category.levelDepth);

              advertCategoryController.category.value = category;
              advertCategoryController.fetch(data);

              Get.to(() => AdvertCategoryScreen());
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
        this.category,
        this.animationController,
        this.animation,
        this.callback}
        )
      : super(key: key);

  final VoidCallback? callback;
  final Category? category;
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
                      width: 80,
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 7.0),
                                  width: 65,
                                  height: 65,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    //color: AppTheme.primary,
                                      borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                          color: AppTheme.grey.withOpacity(0.4),
                                          offset: const Offset(5, 5),
                                          blurRadius: 8.0
                                        ),
                                      ],
                                      image: DecorationImage(
                                        //image: NetworkImage('https://oblackmarket.com/public'+category!.imageUrl!),
                                        image: CachedNetworkImageProvider('https://oblackmarket.com/public/' + category!.imageUrl!),
                                        fit: BoxFit.fill,
                                      )
                                  ),
                                  //child: FaIcon(category!.icon, color: AppTheme.white, size: 30.0),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    category!.name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppTheme.darkText,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.5,
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ),
                ),
              )
            )
        );
      },
    );
  }
}
