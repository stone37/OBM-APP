import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:obm_market/modules/user/alert/respository/alert_repository.dart';
import 'package:obm_market/views/widgets/message/successMessage.dart';

import '../models/entities/alert.dart';

class AlertController extends GetxController {

  final box = GetStorage();

  add(int categoryId) async {
    final alert = await AlertRepository().create(categoryId: categoryId, token: box.read('token'));

    if (alert.status == '201') {
      showSuccessMessage(message: 'Votre alerte a été créer.');
    }
  }

  delete(int id) async {
    final alert = await AlertRepository().delete(id: id, token: box.read('token'));

    if (alert.status == '204') {
      showSuccessMessage(message: alert.message.toString());
    }
  }

  changeStatus(int id) async {
    final alert = await AlertRepository().changeStatus(id: id, token: box.read('token'));

    if (alert.status == '200') {
      showSuccessMessage(message: alert.message.toString());
    }
  }

  Future<List<Alert>> getAlert() async {
    return await AlertRepository().getAlerts(userId: box.read('user_id'), token: box.read('token'));
  }

  Future<List<Alert>> getAlertEnabled() async {
    return await AlertRepository().getAlertEnabled(userId: box.read('user_id'), token: box.read('token'));
  }
}

