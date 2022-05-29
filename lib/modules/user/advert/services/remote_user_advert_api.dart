import 'dart:io';
import 'package:dio/dio.dart';
import 'package:obm_market/core/failure.dart';
import 'package:obm_market/modules/advert/models/response/advert_response.dart';
import 'package:obm_market/modules/user/advert/models/request/user_advert_request.dart';

class RemoteUserAdvertApi {
  static const String url = 'https://oblackmarket.com/api/users';

  static Future<List<AdvertResponse>> getAdvertEnabled(UserAdvertRequest request) async {
    try {
      final response = await Dio().get(
          url+'/${request.id}/adverts/enabled',
          options: Options(headers: {'Content-Type': 'application/json; charset=UTF-8'})
      );

      if (response.statusCode == 200) {
        final results = List<Map<String, dynamic>>.from(response.data);

        if (results.isNotEmpty) {
          return results.map((e) => AdvertResponse.fromMap(e)).toList();
        }
      }

      return [];
    } on DioError catch (err) {
      print(err);
      throw Failure(message: err.response?.statusMessage ?? 'Something went wrong!');
    } on SocketException catch (err) {
      print(err);
      throw Failure(message: 'Please check your connection.');
    }
  }

  static Future<List<AdvertResponse>> getAdvert(UserAdvertRequest request) async {
    try {
      final response = await Dio().get(
          url+'/${request.id}/adverts',
          options: Options(headers: {'Content-Type': 'application/json; charset=UTF-8'})
      );

      if (response.statusCode == 200) {
        final results = List<Map<String, dynamic>>.from(response.data);

        if (results.isNotEmpty) {
          return results.map((e) => AdvertResponse.fromMap(e)).toList();
        }
      }

      return [];
    } on DioError catch (err) {
      print(err);
      throw Failure(message: err.response?.statusMessage ?? 'Something went wrong!');
    } on SocketException catch (err) {
      print(err);
      throw Failure(message: 'Please check your connection.');
    }
  }

}



