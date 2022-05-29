import 'package:equatable/equatable.dart';
import 'package:obm_market/modules/location/models/entities/city.dart';

class CityResponse extends Equatable {
  const CityResponse({
    required this.name,
    required this.slug,
    required this.countryCode
  });

  final String name;
  final String slug;
  final String countryCode;

  @override
  List<Object?> get props => [name, slug, countryCode];

  City toEntity() {
    return City(
      name: name,
      slug: slug,
      countryCode: countryCode
    );
  }

  factory CityResponse.fromMap(Map<String, dynamic> map) {
    return CityResponse(
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
      countryCode: map['countryCode'] ?? '',
    );
  }
}

