import 'package:flutter/material.dart';
import 'package:obm_market/constants/app_theme.dart';
import 'package:shimmer/shimmer.dart';

class AdvertTitleShimmer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 100,
            height: 18,
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 6.0),
            margin: EdgeInsets.only(left: 10.0, right: 5.0, bottom: 10.0),
            child: Shimmer.fromColors(
              child: Container(
                color: Colors.white,
              ),
              baseColor: AppTheme.grey.withOpacity(0.3),
              highlightColor: AppTheme.grey.withOpacity(0.1)
            ),
          ),
          Container(
            width: 100,
            height: 18,
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 6.0),
            margin: EdgeInsets.only(left: 10.0, right: 5.0, bottom: 10.0),
            child: Shimmer.fromColors(
              child: Container(
                color: Colors.white,
              ),
              baseColor: AppTheme.grey.withOpacity(0.3),
              highlightColor: AppTheme.grey.withOpacity(0.1)
            ),
          ),
        ],
      ),
    );
  }
}



