import 'package:equatable/equatable.dart';
import 'package:obm_market/modules/location/models/entities/zone.dart';

class ZoneResponse extends Equatable {
  const ZoneResponse({required this.name});

  final String name;

  @override
  List<Object?> get props => [name];

  Zone toEntity() {
    return Zone(name: name);
  }

  factory ZoneResponse.fromMap(Map<String, dynamic> map) {
    return ZoneResponse(
      name: map['zone'] ?? '',
    );
  }
}

