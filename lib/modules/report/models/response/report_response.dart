import 'package:equatable/equatable.dart';
import 'package:obm_market/modules/report/models/entities/report.dart';

class ReportResponse extends Equatable {
  const ReportResponse({
    this.message,
    this.status
  });

  final String? message;
  final String? status;

  @override
  List<Object?> get props => [message, status];

  ReportData toEntity() {
    return ReportData(message: message!, status: status!);
  }

  factory ReportResponse.fromMap(Map<String, dynamic> map) {
    return ReportResponse(
      message: map['message'] ?? '',
      status: map['status'] ?? ''
    );
  }
}
