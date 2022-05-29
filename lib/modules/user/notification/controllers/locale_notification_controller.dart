import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:obm_market/constants/app_theme.dart';

import '../../../../utils/utilities.dart';
import '../../../../views/screens/menu/menu_screen.dart';
import '../models/entities/notification.dart';
import '../repository/notification_repository.dart';

class LocaleNotificationController extends GetxController {

  final box = GetStorage();
  List<UserNotification?> notifications = [];


  @override
  void onInit() async {
    super.onInit();

    AwesomeNotifications().actionStream.listen((notification) {
      if (notification.channelKey == 'basic_channel' && Platform.isIOS) {
        AwesomeNotifications().getGlobalBadgeCounter().then((value) => AwesomeNotifications().setGlobalBadgeCounter(value - 1));
      }

      Get.off(() => MenuScreen());
    });
  }

  @override
  void onClose() {
    super.onClose();

    AwesomeNotifications().actionSink.close();
    AwesomeNotifications().createdSink.close();
  }

  void requestPermissions(BuildContext context) {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Autoriser les notifications'),
            content: Text('Notre application aimerait vous envoyer des notifications'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Ne pas autoriser',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ),
              TextButton(
                  onPressed: () => AwesomeNotifications()
                      .requestPermissionToSendNotifications()
                      .then((_) => Navigator.pop(context)),
                  child: Text(
                    'Autoriser',
                    style: TextStyle(
                      color: AppTheme.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ))
            ],
          ),
        );
      }
    });
  }

  Future<void> createNotification() async {

    print('Token State ${box.hasData('token')}');

    if (box.hasData('token')) {

      notifications = await NotificationRepository().findUnread(token: box.read('token'));
      print('notification length ${notifications.length}');

      if (notifications.isNotEmpty) {
        notifications.forEach((notification) async {
          String data = notification!.message.replaceAll('<strong>', '').replaceAll('</strong>', '');

          await AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: createUniqueId(),
              channelKey: 'basic_channel',
              title: 'OBM',
              body: '${Emojis.symbols_up_right_arrow} $data',
              bigPicture: (notification.advert.images.isNotEmpty) ? 'https://oblackmarket.com/public/'+ notification.advert.photoPrincipale() : 'asset://assets/images/no_photo.png',
              notificationLayout: NotificationLayout.BigPicture,
            ),
          );
        });
      }
    }
  }

  void configureSelectNotification() {
    AwesomeNotifications().actionStream.listen((notification) {
      if (notification.channelKey == 'basic_channel' && Platform.isIOS) {
        AwesomeNotifications().getGlobalBadgeCounter().then((value) => AwesomeNotifications().setGlobalBadgeCounter(value - 1));
      }

      Get.off(() => MenuScreen());
    });
  }

  Future<void> cancelScheduledNotifications() async {
    await AwesomeNotifications().cancelAllSchedules();
  }
}

