import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:obm_market/modules/user/notification/models/entities/notification.dart';

import '../repository/notification_repository.dart';

class NotificationController extends GetxController {
  final box = GetStorage();
  RxList notificationId = [].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<List<UserNotification>> getUserNotification() async {
    return await NotificationRepository().findAll(token: box.read('token'));
  }

  Future<NotificationData> getUserNrUnReadNotification() async {
    return await NotificationRepository().nbUnread(token: box.read('token'));
  }



}

