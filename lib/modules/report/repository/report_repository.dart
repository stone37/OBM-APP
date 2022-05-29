import 'package:obm_market/modules/report/models/entities/report.dart';

import '../models/request/report_request.dart';
import '../services/remote_report_api.dart';

class ReportRepository {

  Future<ReportData> create({
    String? email,
    required String reason,
    required String content,
    required int advertId,
    required String token}) {

    return RemoteReportApi.create(ReportRequest(
        token: token,
        email: email,
        reason: reason,
        content: content,
        advertId: advertId)).then((value) => value!.toEntity());
  }

}
