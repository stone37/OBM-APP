import 'package:equatable/equatable.dart';

class CategoryPremium extends Equatable {
  const CategoryPremium({
    required this.id,
    required this.name,
    required this.categories
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
}

