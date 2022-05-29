import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants/app_theme.dart';

class TabIconData {
  TabIconData({
    required this.title,
    required this.icon,
    required this.selectedIcon,
    this.index = 0,
    this.isSelected = false,
    this.animationController,
  });

  String title;
  Icon icon;
  Icon selectedIcon;
  bool isSelected;
  int index;
  AnimationController? animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      title: 'Accueil',
      icon: Icon(FontAwesomeIcons.home, color: AppTheme.white, size: 28.0),
      selectedIcon: Icon(FontAwesomeIcons.home, color: AppTheme.secondary, size: 28.0),
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    TabIconData(
      title: 'Catégories',
      icon: Icon(FontAwesomeIcons.th, color: AppTheme.white, size: 28.0),
      selectedIcon: Icon(FontAwesomeIcons.th, color: AppTheme.secondary, size: 28.0),
      index: 1,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      title: 'Messages',
      icon: Icon(FontAwesomeIcons.comment, color: AppTheme.white, size: 28.0),
      selectedIcon: Icon(FontAwesomeIcons.solidComment, color: AppTheme.secondary, size: 28.0),
      index: 2,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      title: 'Annonces',
      icon: Icon(FontAwesomeIcons.clipboard, color: AppTheme.white, size: 28.0),
      selectedIcon: Icon(FontAwesomeIcons.solidClipboard, color: AppTheme.secondary, size: 28.0),
      index: 3,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      title: 'Mes favoris',
      icon: Icon(FontAwesomeIcons.heart, color: AppTheme.white, size: 28.0),
      selectedIcon: Icon(FontAwesomeIcons.solidHeart, color: AppTheme.secondary, size: 28.0),
      index: 4,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      title: 'Mon profil',
      icon: Icon(FontAwesomeIcons.userCircle, color: AppTheme.white, size: 28.0),
      selectedIcon: Icon(FontAwesomeIcons.solidUserCircle, color: AppTheme.secondary, size: 28.0),
      index: 5,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      title: 'Déposer une annonce',
      icon: Icon(FontAwesomeIcons.userCircle, color: AppTheme.white, size: 28.0),
      selectedIcon: Icon(FontAwesomeIcons.solidUserCircle, color: AppTheme.secondary, size: 28.0),
      index: 6,
      isSelected: false,
      animationController: null,
    ),
  ];
}
