import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:obm_market/modules/advert/models/entities/advert.dart';
import 'package:obm_market/modules/user/favorite/models/entities/favorite.dart';
import 'package:obm_market/modules/user/favorite/repository/favorite_repository.dart';
import 'package:obm_market/views/widgets/message/successMessage.dart';

import '../../../advert/repository/advert_repository.dart';

class FavoriteController extends GetxController {

  final box = GetStorage();
  RxSet saved = Set().obs;
  RxSet showSaved = Set().obs;
  RxList userSaved = [].obs;
  AdvertData? advertData;

  add(int id) async {
    final favorite = await FavoriteRepository().create(id: id, token: box.read('token'));

    if (favorite.status == '201') {
      showSuccessMessage(message: 'L\'annonce a été ajouter a vos favoris.');
    }
  }

  delete(int id) async {
    final favorite = await FavoriteRepository().delete(id: id, token: box.read('token'));

    if (favorite.status == '204') {
      showSuccessMessage(message: 'L\'annonce a été retirer a vos favoris.');
    }
  }

  Future<bool> check(int id) async {
    final checkData = await FavoriteRepository().check(id: id, token: box.read('token'));

    if (checkData.status == '200') {
      return checkData.message!;
    }

    return false;
  }

  Future<bool?> checkAdvert({required int id}) async {
    if (!box.hasData('token')) return null;

    advertData = await AdvertRepository().check(id: id, token: box.read('token'));

    if (advertData!.status == '200') {
      return advertData!.data;
    }

    return false;
  }

  Future<List<Favorite>> getFavorite() async {
    return await FavoriteRepository().getFavorites(id: box.read('user_id'), token: box.read('token'));
  }
}

