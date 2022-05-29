import 'dart:io';
import 'package:dio/dio.dart';
import 'package:obm_market/core/failure.dart';
import 'package:obm_market/views/widgets/loading/loading.dart';
import '../../../../core/api.dart';
import '../../../../views/widgets/message/errorMessage.dart';
import '../../../../views/widgets/message/internetMessage.dart';
import '../models/request/thread_request.dart';
import '../models/response/thread_response.dart';

class RemoteThreadApi {

  static Future<List<ThreadResponse>> findAll(ThreadRequest request) async {

    Api.interceptor(token: request.token, contentType: 'application/json');

    try {
      final response = await Api.dio.get('https://oblackmarket.com/api/threads/user');

      if (response.statusCode == 200) {
        final results = List<Map<String, dynamic>>.from(response.data);

        if (results.isNotEmpty) {
          return results.map((e) => ThreadResponse.fromMap(e)).toList();
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

  static Future<ThreadDataResponse> create(ThreadCreateRequest request) async {
    Api.interceptor(token: request.token, contentType: 'application/json');

    try {
      final response = await Api.dio.post(
          'https://oblackmarket.com/api/threads/${request.advertId}/create',
          data: request.toMap()
      );

      if (response.statusCode == 201) {
        final results = Map<String, dynamic>.from(response.data);
        results['status'] = '201';

        if (results.isNotEmpty) {
          return ThreadDataResponse.fromMap(results);
        }
      }

      showErrorMessage(response.data);

      return ThreadDataResponse.fromMap({'status': response.statusCode.toString()});
    } on DioError catch (err) {
      showErrorMessage(err.response?.data['message'] ?? 'Something went wrong!');

      print(err);
      throw Failure(message: err.response?.statusMessage ?? 'Something went wrong!');
    } on SocketException catch (err) {
      showInternetMessage('Veuillez verifier votre connexion.');

      print(err);
      throw Failure(message: 'Veuillez verifier votre connexion.');
    }
  }

  static Future<ThreadDataResponse> reply(ThreadReplyRequest request) async {
    Api.interceptor(token: request.token, contentType: 'application/json');

    try {
      final response = await Api.dio.put(
        'https://oblackmarket.com/api/threads/${request.id}/reply',
        data: request.toMap()
      );

      if (response.statusCode == 201) {
        final results = Map<String, dynamic>.from(response.data);
        results['status'] = '201';

        if (results.isNotEmpty) {
          return ThreadDataResponse.fromMap(results);
        }
      }

      showErrorMessage(response.data);

      return ThreadDataResponse.fromMap({'status': response.statusCode.toString()});
    } on DioError catch (err) {
      showErrorMessage(err.response?.data['message'] ?? 'Something went wrong!');

      print(err);
      throw Failure(message: err.response?.statusMessage ?? 'Something went wrong!');
    } on SocketException catch (err) {
      showInternetMessage('Veuillez verifier votre connexion.');

      print(err);
      throw Failure(message: 'Veuillez verifier votre connexion.');
    }
  }

  static Future<ThreadDataResponse?> delete(ThreadDataRequest request) async {
    showLoading();
    Api.interceptor(token: request.token, contentType: 'application/json');

    try {
      final response = await Api.dio.get('https://oblackmarket.com/api/threads/${request.id}/delete');

      stopLoading();

      if (response.statusCode == 204) {
        final results = Map<String, dynamic>.from(response.data);

        results['status'] = '204';

        if (results.isNotEmpty) {
          return ThreadDataResponse.fromMap(results);
        }
      }

      return null;
    } on DioError catch (err) {
      stopLoading();
      print(err);
      throw Failure(message: err.response?.statusMessage ?? 'Something went wrong!');
    } on SocketException catch (err) {
      stopLoading();
      print(err);
      throw Failure(message: 'Please check your connection.');
    }
  }

  static Future<ThreadResponse?> find(ThreadDataRequest request) async {
    Api.interceptor(token: request.token, contentType: 'application/json');

    try {
      final response = await Api.dio.get('https://oblackmarket.com/api/threads/user/${request.id}');

      if (response.statusCode == 200 && response.data != null) {

        final results = Map<String, dynamic>.from(response.data);

        results['status'] = '200';

        if (results.isNotEmpty) {
          return ThreadResponse.fromMap(results);
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



