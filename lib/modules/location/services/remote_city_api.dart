import 'dart:io';
import 'package:dio/dio.dart';
import 'package:obm_market/core/failure.dart';
import 'package:obm_market/modules/location/models/request/city_request.dart';
import 'package:obm_market/modules/location/models/response/city_response.dart';


class RemoteCityApi {
  static const String url = 'https://oblackmarket.com/api/cities';

  static Future<List<CityResponse>> getCities(CityRequest request) async {
    try {
      final response = await Dio().get(url, queryParameters: request.toMap());

      if (response.statusCode == 200) {
        final results = List<Map<String, dynamic>>.from(response.data);

        if (results.isNotEmpty) {
          return results.map((e) => CityResponse.fromMap(e)).toList();
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



