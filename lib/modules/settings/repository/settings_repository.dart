import 'package:obm_market/modules/settings/models/entities/settings.dart';
import 'package:obm_market/modules/settings/services/remote_settings_api.dart';

class SettingsRepository {
  Future<Settings> getSettings() {
    return RemoteSettingsApi.getSettings().then((value) => value!.toEntity());
  }
}

