import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class UserCreateRequest extends Equatable {
  const UserCreateRequest({
    required this.username,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.phoneStatus,
    required this.password
  });

  final String username;
  final String email;
  final String firstname;
  final String lastname;
  final String phone;
  final bool phoneStatus;
  final String password;

  @override
  List<Object?> get props => [
    username,
    email,
    firstname,
    lastname,
    phone,
    phoneStatus,
    password
  ];

  Map<String, dynamic> toMap() {
    final queryParameters = {
      'username': username,
      'email': email,
      'firstName': firstname,
      'lastName': lastname,
      'phone': phone,
      'phoneStatus': phoneStatus,
      'password': password,
    };

    return queryParameters;
  }
}

class UserEditRequest extends Equatable {
  const UserEditRequest({
    required this.username,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.phone,
    this.phoneStatus,
    this.city,
    this.address,
    required this.id,
    required this.token,
  });

  final String username;
  final String email;
  final String firstname;
  final String lastname;
  final String phone;
  final bool? phoneStatus;
  final String? city;
  final String? address;
  final String token;
  final int id;

  @override
  List<Object?> get props => [
    username,
    email,
    firstname,
    lastname,
    phone,
    phoneStatus,
    city,
    address,
    token,
    id
  ];

  Map<String, dynamic> toMap() {
    final queryParameters = {
      'username': username,
      'email': email,
      'firstName': firstname,
      'lastName': lastname,
      'phone': phone,
      'phoneStatus': phoneStatus,
      if (city!.isNotEmpty) 'city': city,
      if (address!.isNotEmpty) 'address': address,
    };

    return queryParameters;
  }
}

class UserRequest extends Equatable {
  const UserRequest({
    required this.token,
  });

  final String token;

  @override
  List<Object?> get props => [
    token
  ];
}

class UserPutRequest extends Equatable {
  const UserPutRequest({
    required this.id,
    required this.password,
    required this.token,
  });

  final int id;
  final String password;
  final String token;

  @override
  List<Object?> get props => [
    id,
    password,
    token
  ];

  Map<String, dynamic> toMap() {
    final queryParameters = {
      "password": password
    };

    return queryParameters;
  }
}

class UserAuthLoginRequest extends Equatable {
  const UserAuthLoginRequest({required this.username, required this.password});

  final String username;
  final String password;

  @override
  List<Object?> get props => [username, password];

  Map<String, dynamic> toMap() {
    final queryParameters = {'username': username, 'password': password};

    return queryParameters;
  }
}

class UserAuthTokenRequest extends Equatable {
  const UserAuthTokenRequest({required this.token});

  final String token;

  @override
  List<Object?> get props => [token];

  Map<String, dynamic> toMap() {
    final queryParameters = {'refresh_token': token};

    return queryParameters;
  }
}

class UserImageRequest extends Equatable {
  const UserImageRequest({required this.id, required this.image, required this.token});

  final int id;
  final XFile image;
  final String token;

  @override
  List<Object?> get props => [image, token, id];
}

class UserCancelRequest extends Equatable {
  const UserCancelRequest({
    required this.id,
    required this.deleteAt,
    required this.token,
  });

  final int id;
  final String deleteAt;
  final String token;

  @override
  List<Object?> get props => [
    id,
    deleteAt,
    token
  ];

  Map<String, dynamic> toMap() {
    final queryParameters = {
      "deleteAt": deleteAt
    };

    return queryParameters;
  }
}

class UserSocialAuthRequest extends Equatable {
  const UserSocialAuthRequest({
    required this.id,
    required this.service,
    required this.email,
    required this.emailVerified,
  });

  final String id;
  final String service;
  final String email;
  final bool emailVerified;

  @override
  List<Object?> get props => [id, service, email, emailVerified];

  Map<String, dynamic> toMap() {
    final queryParameters = {
      "service": service,
      "id": id,
      "email": email,
      "email_verified": emailVerified
    };

    return queryParameters;
  }
}


class UserSocialRegisterRequest {
  const UserSocialRegisterRequest({
    required this.id,
    required this.service,
    required this.email,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.phone,
  });

  final String id;
  final String service;
  final String email;
  final String username;
  final String firstname;
  final String lastname;
  final String phone;

  @override
  List<Object?> get props => [id, service, email, username, firstname, lastname, phone];

  Map<String, dynamic> toMap() {
    final queryParameters = {
      'service': service,
      'id': id,
      'email': email,
      'username': username,
      'firstName': firstname,
      'lastName': lastname,
      'phone': phone
    };

    return queryParameters;
  }
}

class UserResetRequest {
  const UserResetRequest({required this.email});

  final String email;

  @override
  List<Object?> get props => [email];

  Map<String, dynamic> toMap() {
    final queryParameters = {'email': email};

    return queryParameters;
  }
}


