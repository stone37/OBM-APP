import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.city,
    required this.address,
    required this.createdAt,
    required this.lastLoginAt,
    required this.lastLoginIp,
    this.deleteAt,
    required this.imageUrl,
    required this.wallet,
    this.status
  });

  final int id;
  final String username;
  final String email;
  final String firstname;
  final String lastname;
  final String phone;
  final String city;
  final String address;
  final DateTime createdAt;
  final DateTime? lastLoginAt;
  final DateTime? deleteAt;
  final String lastLoginIp;
  final String imageUrl;
  final Map<String, dynamic> wallet;
  final String? status;


  @override
  List<Object?> get props => [
    id,
    username,
    email,
    firstname,
    lastname,
    phone,
    city,
    address,
    createdAt,
    lastLoginAt,
    lastLoginIp,
    deleteAt,
    imageUrl,
    wallet,
    status
  ];
}

class UserAuth extends Equatable {
  const UserAuth({required this.token, required this.refreshToken, this.status});

  final String token;
  final String refreshToken;
  final String? status;

  @override
  List<Object?> get props => [token, refreshToken, status];
}

class UserSocialAuth extends Equatable {
  const UserSocialAuth({this.token, this.refreshToken, this.status});

  final String? token;
  final String? refreshToken;
  final String? status;

  @override
  List<Object?> get props => [token, refreshToken, status];
}

class UserSocialData extends Equatable {
  const UserSocialData({
    required this.service,
    required this.id,
    required this.email,
    required this.firstname,
    required this.lastname
  });

  final String service;
  final String id;
  final String email;
  final String firstname;
  final String lastname;

  @override
  List<Object?> get props => [service, id, email, firstname, lastname];
}

class UserReset extends Equatable {
  const UserReset({this.status});

  final String? status;

  @override
  List<Object?> get props => [status];
}


