import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:obm_market/modules/advert/models/entities/category.dart';

class CategoryResponse extends Equatable {
  const CategoryResponse({
    required this.id,
    required this.name,
    required this.slug,
    required this.icon,
    required this.imageUrl,
    required this.advert,
    required this.levelDepth,
    required this.parent,
    required this.children
  });

  final int id;
  final String name;
  final String slug;
  final String icon;
  final String imageUrl;
  final int advert;
  final int levelDepth;
  final int parent;
  final List<Map<String, dynamic>> children;

  @override
  List<Object?> get props => [
    id,
    name,
    slug,
    icon,
    imageUrl,
    advert,
    children,
    parent,
    levelDepth
  ];

  Category toEntity() {
    return Category(
      id: id,
      name: name,
      slug: slug,
      icon: getIcon(icon),
      imageUrl: imageUrl,
      advert: advert,
      levelDepth: levelDepth,
      parent: parent,
      children: children);
  }

  factory CategoryResponse.fromMap(Map<String, dynamic> map) {
    print(map['advert']);

    return CategoryResponse(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
      icon: map['icon'] ?? '',
      imageUrl: map['image'] ?? '',
      advert: map['advert'] ?? '',
      parent: map['parent'] ?? '',
      levelDepth: map['levelDepth'] ?? '',
      children: List<Map<String, dynamic>>.from(map['children'] ?? []),
    );
  }

  IconData? getIcon(String? icon) {
    if (icon == 'fas fa-car')
      return FontAwesomeIcons.car;
    else if (icon == 'fas fa-building')
      return FontAwesomeIcons.building;
    else if (icon == 'fas fa-store')
      return FontAwesomeIcons.store;
    else if (icon == 'fas fa-wrench')
      return FontAwesomeIcons.wrench;
    else if (icon == 'fas fa-briefcase')
      return FontAwesomeIcons.briefcase;
    else if (icon == 'fab fa-gratipay')
      return FontAwesomeIcons.gratipay;
    else if (icon == 'fas fa-paw')
      return FontAwesomeIcons.paw;
    else
      return null;
  }
}

