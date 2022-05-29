import 'package:image_picker/image_picker.dart';
import 'package:obm_market/modules/auth/models/entities/user.dart';
import 'package:obm_market/modules/auth/models/request/user_request.dart';
import 'package:obm_market/modules/auth/services/remote_user_api.dart';

class UserRepository {

  Future<User> add({
    required String username,
    required String email,
    required String firstname,
    required String lastname,
    required String phone,
    required bool phoneStatus,
    required String password}) {

    return RemoteUserApi.add(UserCreateRequest(
        username: username,
        email: email,
        firstname: firstname,
        lastname: lastname,
        phone: phone,
        phoneStatus: phoneStatus,
        password: password)).then((value) => value!.toEntity());
  }

  Future<User> delete({required String token, required int id, required String password}) {
    return RemoteUserApi.delete(UserPutRequest(id: id, password: password, token: token))
        .then((value) => value!.toEntity());
  }

  Future<User> deleteCancel({required String token, required int id, required String deleteAt}) {
    return RemoteUserApi.deleteCancel(UserCancelRequest(id: id, deleteAt: deleteAt, token: token))
        .then((value) => value!.toEntity());
  }

  Future<User> edit({
    required String token,
    required int id,
    required String username,
    required String email,
    required String firstname,
    required String lastname,
    required String phone,
    bool? phoneStatus,
    String? city,
    String? address}) {
    return RemoteUserApi.edit(UserEditRequest(
        username: username,
        id: id,
        email: email,
        firstname: firstname,
        lastname: lastname,
        phone: phone,
        phoneStatus: phoneStatus,
        city: city,
        address: address,
        token: token))
        .then((value) => value!.toEntity());
  }

  Future<User> passwordChange({required String token, required id, required password}) {
    return RemoteUserApi.passwordChange(UserPutRequest(id: id, password: password, token: token))
        .then((value) => value!.toEntity());
  }

  Future<User> find({required String token}) {
    return RemoteUserApi.find(UserRequest(token: token)).then((value) => value!.toEntity());
  }

  Future<User> upload({required String token, required id,  required XFile image}) {
    return RemoteUserApi.upload(UserImageRequest(id: id, token: token, image: image))
        .then((value) => value!.toEntity());
  }
}
