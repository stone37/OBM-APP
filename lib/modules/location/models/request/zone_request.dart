import 'package:equatable/equatable.dart';

class ZoneRequest extends Equatable {
  const ZoneRequest({required this.city});

  final String city;

  @override
  List<Object?> get props => [city];

  Map<String, dynamic> toMap() {
    final queryParameters = {'city.name': city};

    return queryParameters;
  }
}