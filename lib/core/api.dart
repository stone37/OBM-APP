import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import '../modules/auth/models/entities/user.dart';
import '../modules/auth/repository/user_auth_repository.dart';

class Api {
  static GetStorage box = GetStorage();
  static Dio dio = Dio();

  static interceptor({required String token, required String contentType}) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (!options.path.contains('http')) {
            return;
          }

          options.headers['Content-Type'] = '$contentType; charset=UTF-8';
          options.headers['Authorization'] = 'Bearer ${box.read('token')}'; //'Bearer $token';

          return handler.next(options);
        },
        onError: (DioError error, handler) async {
          if ((error.response?.statusCode == 401 /*&&
              error.response?.data['message'] == 'Invalid JWT'*/)) {
            
            if (box.hasData('refresh_token')) {
              var result = await refresh(token: box.read('refresh_token'));

               if (result) {
                 return handler.resolve(await _retry(error.requestOptions));
               }

              return handler.next(error);
            }
          }

          return handler.next(error);
        }
      )
    );
  }

  static Future<bool> refresh({required String token}) async {
    UserAuth? auth = await UserAuthRepository().refresh(refreshToken: token);

    print('Req Auth token ${auth.token}');
    print('Req Auth token refresh ${auth.refreshToken}');
    print('Req Auth status ${auth.status}');

    if (auth.status == '200') {
      await box.write('token', auth.token);
      await box.write('refresh_token', auth.refreshToken);

      return true;
    }

    return false;
  }

  static Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }
}