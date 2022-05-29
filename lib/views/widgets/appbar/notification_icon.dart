import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:obm_market/modules/auth/controllers/auth_controller.dart';
import 'package:obm_market/modules/user/notification/controllers/notification_controller.dart';

import '../../../constants/app_theme.dart';
import '../../../modules/user/notification/models/entities/notification.dart';
import '../../screens/user/notification/notification_screen.dart';

class NotificationIcon extends StatelessWidget {

  final NotificationController controller = Get.find();
  final AuthController authController = Get.find();
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {

    return (authController.connected) ? Padding(
      padding: EdgeInsets.only(top: 5.0),
      child: Stack(
        children: <Widget>[
          IconButton(
            onPressed: () {
              Get.to(
                () => NotificationScreen(),
                transition: Transition.cupertino,
                duration: Duration(milliseconds: 500)
              );
            },
            icon: Icon(FontAwesomeIcons.bell, size: 20.0),
            splashRadius: 20.0,
          ),
          FutureBuilder<NotificationData>(
            future: controller.getUserNrUnReadNotification(),
            builder: (BuildContext context, AsyncSnapshot<NotificationData> snapshot) {
              if (!snapshot.hasData) {
                return SizedBox();
              } else {

                box.write('user_notification_unread_nb', snapshot.data!.data);

                return (snapshot.data!.data != 0) ?
                  Positioned(
                    right: 7.0,
                    top: 12,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: AppTheme.defaults,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      constraints: BoxConstraints(minWidth: 18, minHeight: 18),
                      child: Text(
                        '${snapshot.data!.data}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11.0,
                          fontWeight: FontWeight.w500
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ) : SizedBox();
              }
            },
          )
        ],
      ),
    ) : SizedBox();
  }
}
