import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../screens/advert/search/search_screen.dart';

class SearchIcon extends StatelessWidget {
  const SearchIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10.0),
      child: IconButton(
        onPressed: () {
          Get.to(
            () => SearchScreen(),
            transition: Transition.cupertino,
            duration: Duration(milliseconds: 500)
          );
        },
        icon: Icon(FontAwesomeIcons.search, size: 18.0),
        splashRadius: 20.0,
      ),
    );
  }
}
