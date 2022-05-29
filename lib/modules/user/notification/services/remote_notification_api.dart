import 'dart:io';
import 'package:dio/dio.dart';
import 'package:obm_market/core/failure.dart';

import '../../../../core/api.dart';
import '../models/request/notification_request.dart';
import '../models/response/notification_response.dart';

class RemoteNotificationApi {

  static Future<List<NotificationResponse>> findAll(NotificationRequest request) async {

    Api.interceptor(token: request.token, contentType: 'application/json');

    try {
      final response = await Api.dio.get('https://oblackmarket.com/api/notifications/user');

      if (response.statusCode == 200) {
        final results = List<Map<String, dynamic>>.from(response.data);

        if (results.isNotEmpty) {
          return results.map((e) => NotificationResponse.fromMap(e)).toList();
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

  static Future<List<NotificationResponse>> findAllUnread(NotificationRequest request) async {

    Api.interceptor(token: request.token, contentType: 'application/json');

    try {
      final response = await Api.dio.get('https://oblackmarket.com/api/notifications/user/unread');

      if (response.statusCode == 200) {
        final results = List<Map<String, dynamic>>.from(response.data);

        if (results.isNotEmpty) {
          return results.map((e) => NotificationResponse.fromMap(e)).toList();
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

  static Future<NotificationDataResponse?> nbUnread(NotificationRequest request) async {

    Api.interceptor(token: request.token, contentType: 'application/json');

    try {
      final response = await Api.dio.get('https://oblackmarket.com/api/notifications/user/nbUnread');

      if (response.statusCode == 200) {
        final results = Map<String, dynamic>.from(response.data);

        results['status'] = '200';

        if (results.isNotEmpty) {
          return NotificationDataResponse.fromMap(results);
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



