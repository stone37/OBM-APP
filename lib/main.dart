import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:obm_market/modules/auth/controllers/auth_controller.dart';
import 'package:obm_market/modules/menu/controllers/menu_controller.dart';
import 'package:obm_market/modules/settings/controllers/settings_controller.dart';
import 'package:obm_market/modules/user/notification/controllers/locale_notification_controller.dart';
import 'package:obm_market/utils/app_binding.dart';
import 'package:obm_market/views/screens/menu/menu_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:obm_market/views/widgets/message/successMessage.dart';
import 'constants/app_theme.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter/services.dart';

const String TASK_NAME = "background_notification";

late StreamSubscription _connectivitySubscription;
late bool _connectivityState = false;

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await GetStorage.init();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
  Workmanager().registerPeriodicTask(
    TASK_NAME,
    "periodicNotification",
    initialDelay: Duration(minutes: 1),
    frequency: Duration(minutes: 15),
  );

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      onInit: () {
        _connectivitySubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
          if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
            if (_connectivityState) showSuccessMessage(message: 'Connexion internet restaurée.', icon: Icons.wifi);
          } else {
            if (_connectivityState) showSuccessMessage(message: 'Vous êtes hors ligne.', icon: Icons.wifi_off);
          }

          _connectivityState = true;
        });

        initialization(context);

        FlutterNativeSplash.remove();
      },
      onDispose: () {
        _connectivitySubscription.cancel();
      },
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF0032FF, color),
        textTheme: AppTheme.textTheme,
      ),
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      initialBinding: AppBinding(),
      home: MenuScreen(),
    );
  }
}

void initialization(BuildContext context) async {
  await GetStorage.init();

  MenuController menuController = Get.put(MenuController());
  AuthController authController = Get.put(AuthController());
  SettingsController settingsController = Get.put(SettingsController());
  LocaleNotificationController notificationController = Get.put(LocaleNotificationController());

  await authController.autoLogin();
  await settingsController.getSettings();
  await menuController.goToHome();
  notificationController.requestPermissions(context);
}

Future<void> callbackDispatcher() async {
  Workmanager().executeTask((taskName, inputData) async {
    await GetStorage.init();

    AwesomeNotifications().initialize(
      'resource://drawable/app_icon',
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic Notifications',
          channelDescription: 'Basic Notifications',
          defaultColor: AppTheme.primary,
          importance: NotificationImportance.High,
          channelShowBadge: true,
          soundSource: 'resource://raw/res_custom_notification',
        ),
      ]
    );

    LocaleNotificationController notificationController = Get.put(LocaleNotificationController());
    await notificationController.createNotification();

    print('Execution d\'une tache');

    return Future.value(true);
  });
}

Map<int, Color> color = {
  50:Color.fromRGBO(0,50,255, .1),
  100:Color.fromRGBO(0,50,255, .2),
  200:Color.fromRGBO(0,50,255, .3),
  300:Color.fromRGBO(0,50,255, .4),
  400:Color.fromRGBO(0,50,255, .5),
  500:Color.fromRGBO(0,50,255, .6),
  600:Color.fromRGBO(0,50,255, .7),
  700:Color.fromRGBO(0,50,255, .8),
  800:Color.fromRGBO(0,50,255, .9),
  900:Color.fromRGBO(0,50,255, 1),
};

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

