import 'package:equatable/equatable.dart';
import 'package:obm_market/modules/advert/models/response/advert_response.dart';

import '../entities/thread.dart';

class ThreadResponse extends Equatable {
  const ThreadResponse({
    required this.id,
    required this.advert,
    required this.messages,
    required this.createdBy,
    this.metadata,
    this.participants,
    this.createdAt
  });

  final int id;
  final AdvertResponse advert;
  final List<Map<String, dynamic>> messages;
  final Map<String, dynamic> createdBy;
  final List<Map<String, dynamic>>? metadata;
  final List<Map<String, dynamic>>? participants;
  final String? createdAt;

  @override
  List<Object?> get props => [id, advert, messages, createdBy, metadata, participants, createdAt];

  Thread toEntity() {
    return Thread(
      id: id,
      advert: advert.toEntity(),
      messages: messages,
      createdBy: createdBy,
      metadata: metadata,
      participants: participants,
      createdAt: DateTime.parse(createdAt!)
    );
  }

  factory ThreadResponse.fromMap(Map<String, dynamic> map) {
    return ThreadResponse(
      id: map['id'] ?? '',
      advert: AdvertResponse.fromMap(Map<String, dynamic>.from(map['advert'])),
      messages: List<Map<String, dynamic>>.from(map['messages'] ?? []),
      createdBy: Map<String, dynamic>.from(map['createdBy']),
      metadata: List<Map<String, dynamic>>.from(map['metadata'] ?? []),
      participants: List<Map<String, dynamic>>.from(map['participants'] ?? []),
      createdAt: map['createdAt'] ?? '',
    );
  }
}

class ThreadDataResponse extends Equatable {
  const ThreadDataResponse({required this.message, this.status});

  final String message;
  final String? status;

  @override
  List<Object?> get props => [message];

  ThreadData toEntity() {
    return ThreadData(message: message, status: status);
  }

  factory ThreadDataResponse.fromMap(Map<String, dynamic> map) {
    return ThreadDataResponse(
        message: map['message'] ?? '',
        status: map['status'] ?? ''
    );
  }
}

