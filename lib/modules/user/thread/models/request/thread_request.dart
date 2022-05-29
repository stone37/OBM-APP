import 'package:equatable/equatable.dart';

class ThreadRequest extends Equatable {
  const ThreadRequest({required this.token});

  final String token;

  @override
  List<Object?> get props => [token];
}

class ThreadCreateRequest extends Equatable {
  const ThreadCreateRequest({
    required this.advertId,
    required this.message,
    required this.token
  });

  final int advertId;
  final String message;
  final String token;

  @override
  List<Object?> get props => [advertId, message, token];

  Map<String, dynamic> toMap() {
    final queryParameters = {
      'message': message,
    };

    return queryParameters;
  }
}

class ThreadReplyRequest extends Equatable {
  const ThreadReplyRequest({
    required this.id,
    required this.message,
    required this.token
  });

  final int id;
  final String message;
  final String token;

  @override
  List<Object?> get props => [id, message, token];

  Map<String, dynamic> toMap() {
    final queryParameters = {
      'message': message,
    };

    return queryParameters;
  }
}

class ThreadDataRequest extends Equatable {
  const ThreadDataRequest({
    required this.id,
    required this.token
  });

  final int id;
  final String token;

  @override
  List<Object?> get props => [id, token];
}
