import 'package:equatable/equatable.dart';
import 'package:obm_market/modules/auth/models/entities/user.dart';

class UserResponse extends Equatable {
  const UserResponse({
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
    this.deleteAt,
    required this.lastLoginIp,
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
  final String createdAt;
  final String? lastLoginAt;
  final String? deleteAt;
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
    imageUrl,
    wallet,
    status
  ];

  User toEntity() {
    return User(
      id: id,
      username: username,
      email: email,
      firstname: firstname,
      lastname: lastname,
      phone: phone,
      city: city,
      address: address,
      createdAt: DateTime.parse(createdAt),
      lastLoginAt: (lastLoginAt != null && lastLoginAt!.isNotEmpty) ? DateTime.parse(lastLoginAt!) : null,
      deleteAt: (deleteAt != null) ? DateTime.parse(deleteAt!) : null,
      lastLoginIp: lastLoginIp,
      imageUrl: imageUrl,
      wallet: wallet,
      status: status);
  }

  factory UserResponse.fromMap(Map<String, dynamic> map) {

    return UserResponse(
      id: map['id'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      firstname: map['firstName'] ?? '',
      lastname: map['lastName'] ?? '',
      phone: map['phone'] ?? '',
      city: map['city'] ?? '',
      address: map['address'] ?? '',
      createdAt: map['createdAt'] ?? '',
      lastLoginAt: map['lastLoginAt'] ?? '',
      deleteAt: map['deleteAt'] ?? null,
      lastLoginIp: map['lastLoginIp'] ?? '',
      imageUrl: map['fileUrl'] ?? '',
      wallet: Map<String, dynamic>.from(map['wallet'] ?? []),
      status: map['status'] ?? ''
    );
  }
}

