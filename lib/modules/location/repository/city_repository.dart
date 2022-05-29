import 'package:obm_market/modules/location/models/entities/city.dart';
import 'package:obm_market/modules/location/models/request/city_request.dart';
import 'package:obm_market/modules/location/services/remote_city_api.dart';

class CityRepository {

  Future<List<City>> getCities({String? name}) {
    return RemoteCityApi
        .getCities(CityRequest(name: name))
        .then((value) => value.map((e) => e.toEntity()).toList());
  }
}

