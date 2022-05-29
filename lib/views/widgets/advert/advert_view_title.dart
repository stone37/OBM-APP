import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:obm_market/constants/app_theme.dart';
import 'package:obm_market/modules/advert/controllers/category_controller.dart';
import 'package:obm_market/modules/advert/models/entities/category.dart';
import 'package:obm_market/views/widgets/loading/advert_title_shimmer.dart';

class AdvertViewTitle extends StatelessWidget {
  const AdvertViewTitle({Key? key, required this.id, this.city}) : super(key: key);

  final int id;
  final String? city;

  @override
  Widget build(BuildContext context) {

    return GetBuilder<CategoryController>(
        builder: (controller) => FutureBuilder<Category?>(
          future: controller.getCategory(id),
          builder: (BuildContext context, AsyncSnapshot<Category?> snapshot) {
            if (!snapshot.hasData) {
              return AdvertTitleShimmer();
            } else {
              return _buildDataView(context, snapshot.data!);
            }
          },
        )
    );
  }

  Widget _buildDataView(BuildContext context, Category category) {
    return Padding(
      padding: const EdgeInsets.only(left: 14.0, right: 14.0, bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0, bottom: 8.0),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.50,
            ),
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: const BorderRadius.all(Radius.circular(50.0)),
              border: Border.all(width: 0.6, color: AppTheme.grey.withOpacity(0.5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: AppTheme.grey.withOpacity(0.2),
                  offset: const Offset(3, 3),
                  blurRadius: 8.0
                ),
              ],
            ),
            child: Text(
              category.name,
              maxLines: 2,
              softWrap: true,
              style: TextStyle(
                color: AppTheme.darkerText.withOpacity(0.9),
                fontSize: 13.0,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.3,
              ),
            ),
          ),
          (city != null && city!.isNotEmpty) ?
            Container(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0, bottom: 8.0),
              margin:  const EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                border: Border.all(width: 0.6, color: AppTheme.grey.withOpacity(0.5)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: AppTheme.grey.withOpacity(0.2),
                    offset: const Offset(3, 3),
                    blurRadius: 8.0
                  ),
                ],
              ),
              child: Text(
                '$city',
                style: TextStyle(
                  color: AppTheme.darkerText.withOpacity(0.9),
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.3,
                ),
              ),
            ) : SizedBox()
        ],
      ),
    );
  }
}


