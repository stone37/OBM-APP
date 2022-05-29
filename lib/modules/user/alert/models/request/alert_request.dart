import 'package:equatable/equatable.dart';

class AlertCreateRequest extends Equatable {
  const AlertCreateRequest({
    required this.categoryId,
    required this.token,
  });

  final int categoryId;
  final String token;

  @override
  List<Object?> get props => [categoryId, token];

  Map toMap() {
    return {};
  }
}


class AlertRequest extends Equatable {
  const AlertRequest({
    required this.id,
    required this.token,
  });

  final int id;
  final String token;

  @override
  List<Object?> get props => [id, token];

  Map toMap() {
    return {};
  }
}
