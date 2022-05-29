import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:obm_market/constants/app_theme.dart';
import 'package:obm_market/modules/menu/controllers/menu_controller.dart';
import 'package:obm_market/modules/menu/models/tap_icon_data.dart';


class DrawerItemScreen extends StatelessWidget {
  const DrawerItemScreen({
    Key? key,
    this.changeIndex,
    this.controller}) : super(key: key);

  final Function(int index)? changeIndex;
  final MenuController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: ListTile(
            title: Row(
              children: <Widget>[
                Icon(FontAwesomeIcons.home, size: 16.0, color: AppTheme.white),
                Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Text(
                    controller!.tabIconsList[0].title,
                    style: TextStyle(
                      color: AppTheme.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                  ),
                )
              ],
            ),
            onTap: () {
              setRemoveAllSelection(controller!.tabIconsList[0]);
              changeIndex!(0);
            },
          )
        ),
        Container(
          /*height: 50.0,
          padding: EdgeInsets.only(left: 10.0),*/
          child: ListTile(
            title: Row(
              children: <Widget>[
                Icon(FontAwesomeIcons.solidClipboard, size: 16.0, color: AppTheme.white),
                Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Text(
                    'Mes '+controller!.tabIconsList[3].title.toLowerCase(),
                    style: TextStyle(
                      color: AppTheme.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                  ),
                )
              ],
            ),
            onTap: () {
              setRemoveAllSelection(controller!.tabIconsList[3]);
              changeIndex!(3);
            },
          )
        ),
        Container(
            child: ListTile(
              title: Row(
                children: <Widget>[
                  Icon(FontAwesomeIcons.solidHeart, size: 16.0, color: AppTheme.white),
                  Padding(
                    padding: EdgeInsets.only(left: 25.0),
                    child: Text(
                      controller!.tabIconsList[4].title,
                      style: TextStyle(
                        color: AppTheme.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                      ),
                    ),
                  )
                ],
              ),
              onTap: () {
                setRemoveAllSelection(controller!.tabIconsList[4]);
                changeIndex!(4);
              },
            )
        ),
        /*Container(
          height: 50.0,
          padding: EdgeInsets.only(left: 10.0),
          child: ListTile(
            title: Row(
              children: <Widget>[
                Icon(FontAwesomeIcons.solidBell, size: 16.0, color: AppTheme.white),
                Padding(
                  padding: EdgeInsets.only(left: 30.0, top: 5.0),
                  child: Text(
                    controller!.tabIconsList[5].title,
                    style: TextStyle(
                      color: AppTheme.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                  ),
                )
              ],
            ),
            onTap: () {
              setRemoveAllSelection(controller!.tabIconsList[5]);
              changeIndex!(5);
            },
          )
        ),*/
        Container(
          child: ListTile(
            title: Row(
              children: <Widget>[
                Icon(FontAwesomeIcons.solidUserCircle, size: 16.0, color: AppTheme.white),
                Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Text(
                    controller!.tabIconsList[5].title,
                    style: TextStyle(
                      color: AppTheme.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                  ),
                )
              ],
            ),
            onTap: () {
              setRemoveAllSelection(controller!.tabIconsList[5]);
              changeIndex!(5);
            },
          )
        ),
      ],
    );
  }

  void setRemoveAllSelection(TabIconData? tabIconData) {
    controller!.tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;

      if (tabIconData!.index == tab.index) {
        tab.isSelected = true;
      }
    });
  }
}

