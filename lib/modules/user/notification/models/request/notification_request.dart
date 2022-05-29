import 'package:equatable/equatable.dart';

class NotificationRequest extends Equatable {
  const NotificationRequest({required this.token});

  final String token;

  @override
  List<Object?> get props => [token];
}
