import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:obm_market/core/failure.dart';
import 'package:obm_market/modules/report/models/request/report_request.dart';
import 'package:obm_market/views/widgets/loading/loading.dart';
import 'package:obm_market/views/widgets/message/errorMessage.dart';
import 'package:obm_market/views/widgets/message/internetMessage.dart';

import '../../../core/api.dart';
import '../models/response/report_response.dart';


class RemoteReportApi {

  static Future<ReportResponse?> create(ReportRequest request) async {

    showLoading();
    Api.interceptor(token: request.token, contentType: 'application/json');

    try {

      final response = await Api.dio.post(
          'https://oblackmarket.com/api/reports/${request.advertId}/create',
          data: json.encode(request.toMap()));

      stopLoading();

      if (response.statusCode == 201) {
        final results = Map<String, dynamic>.from(response.data);
        results['status'] = '201';

        if (results.isNotEmpty) {
          return ReportResponse.fromMap(results);
        }
      }

      showErrorMessage(response.statusMessage!);

      return ReportResponse.fromMap({'status': response.statusCode});
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
}



