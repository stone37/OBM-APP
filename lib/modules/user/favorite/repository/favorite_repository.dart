import 'package:obm_market/modules/user/favorite/models/entities/favorite.dart';
import 'package:obm_market/modules/user/favorite/models/entities/favorite_check.dart';
import 'package:obm_market/modules/user/favorite/models/request/favorite_request.dart';
import 'package:obm_market/modules/user/favorite/services/remote_favorite_api.dart';

class FavoriteRepository {

  Future<Favorite> create({required int id, required String token}) {
    return RemoteFavoriteApi.create(FavoriteRequest(advertId: id, token: token))
      .then((value) => value.toEntity());
  }

  Future<List<Favorite>> getFavorites({required int id, required String token}) {
    return RemoteFavoriteApi.getFavorites(UserFavoriteRequest(userId: id, token: token))
      .then((value) => value.map((e) => e.toEntity()).toList());
  }

  Future<FavoriteCheck> check({required int id, required String token}) {
    return RemoteFavoriteApi.check(FavoriteRequest(advertId: id, token: token))
        .then((value) => value.toEntity());
  }

  Future<Favorite> delete({required int id, required String token})  {
    return RemoteFavoriteApi.delete(FavoriteRequest(advertId: id, token: token))
        .then((value) => value.toEntity());
  }
}
