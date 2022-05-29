import 'package:equatable/equatable.dart';

class ReportData extends Equatable {
  const ReportData({required this.message, required this.status});

  final String message;
  final String status;

  @override
  List<Object?> get props => [message, status];
}


