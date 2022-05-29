import 'package:flutter/material.dart';
import 'package:obm_market/constants/app_theme.dart';
import 'package:shimmer/shimmer.dart';

class CategoryMenuShimmer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 110,
      child: ListView.builder(
        itemCount: 5,
        padding: const EdgeInsets.only(top: 5.0, bottom: 0.0, right: 16.0, left: 10.0),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 0.0, left: 0.0, right: 0.0),
            child: SizedBox(
                width: 80,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 7.0),
                            width: 65,
                            height: 65,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(50.0)),
                            ),
                            child: Shimmer.fromColors(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                  color: Colors.white,
                                ),
                              ),
                              baseColor: AppTheme.grey.withOpacity(0.3),
                              highlightColor: AppTheme.grey.withOpacity(0.1)
                            ),
                          ),
                          Container(
                            width: 45,
                            height: 15,
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(top: 6.0),
                            margin: EdgeInsets.symmetric(horizontal: 10.0),
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
                    )
                  ],
                )
            ),
          );
        }),
    );
  }
}



