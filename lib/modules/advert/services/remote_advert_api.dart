import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:obm_market/modules/advert/models/request/advert_request.dart';
import 'package:obm_market/modules/advert/models/response/advert_response.dart';
import '../../../core/api.dart';
import '../../../core/failure.dart';
import '../../../views/widgets/loading/loading.dart';
import '../../../views/widgets/message/errorMessage.dart';
import '../../../views/widgets/message/internetMessage.dart';

class RemoteAdvertApi {
  static const String url = 'https://oblackmarket.com/api/adverts';

  static Future<AdvertListResponse?> getAdvertList(AdvertFilterRequest request) async {
    try {
      final response = await Dio().get(
          url,
          queryParameters: request.toMap(),
          options: Options(headers: {'Accept': 'application/ld+json'})
      );

      if (response.statusCode == 200) {

        final results = Map<String, dynamic>.from(json.decode(response.data));

        if (results.isNotEmpty) {
          return AdvertListResponse.fromMap(results);
        }
      }

      return null;
    } on DioError catch (err) {
      print(err);
      throw Failure(message: err.response?.statusMessage ?? 'Something went wrong!');
    }
  }

  static Future<List<AdvertResponse>> getCounts(AdvertCountFilterRequest request) async {
    try {
      final response = await Dio().get(url, queryParameters: request.toMap());

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
    }  
  }

  static Future<List<AdvertResponse>> getSimilar(AdvertSimilarRequest request) async {
    try {
      final response = await Dio().get(url+'/${request.id}/similar', queryParameters: request.toMap());

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
    }  
  }

  static Future<AdvertResponse> create(AdvertRequest request) async {
    showLoading();
    Api.interceptor(token: request.token, contentType: 'application/json');

    try {

      final response = await Api.dio.post(url + '/${request.categoryId}/create', data: json.encode(request.toMap()));

      stopLoading();

      if (response.statusCode == 201) {
        final results = Map<String, dynamic>.from(response.data);
        results['status'] = '201';

        if (results.isNotEmpty) {
          return AdvertResponse.fromMap(results);
        }
      } else if (response.statusCode == 422) {
        showErrorMessage('Certains champs ont été mal renseigner');
      }

      showErrorMessage(response.data);

      return AdvertResponse.fromMap({'status': response.statusCode.toString()});

    } on DioError catch (err) {
      print(err.response?.statusMessage);
      stopLoading();
      showErrorMessage(err.response?.statusMessage ?? 'Something went wrong!');

      print(err);
      throw Failure(message: err.response?.statusMessage ?? 'Something went wrong!');
    } on SocketException catch (err) {
      stopLoading();
      showInternetMessage('Veuillez verifier votre connexion.');

      print(err);
      throw Failure(message: 'Veuillez verifier votre connexion.');
    }
  }

  static Future<AdvertResponse> edit(AdvertEditRequest request) async {
    showLoading();
    Api.interceptor(token: request.token, contentType: 'application/json');

    try {

      print(json.encode(request.toMap()));
      print(request.id);

      final response = await Api.dio.put(url + '/${request.id}', data: json.encode(request.toMap()));

      stopLoading();

      if (response.statusCode == 200) {
        final results = Map<String, dynamic>.from(response.data);
        results['status'] = '200';

        if (results.isNotEmpty) {
          return AdvertResponse.fromMap(results);
        }
      } else if (response.statusCode == 422) {
        showErrorMessage('Certains champs ont été mal renseigner');
      }

      showErrorMessage(response.data);

      return AdvertResponse.fromMap({'status': response.statusCode.toString()});

    } on DioError catch (err) {
      print(err.response?.statusMessage);
      stopLoading();
      showErrorMessage(err.response?.statusMessage ?? 'Something went wrong!');

      print(err);
      throw Failure(message: err.response?.statusMessage ?? 'Something went wrong!');
    } on SocketException catch (err) {
      stopLoading();
      showInternetMessage('Veuillez verifier votre connexion.');

      print(err);
      throw Failure(message: 'Veuillez verifier votre connexion.');
    }
  }

  static Future<AdvertDataResponse> upload(AdvertImageRequest request) async {
    showLoading();
    Api.interceptor(token: request.token, contentType: 'multipart/form-data');

    print('Req => ${request.toMap()}');


    try {
      final response = await Api.dio.post(url+'/image/add/${request.id}', data: request.toMap());

      stopLoading();

      if (response.statusCode == 200) {
        final results = Map<String, dynamic>.from(response.data);
        results['status'] = '200';

        if (results.isNotEmpty) {
          return AdvertDataResponse.fromMap(results);
        }
      }

      showErrorMessage(response.statusCode.toString());

      return AdvertDataResponse.fromMap({'status': response.statusCode.toString()});

    } on DioError catch (err) {
      stopLoading();
      showErrorMessage(err.response?.statusMessage ?? 'Something went wrong!');

      print(err);
      throw Failure(message: err.response?.statusMessage ?? 'Something went wrong!');
    } on SocketException catch (err) {
      stopLoading();
      showInternetMessage('Veuillez verifier votre connexion.');

      print(err);
      throw Failure(message: 'Veuillez verifier votre connexion.');
    }
  }

