import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:obm_market/core/failure.dart';
import 'package:obm_market/modules/auth/models/request/user_request.dart';
import 'package:obm_market/modules/auth/models/response/user_auth_response.dart';
import 'package:obm_market/views/widgets/loading/loading.dart';
import 'package:obm_market/views/widgets/message/errorMessage.dart';
import 'package:obm_market/views/widgets/message/internetMessage.dart';

import '../controllers/social_auth_controller.dart';

class RemoteUserAuthApi {
  static const String url = 'https://oblackmarket.com/api';
  static const String login = url + '/login';
  static const String refresh = url + '/token/refresh';

  static Future<UserAuthResponse> getToken(UserAuthLoginRequest request) async {
    try {
      showLoading();

      final response = await Dio().post(login, data: request.toMap(), options: Options(contentType: Headers.jsonContentType));

      stopLoading();

      if (response.statusCode == 200) {
        Map<String, dynamic> results = Map<String, String>.from(response.data);
        results['status'] = '200';

        if (results.isNotEmpty) {
          return UserAuthResponse.fromMap(results);
        }
      }

      showErrorMessage(response.data['message']);

      return UserAuthResponse.fromMap({'status': response.statusCode});
      
    } on DioError catch (err) {
      stopLoading();
      showErrorMessage(err.response?.data['message'] ?? 'Something went wrong!');

      print(err);
      throw Failure(message: err.response?.statusMessage ?? 'Something went wrong!');
    } on SocketException catch (err) {
      stopLoading();
      showInternetMessage('Veuillez vérifier votre connexion.');

      print(err);
      throw Failure(message: 'Veuillez vérifier votre connexion.');
    }
  }

  static Future<UserAuthResponse> getRefresh(UserAuthTokenRequest request) async {
    try {
      final response = await Dio().post(
          refresh, data: request.toMap(),
          options: Options(contentType: Headers.jsonContentType));

      if (response.statusCode == 200) {
        final results = Map<String, String>.from(response.data);
        results['status'] = '200';

        if (results.isNotEmpty) {
          return UserAuthResponse.fromMap(results);
        }
      }

      return UserAuthResponse.fromMap({'status': response.statusCode});

      //return null;

    } on DioError catch (err) {
      print(err);
      showErrorMessage(err.response?.data['message'] ?? 'Something went wrong!');

      throw Failure(message: err.response?.statusMessage ?? 'Something went wrong!');
    } on SocketException catch (err) {
      showInternetMessage('Veuillez vérifier votre connexion.');

      print(err);
      throw Failure(message: 'Veuillez vérifier votre connexion.');
    }
  }

  static Future<UserSocialAuthResponse?> socialAuth(UserSocialAuthRequest request) async {
    try {
      showLoading();

      final response = await Dio().post(
          'https://oblackmarket.com/api/login/social',
          data: request.toMap(),
          options: Options(contentType: Headers.jsonContentType));

      stopLoading();

      if (response.statusCode == 200) {
        print(response);
        final results = Map<String, dynamic>.from(response.data);
        results['status'] = '200';

        if (results.isNotEmpty) {
          return UserSocialAuthResponse.fromMap(results);
        }
      } else if (response.statusCode == 202) {
        print(response);
        final results = Map<String, dynamic>.from(response.data);
        results['status'] = '202';

        if (results.isNotEmpty) {
          return UserSocialAuthResponse.fromMap(results);
        }
      }

    } on DioError catch (err) {
      stopLoading();
      print(err);
      showErrorMessage(err.response?.statusMessage ?? 'Something went wrong!');

      throw Failure(message: err.response?.statusMessage ?? 'Something went wrong!');
    } on SocketException catch (err) {
      stopLoading();
      showInternetMessage('Veuillez vérifier votre connexion.');

      print(err);
      throw Failure(message: 'Veuillez vérifier votre connexion.');
    }

    return null;
  }

  static Future<UserSocialAuthResponse?> socialRegister(UserSocialRegisterRequest request) async {
    try {
      showLoading();

      final response = await Dio().post(
          'https://oblackmarket.com/api/users/social/register',
          data: json.encode(request.toMap()),
          options: Options(contentType: 'application/ld+json; charset=UTF-8'));

      stopLoading();

      if (response.statusCode == 200) {
        final results = Map<String, String>.from(response.data);
        results['status'] = '200';

        if (results.isNotEmpty) {
          return UserSocialAuthResponse.fromMap(results);
        }
      }

    } on DioError catch (err) {
      stopLoading();

      if (err.response?.statusCode == 422) {
        final results = Map<String, dynamic>.from(err.response?.data);
        final List<dynamic> data = results['message'];
        final SocialAuthController controller = Get.find();
        controller.violations.value = [];
        List<String> errors = [];

        data.forEach((message) {
          errors.add(message.toString());
        });

        showErrorMessage(err.response!.statusMessage!);
        controller.violations.value = errors;
      }

      throw Failure(message: err.response?.statusMessage ?? 'Something went wrong!');
    } on SocketException catch (err) {
      stopLoading();
      showInternetMessage('Veuillez vérifier votre connexion.');

      print(err);
      throw Failure(message: 'Veuillez vérifier votre connexion.');
    }

    return null;
  }

  static Future<UserResetResponse?> reset(UserResetRequest request) async {
    try {
      showLoading();

      final response = await Dio().post(
          'https://oblackmarket.com/api/password-reset',
          data: json.encode(request.toMap()),
          options: Options(contentType: 'application/json; charset=UTF-8'));

      stopLoading();

      if (response.statusCode == 204) {
        Map<String, dynamic> results = {};
        results['status'] = '204';

        if (results.isNotEmpty) {
          return UserResetResponse.fromMap(results);
        }
      }

    } on DioError catch (err) {
      stopLoading();

      showErrorMessage(err.response!.statusMessage!);

      throw Failure(message: err.response?.statusMessage ?? 'Something went wrong!');
    } on SocketException catch (err) {
      stopLoading();
      showInternetMessage('Veuillez vérifier votre connexion.');

      print(err);
      throw Failure(message: 'Veuillez vérifier votre connexion.');
    }

    return null;
  }
}






