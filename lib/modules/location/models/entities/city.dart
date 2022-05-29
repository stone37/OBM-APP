import 'package:equatable/equatable.dart';

class City extends Equatable {
  const City({
    required this.name,
    required this.slug,
    required this.countryCode
  });

  final String name;
  final String slug;
  final String countryCode;

  @override
  List<Object?> get props => [
    name,
    slug,
    countryCode
  ];
}


