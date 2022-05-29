import 'package:equatable/equatable.dart';

class FavoriteRequest extends Equatable {
  const FavoriteRequest({
    required this.advertId,
    required this.token,
  });

  final int advertId;
  final String token;

  @override
  List<Object?> get props => [advertId, token];

  Map toMap() {
    return {};
  }
}

class UserFavoriteRequest extends Equatable {
  const UserFavoriteRequest({
    required this.userId,
    required this.token,
  });

  final int userId;
  final String token;

  @override
  List<Object?> get props => [userId, token];

  Map toMap() {
    return {};
  }
}




