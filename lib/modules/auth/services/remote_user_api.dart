import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:obm_market/core/failure.dart';
import 'package:obm_market/modules/auth/models/request/user_request.dart';
import 'package:obm_market/modules/auth/models/response/user_response.dart';
import 'package:obm_market/views/widgets/loading/loading.dart';
import 'package:obm_market/views/widgets/message/errorMessage.dart';
import 'package:obm_market/views/widgets/message/internetMessage.dart';
import '../../../core/api.dart';

class RemoteUserApi {
  static const String url = 'https://oblackmarket.com/api/users';

  static Future<UserResponse?> find(UserRequest request) async {

    Api.interceptor(token: request.token, contentType: 'application/json');

    try {
      final response = await Api.dio.get('https://oblackmarket.com/api/users/get');

      if (response.statusCode == 200) {
        final results = Map<String, dynamic>.from(response.data);
        results['status'] = '200';

        if (results.isNotEmpty) {
          return UserResponse.fromMap(results);
        }
      }

      return null;
    } on DioError catch (err) {
      showErrorMessage(err.response?.data['message'] ?? 'Something went wrong!');

      print(err);
      throw Failure(message: err.response?.statusMessage ?? 'Something went wrong!');
    } on SocketException catch (err) {
      showInternetMessage('Veuillez verifier votre connexion.');

      print(err);
      throw Failure(message: 'Please check your connection.');
    }
  }

  static Future<UserResponse?> add(UserCreateRequest request) async {
    try {
      showLoading();

      final response = await Dio().post(url, data: request.toMap(),
          options: Options(headers: {'Content-Type': 'application/json; charset=UTF-8'}));

      stopLoading();

      if (response.statusCode == 201) {
        final results = Map<String, dynamic>.from(response.data);
        results['status'] = '201';

        if (results.isNotEmpty) {
          return UserResponse.fromMap(results);
        }
      }

      showErrorMessage(response.data['message']);

      return UserResponse.fromMap({'status': response.statusCode});
    } on DioError catch (err) {
      stopLoading();

      if (err.response?.statusCode == 422) {
        final results = Map<String, dynamic>.from(json.decode(err.response?.data));
        final violations = List<Map<String, dynamic>>.from(results['violations']);

        violations.forEach((element) => showErrorMessage('${element['propertyPath']} : ${element['message']}'));
      }

      throw Failure(message: err.response!.statusMessage ?? 'Something went wrong!');
    } on SocketException catch (err) {
      stopLoading();
      showInternetMessage('Veuillez verifier votre connexion.');

      print(err);
      throw Failure(message: 'Veuillez verifier votre connexion.');
    }
  }

  static Future<UserResponse?> edit(UserEditRequest request) async {
    showLoading();
    Api.interceptor(token: request.token, contentType: 'application/json');

    try {
      final response = await Api.dio.put('$url/${request.id}', data: request.toMap());

      stopLoading();

      if (response.statusCode == 200) {
        final results = Map<String, dynamic>.from(response.data);
        results['status'] = '200';

        if (results.isNotEmpty) {
          return UserResponse.fromMap(results);
        }
      }

      showErrorMessage(response.data['message']);

      return UserResponse.fromMap({'status': response.statusCode});
    } on DioError catch (err) {
      stopLoading();
      showErrorMessage(err.response?.statusMessage ?? 'Something went wrong!');

      print(err.response?.statusMessage);
      throw Failure(message: err.response?.statusMessage ?? 'Something went wrong!');
    } on SocketException catch (err) {
      stopLoading();
      showInternetMessage('Veuillez verifier votre connexion.');

      print(err);
      throw Failure(message: 'Veuillez verifier votre connexion.');
    }
  }

