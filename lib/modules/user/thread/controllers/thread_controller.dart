import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../advert/controllers/user_advert_controller.dart';
import '../models/entities/thread.dart';
import '../repository/thread_repository.dart';

class ThreadController extends GetxController {

  UserAdvertController userAdvertController = Get.find();
  TextEditingController messageController = TextEditingController();
  final box = GetStorage();
  ThreadData? threadData;
  RxList<ChatMessage> messages = [ChatMessage(content: '', type: '')].obs;

  @override
  void onInit() {
    initMessage();

    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();

    messageController.dispose();
  }

  Future<List<Thread>> getUserThread() async {
    return await ThreadRepository().findAll(token: box.read('token'));
  }

  Future<bool> create({required String message, required int advertId}) async {
    threadData = await ThreadRepository().create(message: message, advertId: advertId,token: box.read('token'));

    if (threadData!.status == '201') {
      return true;
    }

    return false;
  }

  reply({required String message, required int id}) async {
    return await ThreadRepository().reply(message: message, id: id, token: box.read('token'));
  }

  sendMessage({required int id}) async {
    if (messageController.text.isNotEmpty) {
      final message = messageController.text;
      messageController.clear();

      messages.add(ChatMessage(content: message, type: 'sender', createdAt: DateTime.now()));

      Thread? thread = await userAdvertController.findThread(advertId: id);

      if (thread != null) {
        await reply(message: message, id: thread.id);
      } else {
        await create(message: message, advertId: id);
      }

      print(messages);
    }
  }

  replyMessage({required int id}) async {
    if (messageController.text.isNotEmpty) {
      final message = messageController.text;
      messageController.clear();

      messages.add(ChatMessage(content: message, type: 'sender', createdAt: DateTime.now()));

      print('Reply server !!!');
      await reply(message: message, id: id);

      print(messages);
    }
  }

  initMessage() {
    messages.value = [ChatMessage(content: '', type: '')];
  }

  /*hydrateMessage(Thread thread) {
    //initMessage();

    //final List<Map<String, dynamic>> messages = thread.messages;
    final userId = box.read('user_id');

    print('Initialize !!!!!!');

    thread.messages.forEach((message) {
      messages.add(ChatMessage(
        content: message['body'],
        type: (message['sender']['id'] == userId) ? 'sender' : 'receiver',
        createdAt: DateTime.parse(message['createdAt'])
      ));
    });
  }*/
}

