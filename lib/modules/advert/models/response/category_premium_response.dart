import 'package:equatable/equatable.dart';
import 'package:obm_market/modules/advert/models/entities/categoryPremium.dart';

class CategoryPremiumResponse extends Equatable {
  const CategoryPremiumResponse({
    required this.id,
    required this.name,
    required this.categories,
  });

  final int id;
  final String name;
  final List<Map<String, dynamic>> categories;

  @override
  List<Object?> get props => [
    id,
    name,
    categories
  ];

  CategoryPremium toEntity() {
    return CategoryPremium(
      id: id,
      name: name,
      categories: categories);
  }

  factory CategoryPremiumResponse.fromMap(Map<String, dynamic> map) {
    return CategoryPremiumResponse(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      categories: List<Map<String, dynamic>>.from(map['categories'] ?? []),
    );
  }
}




