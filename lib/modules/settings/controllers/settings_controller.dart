import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:obm_market/modules/settings/models/entities/settings.dart';
import 'package:obm_market/modules/settings/repository/settings_repository.dart';

class SettingsController extends GetxController {
  Settings? settings;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();

    getSettings();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getSettings() async {
    settings = await SettingsRepository().getSettings();

    await box.write('app_name', settings!.name);
    await box.write('app_phone', settings!.phone);
    await box.write('app_email', settings!.email);
    await box.write('app_message_state', settings!.messageState);
    await box.write('app_favoris_state', settings!.favorisState);
    await box.write('app_alerte_state', settings!.alertState);
    await box.write('app_ad_similar_state', settings!.adSimilarState);
  }
}

