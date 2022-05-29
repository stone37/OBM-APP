import 'dart:io';
import 'package:dio/dio.dart';
import 'package:obm_market/core/failure.dart';
import 'package:obm_market/modules/advert/models/response/category_premium_response.dart';

class RemoteCategoryPremiumApi {
  static const String url = 'https://oblackmarket.com/api/categories/premiums';

  static Future<List<CategoryPremiumResponse>> getPremiums() async {
    try {
      final response = await Dio().get(url);

      if (response.statusCode == 200) {

        final results = List<Map<String, dynamic>>.from(response.data);

        if (results.isNotEmpty) {
          return results.map((e) => CategoryPremiumResponse.fromMap(e)).toList();
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