  static Future<AdvertDataResponse> initClear(AdvertImageDataRequest request) async {
    Api.interceptor(token: request.token, contentType: 'application/json');

    try {
      final response = await Api.dio.get('$url/image/clear');

      if (response.statusCode == 200) {
        final results = Map<String, dynamic>.from(response.data);
        results['status'] = '200';

        if (results.isNotEmpty) {
          return AdvertDataResponse.fromMap(results);
        }
      }

      showErrorMessage(response.data);

      return AdvertDataResponse.fromMap({'status': response.statusCode.toString()});

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

  static Future<List<AdvertResponse>> getUserAdvert(AdvertUserRequest request) async {
    Api.interceptor(token: request.token, contentType: 'application/json');

    try {
      final response = await Api.dio.get('https://oblackmarket.com/api/users/${request.id}/adverts');

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
    }  
  }

  static Future<List<AdvertResponse>> getUserAdvertEnabled(AdvertUserRequest request) async {

    Api.interceptor(token: request.token, contentType: 'application/json');

    try {
      final response = await Api.dio.get('https://oblackmarket.com/api/users/${request.id}/adverts/enabled');

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
    }  
  }

  static Future<AdvertDataResponse?> deleteAdvert(AdvertUserRequest request) async {
    showLoading();
    Api.interceptor(token: request.token, contentType: 'application/merge-patch+json');

    try {
      final response = await Api.dio.patch('https://oblackmarket.com/api/adverts/${request.id}/delete', data: json.encode({}));

      stopLoading();

      if (response.statusCode == 200) {
        final results = Map<String, dynamic>.from(response.data);

        results['status'] = '200';

        if (results.isNotEmpty) {
          return AdvertDataResponse.fromMap(results);
        }
      }

      return null;
    } on DioError catch (err) {
      stopLoading();

      print(err);
      throw Failure(message: err.response?.statusMessage ?? 'Something went wrong!');
    }
  }

  static Future<AdvertDataResponse?> checkThread(AdvertUserRequest request) async {
    Api.interceptor(token: request.token, contentType: 'application/json');

    try {
      final response = await Api.dio.get('https://oblackmarket.com/api/adverts/user/${request.id}/thread');

      if (response.statusCode == 200) {
        final results = Map<String, dynamic>.from(response.data);

        results['status'] = '200';

        if (results.isNotEmpty) {
          return AdvertDataResponse.fromMap(results);
        }
      }

      return null;
    } on DioError catch (err) {
      print(err);
      throw Failure(message: err.response?.statusMessage ?? 'Something went wrong!');
    }
  }

  static Future<AdvertDataResponse?> checkAdvert(AdvertUserRequest request) async {
    Api.interceptor(token: request.token, contentType: 'application/json');

    try {
      final response = await Api.dio.get('https://oblackmarket.com/api/adverts/${request.id}/check');

      if (response.statusCode == 200) {
        final results = Map<String, dynamic>.from(response.data);

        results['status'] = '200';
        results['message'] = '200';

        if (results.isNotEmpty) {
          return AdvertDataResponse.fromMap(results);
        }
      }

      return null;
    } on DioError catch (err) {
      print(err);
      throw Failure(message: err.response?.statusMessage ?? 'Something went wrong!');
    }
  }

  static Future<AdvertImageDeleteResponse?> deletePicture(AdvertUserRequest request) async {
    showLoading();
    Api.interceptor(token: request.token, contentType: 'application/json');

    print('Req ==> ${request.id}');

    try {
      final response = await Api.dio.delete('https://oblackmarket.com/api/adverts/image/${request.id}/delete');
      stopLoading();

      print('Image remove response ==> $response');

      if (response.statusCode == 204) {

        Map<String, dynamic> results = {};

        results['status'] = '204';

        if (results.isNotEmpty) {
          return AdvertImageDeleteResponse.fromMap(results);
        }
      }

      return null;
    } on DioError catch (err) {
      stopLoading();

      print(err.response);
      throw Failure(message: err.response?.statusMessage ?? 'Something went wrong!');
    }
  }
}


