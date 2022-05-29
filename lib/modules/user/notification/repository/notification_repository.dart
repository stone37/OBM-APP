import '../models/entities/notification.dart';
import '../models/request/notification_request.dart';
import '../services/remote_notification_api.dart';

class NotificationRepository {

  Future<List<UserNotification>> findAll({required String token}) {
    return RemoteNotificationApi.findAll(NotificationRequest(token: token))
        .then((value) => value.map((e) => e.toEntity()).toList());
  }

  Future<List<UserNotification?>> findUnread({required String token}) {
    return RemoteNotificationApi.findAllUnread(NotificationRequest(token: token))
        .then((value) => value.map((e) => e.toEntity()).toList());
  }

  Future<NotificationData> nbUnread({required String token}) {
    return RemoteNotificationApi.nbUnread(NotificationRequest(token: token))
        .then((value) => value!.toEntity());
  }
}

