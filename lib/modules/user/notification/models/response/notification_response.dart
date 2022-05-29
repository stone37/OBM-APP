import 'package:equatable/equatable.dart';
import '../../../../advert/models/response/advert_response.dart';
import '../entities/notification.dart';

class NotificationResponse extends Equatable {
  const NotificationResponse({
    required this.id,
    required this.advert,
    required this.message,
    this.url,
    this.createdAt});

  final int id;
  final AdvertResponse advert;
  final String message;
  final String? url;
  final String? createdAt;

  @override
  List<Object?> get props => [id, advert, message, url, createdAt];

  UserNotification toEntity() {
    return UserNotification(
      id: id,
      advert: advert.toEntity(),
      message: message,
      url: url,
      createdAt: DateTime.parse(createdAt!)
    );
  }

  factory NotificationResponse.fromMap(Map<String, dynamic> map) {
    return NotificationResponse(
      id: map['id'] ?? '',
      advert: AdvertResponse.fromMap(Map<String, dynamic>.from(map['advert'])),
      message: map['message'] ?? '',
      url: map['url'] ?? '',
      createdAt: map['createdAt'] ?? '',
    );
  }
}

class NotificationDataResponse extends Equatable {
  const NotificationDataResponse({required this.data, this.status});

  final int data;
  final String? status;

  @override
  List<Object?> get props => [data];

  NotificationData toEntity() {
    return NotificationData(data: data, status: status);
  }

  factory NotificationDataResponse.fromMap(Map<String, dynamic> map) {
    return NotificationDataResponse(
        data: map['data'] ?? '',
        status: map['status'] ?? ''
    );
  }
}

