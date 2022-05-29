import '../../../advert/models/entities/advert.dart';
import '../models/request/user_advert_request.dart';
import '../services/remote_user_advert_api.dart';

class UserAdvertRepository {
  Future<List<Advert>> getAdvert({required int userId}) {
    return RemoteUserAdvertApi.getAdvert(UserAdvertRequest(id: userId))
        .then((value) => value.map((e) => e.toEntity()).toList());
  }

  Future<List<Advert>> getAdvertEnabled({required int userId}) {
    return RemoteUserAdvertApi.getAdvertEnabled(UserAdvertRequest(id: userId))
        .then((value) => value.map((e) => e.toEntity()).toList());
  }
}
