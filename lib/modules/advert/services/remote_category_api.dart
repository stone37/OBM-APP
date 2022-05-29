import 'dart:io';
import 'package:dio/dio.dart';
import 'package:obm_market/core/failure.dart';
import 'package:obm_market/modules/advert/models/request/category_request.dart';
import 'package:obm_market/modules/advert/models/response/category_response.dart';

class RemoteCategoryApi {
  static const String url = 'https://oblackmarket.com/api/categories';

  static Future<List<CategoryResponse>> getCategories() async {
    try {
      final response = await Dio().get(url);

      if (response.statusCode == 200) {
        final results = List<Map<String, dynamic>>.from(response.data);

        if (results.isNotEmpty) {
          return results.map((e) => CategoryResponse.fromMap(e)).toList();
        }
      }

      return [];
    } on DioError catch (err) {

      if (DioErrorType.receiveTimeout == err.type || DioErrorType.connectTimeout == err.type) {
        throw  Failure(message: "Le serveur n'est pas joignable. Veuillez vérifier votre connexion Internet et réessayer");
      } else if (DioErrorType.response == err.type) {
        print(err);
      } else {
        throw Failure(message: 'Problème de connexion au serveur. Veuillez réessayer.');
      }

      throw Failure(message: err.response?.statusMessage ?? 'Something went wrong!');
    }
  }

  static Future<CategoryResponse?> getCategory(CategoryRequest request) async {
    try {
      final response = await Dio().get(url+'/${request.id}');

      if (response.statusCode == 200) {
        final results = Map<String, dynamic>.from(response.data);

        if (results.isNotEmpty) {
          return CategoryResponse.fromMap(results);
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



