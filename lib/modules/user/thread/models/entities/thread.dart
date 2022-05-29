import 'package:equatable/equatable.dart';
import '../../../../advert/models/entities/advert.dart';

class Thread extends Equatable {
  const Thread({
    required this.id,
    required this.advert,
    required this.messages,
    required this.createdBy,
    this.metadata,
    this.participants,
    this.createdAt,
  });

  final int id;
  final Advert advert;
  final List<Map<String, dynamic>> messages;
  final Map<String, dynamic> createdBy;
  final List<Map<String, dynamic>>? metadata;
  final List<Map<String, dynamic>>? participants;
  final DateTime? createdAt;

  @override
  List<Object?> get props => [id, advert, messages, createdBy];
}

class ThreadData extends Equatable {
  const ThreadData({this.message, this.status});

  final String? message;
  final String? status;

  @override
  List<Object?> get props => [message];
}

class ChatMessage extends Equatable {
  ChatMessage({required this.content, required this.type, this.createdAt});

  final String content;
  final String type;
  final DateTime? createdAt;

  @override
  List<Object?> get props => [content, type, createdAt];
}



