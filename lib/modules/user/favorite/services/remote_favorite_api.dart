import 'dart:io';
import 'package:dio/dio.dart';
import 'package:obm_market/core/failure.dart';
import 'package:obm_market/modules/user/favorite/models/request/favorite_request.dart';
import 'package:obm_market/modules/user/favorite/models/response/favorite_response.dart';
import 'package:obm_market/views/widgets/loading/loading.dart';
import 'package:obm_market/views/widgets/message/errorMessage.dart';
import 'package:obm_market/views/widgets/message/internetMessage.dart';

class RemoteFavoriteApi {
  static const String url = 'https://oblackmarket.com/api/users';
  static const String createUrl = 'https://oblackmarket.com/api/users/favorites';
  static const String checkUrl = 'https://oblackmarket.com/api/adverts';

  static Future<FavoriteResponse> create(FavoriteRequest request) async {
    try {
      showLoading();

      final response = await Dio().post(
        createUrl+'/${request.advertId}',
        data: request.toMap(),
        options: Options(headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${request.token}'}
          )
        );

      stopLoading();

      if (response.statusCode == 201) {
        final results = Map<String, dynamic>.from(response.data);
        results['status'] = '201';

        if (results.isNotEmpty) {
          return FavoriteResponse.fromMap(results);
        }
      }

      showErrorMessage(response.data);

      return FavoriteResponse.fromMap({'status': response.statusCode.toString()});
    } on DioError catch (err) {
      stopLoading();
      showErrorMessage(err.response?.data['message'] ?? 'Something went wrong!');

      print(err);
      throw Failure(message: err.response?.statusMessage ?? 'Something went wrong!');
    } on SocketException catch (err) {
      stopLoading();
      showInternetMessage('Veuillez verifier votre connexion.');

      print(err);
      throw Failure(message: 'Veuillez verifier votre connexion.');
    }
  }

  static Future<List<FavoriteResponse>> getFavorites(UserFavoriteRequest request) async {
    try {
      final response = await Dio().get(
        url+'/${request.userId}/favorites',
        options: Options(headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${request.token}'
        })
      );

      if (response.statusCode == 200) {
        final results = List<Map<String, dynamic>>.from(response.data);

        if (results.isNotEmpty) {
          return results.map((e) => FavoriteResponse.fromMap(e)).toList();
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

  static Future<FavoriteCheckResponse> check(FavoriteRequest request) async {

    try {
      final response = await Dio().get(
        checkUrl+'/${request.advertId}/favorites/check',
        options: Options(headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${request.token}'
        })
      );

      if (response.statusCode == 200) {
        final results = Map<String, dynamic>.from(response.data);
        results['status'] = '200';

        if (results.isNotEmpty) {
          return FavoriteCheckResponse.fromMap(results);
        }
      }

      return FavoriteCheckResponse.fromMap({'status': response.statusCode.toString()});
    } on DioError catch (err) {
      print(err);
      throw Failure(message: err.response?.statusMessage ?? 'Something went wrong!');
    } on SocketException catch (err) {
      print(err);
      throw Failure(message: 'Please check your connection.');
    }
  }

  static Future<FavoriteDeleteResponse> delete(FavoriteRequest request) async {

    try {
      showLoading();

      final response = await Dio().get(
          checkUrl+'/${request.advertId}/favorites/',
          options: Options(headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${request.token}'
          })
      );

      stopLoading();

      if (response.statusCode == 204) {
        return FavoriteDeleteResponse.fromMap({'status': response.statusCode.toString()});
      }

      showErrorMessage(response.data);
      return FavoriteDeleteResponse.fromMap({'status': response.statusCode.toString()});
    } on DioError catch (err) {
      print(err);
      throw Failure(message: err.response?.statusMessage ?? 'Something went wrong!');
    } on SocketException catch (err) {
      print(err);
      throw Failure(message: 'Please check your connection.');
    }
  }
}



