import 'package:flutter/material.dart';
import 'package:obm_market/constants/app_theme.dart';
import 'package:shimmer/shimmer.dart';

class AdvertListShimmer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: 5,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0, left: 0.0, right: 0.0),
            child: Column(
              children: <Widget>[
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        height: 140,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        child: Shimmer.fromColors(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                              color: Colors.white,
                            ),
                          ),
                          baseColor: AppTheme.grey.withOpacity(0.1),
                          highlightColor: AppTheme.grey.withOpacity(0.1)
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        }),
    );
  }
}



