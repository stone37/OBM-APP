import 'package:equatable/equatable.dart';

import '../../../../advert/models/entities/advert.dart';

class UserNotification extends Equatable {
  const UserNotification({
    required this.id,
    required this.advert,
    required this.message,
    this.url,
    this.createdAt});

  final int id;
  final Advert advert;
  final String message;
  final String? url;
  final DateTime? createdAt;


  @override
  List<Object?> get props => [id, advert, message, url, createdAt];
}

class NotificationData extends Equatable {
  const NotificationData({required this.data, this.status});

  final int data;
  final String? status;

  @override
  List<Object?> get props => [data];
}

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}



