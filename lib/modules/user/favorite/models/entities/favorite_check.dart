import 'package:equatable/equatable.dart';

class FavoriteCheck extends Equatable {
  const FavoriteCheck({
    this.message,
    this.status,
  });

  final bool? message;
  final String? status;

  @override
  List<Object?> get props => [message, status];
}


