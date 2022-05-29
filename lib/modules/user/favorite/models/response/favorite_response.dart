import 'package:equatable/equatable.dart';
import 'package:obm_market/modules/user/favorite/models/entities/favorite.dart';
import 'package:obm_market/modules/user/favorite/models/entities/favorite_check.dart';

import '../../../../advert/models/response/advert_response.dart';

class FavoriteResponse extends Equatable {
  const FavoriteResponse({
    this.id,
    this.user,
    this.advert,
    this.status
  });

  final int? id;
  final Map<String, dynamic>? user;
  final AdvertResponse? advert;
  final String? status;

  @override
  List<Object?> get props => [id, user, advert, status];

  Favorite toEntity() {
    return Favorite(
      id: id,
      user: user,
      advert: advert!.toEntity(),
      status: status
    );
  }

  factory FavoriteResponse.fromMap(Map<String, dynamic> map) {
    return FavoriteResponse(
      id: map['id'] ?? '',
      status: map['status'] ?? '',
      user: Map<String, dynamic>.from(map['user'] ?? []),
      advert: AdvertResponse.fromMap(Map<String, dynamic>.from(map['advert'])),
    );
  }
}

class FavoriteCheckResponse extends Equatable {
  const FavoriteCheckResponse({
    this.message,
    this.status
  });

  final bool? message;
  final String? status;

  @override
  List<Object?> get props => [message,  status];

  FavoriteCheck toEntity() {
    return FavoriteCheck(
      message: message,
      status: status
    );
  }

  factory FavoriteCheckResponse.fromMap(Map<String, dynamic> map) {
    return FavoriteCheckResponse(
      message: map['message'] ?? '',
      status: map['code'].toString(),
    );
  }
}

class FavoriteDeleteResponse extends Equatable {
  const FavoriteDeleteResponse({
    this.status
  });

  final String? status;

  @override
  List<Object?> get props => [status];

  Favorite toEntity() {
    return Favorite(
      status: status
    );
  }

  factory FavoriteDeleteResponse.fromMap(Map<String, dynamic> map) {
    return FavoriteDeleteResponse(
      status: map['status'] ?? '',
    );
  }
}



