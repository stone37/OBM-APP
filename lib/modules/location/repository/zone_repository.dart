import 'package:obm_market/modules/location/models/entities/zone.dart';
import 'package:obm_market/modules/location/models/request/zone_request.dart';
import 'package:obm_market/modules/location/services/remote_zone_api.dart';

class ZoneRepository {

  Future<List<Zone>> getZones({required String name}) {
    return RemoteZoneApi
        .getZones(ZoneRequest(city: name))
        .then((value) => value.map((e) => e.toEntity()).toList());
  }
}

