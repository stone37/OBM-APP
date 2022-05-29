import 'dart:io';
import 'package:dio/dio.dart';
import 'package:obm_market/core/failure.dart';
import 'package:obm_market/modules/settings/models/response/settings_response.dart';

class RemoteSettingsApi {
  static const String url = 'https://oblackmarket.com/api/settings/get';

  static Future<SettingsResponse?> getSettings() async {
    try {
      final response = await Dio().get(url);

      if (response.statusCode == 200) {
        final results = Map<String, dynamic>.from(response.data);

        if (results.isNotEmpty) {
          return SettingsResponse.fromMap(results);
        }
      }

      return null;
    } on DioError catch (err) {
      print(err);
      throw Failure(message: err.response?.statusMessage ?? 'Something went wrong!');
    } on SocketException catch (err) {
      print(err);
      throw Failure(message: 'Please check your connection.');
    }
  }
}



