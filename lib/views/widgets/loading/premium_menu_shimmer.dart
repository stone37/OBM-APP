import 'package:flutter/material.dart';
import 'package:obm_market/constants/app_theme.dart';
import 'package:shimmer/shimmer.dart';

class PremiumMenuShimmer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 20,
          padding: EdgeInsets.only(top: 6.0),
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: Shimmer.fromColors(
            child: Container(
              color: Colors.white,
            ),
            baseColor: AppTheme.grey.withOpacity(0.3),
            highlightColor: AppTheme.grey.withOpacity(0.1)
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(3.0),
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: 10,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20.0,
              crossAxisSpacing: 20.0,
              childAspectRatio: 1.4,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      width: 160.0,
                      height: 100.0,
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
                          baseColor: AppTheme.grey.withOpacity(0.3),
                          highlightColor: AppTheme.grey.withOpacity(0.1)
                      ),
                    )
                  ]
                ),
              );
            },
          ),
        )
      ],
    );
  }
}



