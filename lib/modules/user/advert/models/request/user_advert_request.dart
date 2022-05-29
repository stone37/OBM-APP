import 'package:equatable/equatable.dart';

class UserAdvertRequest extends Equatable {
  const UserAdvertRequest({required this.id});

  final int id;

  @override
  List<Object?> get props => [id];

  Map toMap() {
    return {};
  }
}
