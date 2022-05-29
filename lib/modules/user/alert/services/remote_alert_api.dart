import 'dart:io';
import 'package:dio/dio.dart';
import 'package:obm_market/core/failure.dart';
import 'package:obm_market/modules/user/alert/models/request/alert_request.dart';
import 'package:obm_market/modules/user/alert/models/response/alert_response.dart';
import 'package:obm_market/views/widgets/loading/loading.dart';
import 'package:obm_market/views/widgets/message/errorMessage.dart';
import 'package:obm_market/views/widgets/message/internetMessage.dart';
import '../../../../core/api.dart';

class RemoteAlertApi {
  static const String url = 'https://oblackmarket.com/api/users/alerts';
  static const String urlList = 'https://oblackmarket.com/api/users';

  static Future<AlertResponse> create(AlertCreateRequest request) async {

    Api.interceptor(token: request.token, contentType: 'application/json');

    try {
      showLoading();

      final response = await Api.dio.post(url+'/${request.categoryId}/create', data: request.toMap());

      stopLoading();

      if (response.statusCode == 201) {
        final results = Map<String, dynamic>.from(response.data);
        results['status'] = '201';

        if (results.isNotEmpty) {
          return AlertResponse.fromMap(results);
        }
      } else if (response.statusCode == 200) {
        showErrorMessage(response.data['message']);

        return AlertResponse.fromMap({'status': response.statusCode.toString()});
      }

      showErrorMessage(response.data.toString());

      return AlertResponse.fromMap({'status': response.statusCode.toString()});
    } on DioError catch (err) {
      stopLoading();
      showErrorMessage(err.message);

      print(err);
      throw Failure(message: err.response?.statusMessage ?? 'Something went wrong!');
    } on SocketException catch (err) {
      stopLoading();
      showInternetMessage('Veuillez verifier votre connexion.');

      print(err);
      throw Failure(message: 'Veuillez verifier votre connexion.');
    }
  }

  static Future<AlertDataResponse?> changeStatus(AlertRequest request) async {

    Api.interceptor(token: request.token, contentType: 'application/json');

    try {
      showLoading();

      final response = await Api.dio.get(url+'/${request.id}/status');

      stopLoading();

      if (response.statusCode == 200) {
        return AlertDataResponse.fromMap({'status': response.statusCode});
      }

      showErrorMessage(response.data);
      return AlertDataResponse.fromMap({'status': response.statusCode});
    } on DioError catch (err) {
      stopLoading();
      showErrorMessage(err.response?.data['message'] ?? 'Something went wrong!');

      print(err);
    } on SocketException catch (err) {
      stopLoading();
      showInternetMessage('Veuillez verifier votre connexion.');

      print(err);
    }
    return null;
  }

  static Future<AlertDataResponse?> delete(AlertRequest request) async {

    Api.interceptor(token: request.token, contentType: 'application/json');

    try {
      showLoading();

      final response = await Api.dio.get(url+'/${request.id}/delete');

      stopLoading();

      if (response.statusCode == 204) {
        return AlertDataResponse.fromMap({'status': response.statusCode});
      }

      showErrorMessage(response.data);
      return AlertDataResponse.fromMap({'status': response.statusCode});

    } on DioError catch (err) {
      stopLoading();
      showErrorMessage(err.response?.data['message'] ?? 'Something went wrong!');

      print(err);
    } on SocketException catch (err) {
      stopLoading();
      showInternetMessage('Veuillez verifier votre connexion.');

      print(err);
    }
    return null;
  }

  static Future<List<AlertResponse>> getAlerts(AlertRequest request) async {

    Api.interceptor(token: request.token, contentType: 'application/json');

    try {
      final response = await Api.dio.get(url+'/${request.id}/alerts');

      if (response.statusCode == 200) {
        final results = List<Map<String, dynamic>>.from(response.data);

        if (results.isNotEmpty) {
          return results.map((e) => AlertResponse.fromMap(e)).toList();
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


  static Future<List<AlertResponse>> getAlertEnabled(AlertRequest request) async {

    Api.interceptor(token: request.token, contentType: 'application/json');

    try {
      final response = await Api.dio.get(url+'/${request.id}/alerts/enabled');

      if (response.statusCode == 200) {
        final results = List<Map<String, dynamic>>.from(response.data);

        if (results.isNotEmpty) {
          return results.map((e) => AlertResponse.fromMap(e)).toList();
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



