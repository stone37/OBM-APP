import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:obm_market/modules/user/notification/controllers/notification_controller.dart';
import 'package:html_character_entities/html_character_entities.dart';

import '../../../../constants/app_theme.dart';
import '../../../../modules/user/notification/models/entities/notification.dart';
import '../../../widgets/appbar/search_icon.dart';

class NotificationScreen extends StatelessWidget {

  final NotificationController controller = Get.find();
  final box = GetStorage();
  final globalKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    final int notificationUnreadNb = (box.read('user_notification_unread_nb') != null) ? box.read('user_notification_unread_nb') : 0;
    box.remove('user_notification_unread_nb');

    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppTheme.primary,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light,
          ),
          elevation: 3.0,
          backgroundColor: AppTheme.primary,
          iconTheme: IconThemeData(color: AppTheme.white),
          title: Text(
            'Notifications',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.3
            )
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            splashRadius: 20.0,
            onPressed: () => Get.back(),
          ),
          actions: <Widget> [
            Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: Stack(
                children: <Widget>[
                  IconButton(
                    onPressed: null,
                    icon: Icon(FontAwesomeIcons.bell, size: 20.0, color: AppTheme.white),
                    splashRadius: 20.0,
                  ),
                  (notificationUnreadNb != 0) ? Positioned(
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
                        '$notificationUnreadNb',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11.0,
                          fontWeight: FontWeight.w500
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ) : SizedBox()
                ],
              ),
            ),
            SearchIcon()
          ]
        ),
        body: Container(
          color: AppTheme.background,
          padding: EdgeInsets.symmetric(vertical: 10.0),
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      FutureBuilder<List<UserNotification>>(
                        future: controller.getUserNotification(),
                        builder: (BuildContext context, AsyncSnapshot<List<UserNotification>> snapshot) {
                          if (!snapshot.hasData) {
                            return Padding(
                              padding: EdgeInsets.only(top: 50.0),
                              child: Center(child: CircularProgressIndicator(color: AppTheme.primary)),
                            );
                          } else {
                            if (snapshot.data!.isEmpty) {
                              return Container(
                                  padding: EdgeInsets.only(right: 20, left: 20, top: MediaQuery.of(context).size.height*0.18),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 25.0),
                                        child: Icon(FontAwesomeIcons.bell, size: 80.0, color: AppTheme.grey)
                                      ),
                                      Container(
                                          padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                                          child: Text(
                                            'Aucune notification pour le moment !',
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w600,
                                                color: AppTheme.grey
                                            ),
                                            textAlign: TextAlign.center,
                                          )
                                      ),
                                      SizedBox(height: 62.0)
                                    ],
                                  )
                              );
                            } else {
                              return _buildNotificationView(snapshot.data, context, notificationUnreadNb);
                            }
                          }
                        },
                      ),
                      SizedBox(height: 50.0)
                    ],
                  ),
                ),
              )
            ],
          ),
        )
    );
  }

  Widget _buildNotificationView(
      List<UserNotification>? notifications,
      BuildContext context,
      int notificationUnreadNb) {

    controller.notificationId.value = [];

    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      itemCount: notifications!.length,
      itemBuilder: (BuildContext context, int index) {
        final notification = notifications[index];
        controller.notificationId.add(notification.id);

        return Obx(() => (controller.notificationId.contains(notification.id)) ?
          _notificationView(
              notifications[index],
              notificationUnreadNb,
              index,
              () {controller.notificationId.remove(notification.id);}
          ) : SizedBox());
      }
    );
  }

  Widget _notificationView(UserNotification notification, int notificationUnreadNb, int index,  VoidCallback onPressed) {

    String data = notification.message.replaceAll('<strong>', '').replaceAll('</strong>', '');
    const startWord = "<strong>";
    const endWord = "</strong>";

    final startIndex = notification.message.indexOf(startWord);
    final endIndex = notification.message.indexOf(endWord, startIndex + startWord.length);

    final String firstText = notification.message.substring(startIndex + startWord.length, endIndex);
    final String lastText = notification.message.substring(endIndex + endWord.length, notification.message.length);

    return Container(
        margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: ListTile(
            contentPadding: EdgeInsets.only(top: 1.0, bottom: 1.0, right: 10.0),
            visualDensity: VisualDensity.compact,
            leading: Container(
              margin: EdgeInsets.only(left: 2.0),
              width: 65,
              height: 50,
              child: (notification.advert.images.isEmpty) ?
              CircleAvatar(radius: 32, backgroundImage: AssetImage('assets/images/no_photo.png')) :
              CircleAvatar(
                radius: 32,
                backgroundImage: CachedNetworkImageProvider('https://oblackmarket.com/public/' + notification.advert.photoPrincipale()),
              )
            ),
            title: (notification.message.contains(startWord)) ?
            RichText(
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                text: '$firstText',
                style: TextStyle(
                  fontSize: 14.0,
                  color: AppTheme.darkerText,
                  fontWeight: ((index+1) < notificationUnreadNb) ? FontWeight.bold : FontWeight.w600,
                  letterSpacing: 0.3
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: HtmlCharacterEntities.decode('$lastText'),
                    style: TextStyle(
                      fontSize: 14.0,
                      color: ((index+1) < notificationUnreadNb) ? AppTheme.darkText : AppTheme.grey,
                      fontWeight: ((index+1) < notificationUnreadNb) ? FontWeight.w500 : FontWeight.w400,
                      letterSpacing: 0.3,
                    )
                  )
                ],
              ),
            ) :
            Text(
              HtmlCharacterEntities.decode(data),
              style:TextStyle(
                fontSize: 14.0,
                color: AppTheme.grey,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.3,
              )
            ),
        )
    );
  }
}

