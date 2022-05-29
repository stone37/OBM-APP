import 'package:equatable/equatable.dart';
import 'package:obm_market/modules/auth/models/entities/user.dart';

class UserAuthResponse extends Equatable {
  const UserAuthResponse({
    required this.token,
    required this.refreshToken,
    this.status
  });

  final String token;
  final String refreshToken;
  final String? status;

  @override
  List<Object?> get props => [token, refreshToken];

  UserAuth toEntity() {
    return UserAuth(token: token, refreshToken: refreshToken, status: status);
  }

  factory UserAuthResponse.fromMap(Map<String, dynamic> map) {
    return UserAuthResponse(
      token: map['token'] ?? '',
      refreshToken: map['refresh_token'] ?? '',
      status: map['status'] ?? ''
    );
  }
}

class UserSocialAuthResponse extends Equatable {
  const UserSocialAuthResponse({
    this.token,
    this.refreshToken,
    this.status
  });

  final String? token;
  final String? refreshToken;
  final String? status;

  @override
  List<Object?> get props => [token, refreshToken];

  UserSocialAuth toEntity() {
    return UserSocialAuth(token: token, refreshToken: refreshToken, status: status);
  }

  factory UserSocialAuthResponse.fromMap(Map<String, dynamic> map) {
    return UserSocialAuthResponse(
        token: map['token'] ?? '',
        refreshToken: map['refresh_token'] ?? '',
        status: map['status'] ?? ''
    );
  }
}

class UserResetResponse extends Equatable {
  const UserResetResponse({this.status});

  final String? status;

  @override
  List<Object?> get props => [status];

  UserReset  toEntity() {
    return UserReset(status: status);
  }

  factory UserResetResponse.fromMap(Map<String, dynamic> map) {
    return UserResetResponse(
        status: map['status'] ?? ''
    );
  }
}


