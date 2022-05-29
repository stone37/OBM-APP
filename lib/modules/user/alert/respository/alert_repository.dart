import 'package:obm_market/modules/user/alert/models/entities/alert.dart';
import 'package:obm_market/modules/user/alert/models/request/alert_request.dart';
import 'package:obm_market/modules/user/alert/services/remote_alert_api.dart';

class AlertRepository {
  Future<Alert> create({required int categoryId, required String token}) {
    return RemoteAlertApi.create(AlertCreateRequest(categoryId: categoryId, token: token))
      .then((value) => value.toEntity());
  }

  Future<AlertData> changeStatus({required int id, required String token}) {
    return RemoteAlertApi.changeStatus(AlertRequest(id: id, token: token))
        .then((value) => value!.toEntity());
  }

  Future<AlertData> delete({required int id, required String token}) {
    return RemoteAlertApi.delete(AlertRequest(id: id, token: token))
        .then((value) => value!.toEntity());
  }

  Future<List<Alert>> getAlerts({required int userId, required String token}) {
    return RemoteAlertApi.getAlerts(AlertRequest(id: userId, token: token))
        .then((value) => value.map((e) => e.toEntity()).toList());
  }

  Future<List<Alert>> getAlertEnabled({required int userId, required String token}) {
    return RemoteAlertApi.getAlertEnabled(AlertRequest(id: userId, token: token))
        .then((value) => value.map((e) => e.toEntity()).toList());
  }
}
