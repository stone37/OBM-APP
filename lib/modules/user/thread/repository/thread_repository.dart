import '../models/entities/thread.dart';
import '../models/request/thread_request.dart';
import '../services/remote_thread_api.dart';

class ThreadRepository {

  Future<List<Thread>> findAll({required String token}) {
    return RemoteThreadApi.findAll(ThreadRequest(token: token))
        .then((value) => value.map((e) => e.toEntity()).toList());
  }

  Future<Thread?> find({required int advertId, required String token}) {
    return RemoteThreadApi.find(ThreadDataRequest(id: advertId, token: token))
        .then((value) => (value == null) ? null : value.toEntity());
  }

  Future<ThreadData> create({required String message, required int advertId, required String token}) {
    return RemoteThreadApi.create(ThreadCreateRequest(message: message, advertId: advertId, token: token))
        .then((value) => value.toEntity());
  }

  Future<ThreadData> reply({required String message, required int id, required String token}) {
    return RemoteThreadApi.reply(ThreadReplyRequest(message: message, id: id, token: token))
        .then((value) => value.toEntity());
  }

  Future<ThreadData?> delete({required int id, required String token}) {
    return RemoteThreadApi.delete(ThreadDataRequest(id: id, token: token))
        .then((value) => value!.toEntity());
  }
}

