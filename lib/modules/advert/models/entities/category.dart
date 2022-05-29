import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Category extends Equatable {
  const Category({
    required this.id,
    required this.name,
    this.slug,
    this.icon,
    this.imageUrl,
    this.advert,
    this.levelDepth,
    this.parent,
    this.parentId,
    this.parentName,
    this.parentSlug,
    this.parentLevelDepth,
    this.children
  });

  final int id;
  final String name;
  final String? slug;
  final IconData? icon;
  final String? imageUrl;
  final int? advert;
  final int? levelDepth;
  final int? parent;
  final int? parentId;
  final String? parentName;
  final String? parentSlug;
  final int? parentLevelDepth;
  final List<Map<String, dynamic>>? children;


  @override
  List<Object?> get props => [
    id,
    name,
    slug,
    icon,
    imageUrl,
    advert,
    levelDepth,
    parent,
    parentId,
    parentName,
    parentSlug,
    parentLevelDepth,
    children
  ];
}

