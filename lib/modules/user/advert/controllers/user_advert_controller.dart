import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:obm_market/modules/user/advert/respository/user_advert_repository.dart';

import '../../../../views/widgets/message/successMessage.dart';
import '../../../advert/models/entities/advert.dart';
import '../../../advert/repository/advert_repository.dart';
import '../../thread/models/entities/thread.dart';
import '../../thread/repository/thread_repository.dart';

class UserAdvertController extends GetxController {

  final box = GetStorage();
  Advert? advert;
  AdvertData? advertData;
  RxList advertId = [].obs;

  void onInit() {
    super.onInit();
  }

  Future<List<Advert>> getAdvert(int id) async {
    return await UserAdvertRepository().getAdvert(userId: id);
  }

  Future<List<Advert>> getAdvertEnabled(int id) async {
    return await UserAdvertRepository().getAdvertEnabled(userId: id);
  }

  Future<List<Advert>> getUserAdvert() async {
    return await UserAdvertRepository().getAdvert(userId: box.read('user_id'));
  }

  Future<List<Advert>> getUserAdvertEnabled() async {
    return await UserAdvertRepository().getAdvertEnabled(userId: box.read('user_id'));
  }

  delete(int id) async {
    advertData = await AdvertRepository().delete(id: id, token: box.read('token'));

    print(advertData);

    if (advertData!.status == '200') {
      advertId.remove(id);

      showSuccessMessage(message: 'Votre annonce a bien été supprimer.');
    }
  }

  Future<bool?> checkThread({required int id}) async {

    if (!box.hasData('token')) return null;

    advertData = await AdvertRepository().checkThread(id: id, token: box.read('token'));

    if (advertData!.status == '200') {
      return advertData!.data;
    }

    return false;
  }

  Future<Thread?> findThread({required advertId}) async {
    if (!box.hasData('token')) return null;

    return await ThreadRepository().find(advertId: advertId, token: box.read('token'));
  }
}