  static Future<UserResponse?> delete(UserPutRequest request) async {
    showLoading();
    Api.interceptor(token: request.token, contentType: 'application/merge-patch+json');

    try {
      final response = await Api.dio.patch('$url/${request.id}/delete', data: json.encode(request.toMap()));

      stopLoading();

      if (response.statusCode == 200) {
        final results = Map<String, dynamic>.from(response.data);
        results['status'] = '200';

        if (results.isNotEmpty) {
          return UserResponse.fromMap(results);
        }
      }

      showErrorMessage(response.data['message']);

      return UserResponse.fromMap({'status': response.statusCode});
    } on DioError catch (err) {
      stopLoading();
      showErrorMessage(err.response?.data ?? 'Something went wrong!');

      print(err.response);
      throw Failure(message: err.response?.statusMessage ?? 'Something went wrong!');
    } on SocketException catch (err) {
      stopLoading();
      showInternetMessage('Veuillez verifier votre connexion.');

      print(err);
      throw Failure(message: 'Veuillez verifier votre connexion.');
    }
  }

  static Future<UserResponse?> deleteCancel(UserCancelRequest request) async {
    showLoading();
    Api.interceptor(token: request.token, contentType: 'application/json');

    try {
      final response = await Api.dio.put('$url/${request.id}/delete/cancel', data: request.toMap());

      stopLoading();

      if (response.statusCode == 200) {
        final results = Map<String, dynamic>.from(response.data);
        results['status'] = '200';

        if (results.isNotEmpty) {
          return UserResponse.fromMap(results);
        }
      }

      showErrorMessage(response.data['message']);

      return UserResponse.fromMap({'status': response.statusCode});
    } on DioError catch (err) {
      stopLoading();
      showErrorMessage(err.response?.data ?? 'Something went wrong!');

      print(err.response);
      throw Failure(message: err.response?.statusMessage ?? 'Something went wrong!');
    } on SocketException catch (err) {
      stopLoading();
      showInternetMessage('Veuillez verifier votre connexion.');

      print(err);
      throw Failure(message: 'Veuillez verifier votre connexion.');
    }
  }

  static Future<UserResponse?> passwordChange(UserPutRequest request) async {
    showLoading();
    Api.interceptor(token: request.token, contentType: 'application/merge-patch+json');

    try {

      final response = await Dio().patch('$url/${request.id}/password-change', data: json.encode(request.toMap()));

      stopLoading();

      if (response.statusCode == 200) {
        final results = Map<String, dynamic>.from(response.data);
        results['status'] = '200';

        if (results.isNotEmpty) {
          return UserResponse.fromMap(results);
        }
      }

      showErrorMessage(response.data['message']);

      return UserResponse.fromMap({'status': response.statusCode});
    } on DioError catch (err) {
      stopLoading();
      showErrorMessage(err.response?.data ?? 'Something went wrong!');

      print(err.response);
      throw Failure(message: err.response?.data ?? 'Something went wrong!');
    } on SocketException catch (err) {
      stopLoading();
      showInternetMessage('Veuillez verifier votre connexion.');

      print(err);
      throw Failure(message: 'Veuillez verifier votre connexion.');
    }
  }

  static Future<UserResponse?> upload(UserImageRequest request) async {
    try {
      showLoading();

      var req = http.MultipartRequest('POST', Uri.parse('$url/${request.id}/image'));
      req.headers.addAll({'Authorization': 'Bearer ${request.token}'});
      req.files.add(await http.MultipartFile.fromPath('file', request.image.path));

      var res = await req.send();
      var response = await http.Response.fromStream(res);

      final responseData = json.decode(response.body);
      print(responseData);

      stopLoading();

      if (response.statusCode == 201) {
        final results = Map<String, dynamic>.from(jsonDecode(utf8.decode(response.bodyBytes)));
        results['status'] = '201';

        if (results.isNotEmpty) {
          return UserResponse.fromMap(results);
        }
      }

      return UserResponse.fromMap({'status': response.statusCode.toString()});
    } on SocketException catch (err) {
      stopLoading();
      showInternetMessage('Veuillez verifier votre connexion.');

      print(err);
      throw Failure(message: 'Veuillez verifier votre connexion.');
    }
  }
}



