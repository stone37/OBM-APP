import 'package:obm_market/modules/auth/models/entities/user.dart';
import 'package:obm_market/modules/auth/models/request/user_request.dart';
import 'package:obm_market/modules/auth/services/remote_user_auth_api.dart';

class UserAuthRepository {
  Future<UserAuth> authenticate({required String username, required String password}) {
    return RemoteUserAuthApi.getToken(UserAuthLoginRequest(username: username, password: password))
        .then((value) => value.toEntity());
  }

  Future<UserAuth> refresh({required String refreshToken}) {
    return RemoteUserAuthApi.getRefresh(UserAuthTokenRequest(token: refreshToken))
          .then((value) => value.toEntity());
  }

  Future<UserSocialAuth?> socialAuthenticate({
    required String service,
    required String id,
    required String email,
    required bool emailVerified
  }) {
    return RemoteUserAuthApi.socialAuth(
        UserSocialAuthRequest(
            service: service,
            id: id,
            email: email,
            emailVerified: emailVerified
        )
    ).then((value) => value!.toEntity());
  }

  Future<UserSocialAuth?> socialRegister({
    required String service,
    required String id,
    required String username,
    required String email,
    required String firstname,
    required String lastname,
    required String phone
  }) {
    return RemoteUserAuthApi.socialRegister(
        UserSocialRegisterRequest(
            id: id,
            service: service,
            email: email,
            username: username,
            firstname: firstname,
            lastname: lastname,
            phone: phone
        )
      ).then((value) => value!.toEntity());
  }

  Future<UserReset> reset({required String email}) {
    return RemoteUserAuthApi.reset(UserResetRequest(email: email))
        .then((value) => value!.toEntity());
  }
}

