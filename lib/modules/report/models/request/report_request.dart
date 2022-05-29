import 'package:equatable/equatable.dart';

class ReportRequest extends Equatable {
  const ReportRequest({
    this.email,
    required this.advertId,
    required this.reason,
    required this.content,
    required this.token,
  });

  final String? email;
  final String reason;
  final String content;
  final int advertId;
  final String token;

  @override
  List<Object?> get props => [email, reason, content, advertId, token];

  Map<String, dynamic> toMap() {
    final queryParameters = {
      'email': email,
      'reason': reason,
      'content': content,
    };

    return queryParameters;
  }
}

