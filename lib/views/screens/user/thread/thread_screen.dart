import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:obm_market/modules/auth/controllers/auth_controller.dart';
import 'package:obm_market/views/common/not_authorisation.dart';
import 'package:obm_market/views/screens/user/thread/thread_reply_screen.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:timeago/timeago.dart';

import '../../../../constants/app_theme.dart';
import '../../../../modules/user/thread/controllers/thread_controller.dart';
import '../../../../modules/user/thread/models/entities/thread.dart';

class ThreadScreen extends StatelessWidget {

  final ThreadController controller = Get.find();
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {

    timeago.setLocaleMessages('fr', FrShortMessages());

    return (authController.connected == false) ?
        NotAuthorisation(
          image: Image.asset('assets/images/messagerie.png'),
          title: 'Toutes vos conversations au même endroit.',
          description: 'Communiquez facilement depuis votre messagerie.'
        ) :
        Container(
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
                        FutureBuilder<List<Thread>>(
                          future: controller.getUserThread(),
                          builder: (BuildContext context, AsyncSnapshot<List<Thread>> snapshot) {
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
                                            padding: EdgeInsets.only(left: 65.0, right: 65.0, bottom: 20.0),
                                            child: Image.asset('assets/images/messagerie.png')
                                        ),
                                        Container(
                                            padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                                            child: Text(
                                              'Aucune conversation pour le moment !',
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w600,
                                                color: AppTheme.darkerText
                                              ),
                                              textAlign: TextAlign.center,
                                            )
                                        ),
                                        SizedBox(height: 62.0)
                                      ],
                                    )
                                );
                              } else {
                                return _buildThreadView(controller, context, snapshot.data);
                              }
                            }
                          },
                        ),
                        SizedBox(height: 50.0)
                      ],
                    ),
                  )
              )
            ],
          )
      );
  }

  _buildThreadView(ThreadController controller, BuildContext context, List<Thread>? threads) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: threads!.length,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return ThreadView(
            thread: threads[index],
            controller: controller,
            onTap: () => Get.to(() => ThreadReplyScreen(thread: threads[index]))
          );
        }
    );
  }
}

class ThreadView extends StatelessWidget {
  const ThreadView({
    Key? key,
    required this.thread,
    required this.controller,
    required this.onTap
  }) : super(key: key);

  final ThreadController controller;
  final Thread thread;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    //print(thread.messages.last);

    final box = GetStorage();

    return Container(
      padding: EdgeInsets.only(bottom: 3.0),
      child: Material(
        color: AppTheme.background,
        child: ListTile(
          contentPadding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 12.0, right: 10.0),
          visualDensity: VisualDensity.comfortable,
          dense: true,
          title: Container(
            child: Row(
              children: <Widget>[
                Container(
                  width: 48.0,
                  height: 48.0,
                  child: (thread.advert.images.isEmpty) ?
                  CircleAvatar(radius: 32, backgroundImage: AssetImage('assets/images/no_photo.png')) :
                  CircleAvatar(
                    radius: 32,
                    backgroundImage: CachedNetworkImageProvider('https://oblackmarket.com/public/' + thread.advert.photoPrincipale()),
                  ),
                ),
                SizedBox(width: 12.0),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.76,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: (thread.createdBy['id'] == box.read('user_id')) ?
                              Text(
                                '${thread.advert.user['username'].toString().capitalize} : ${thread.advert.title}',
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: AppTheme.darkerText,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.3,
                                  overflow: TextOverflow.ellipsis
                                )
                              ) :
                              Text(
                                '${thread.createdBy['username'].toString().capitalize} : ${thread.advert.title}',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: AppTheme.darkerText,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.3,
                                  overflow: TextOverflow.ellipsis
                                )
                              )
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 6.0),
                              child: Text(
                                '${timeago.format(DateTime.parse(thread.messages.last['createdAt']), locale: 'fr')}',
                                style: TextStyle(
                                  fontSize: 11.0,
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.3,
                                  overflow: TextOverflow.ellipsis
                                )
                              ),
                            )
                          ],
                        )
                      ),
                      SizedBox(height: 4.0),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.77,
                        child: Text(
                          '${thread.messages.last['body']}',
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 12.5,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.3,
                            overflow: TextOverflow.ellipsis
                          )
                        )
                      )
                    ],
                  ),
                )
              ],
            )
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}

class FrShortMessages implements LookupMessages {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => "d'ici";
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => '$seconds s';
  @override
  String aboutAMinute(int minutes) => '$minutes min';
  @override
  String minutes(int minutes) => '$minutes min';
  @override
  String aboutAnHour(int minutes) => '1 h';
  @override
  String hours(int hours) => '$hours h';
  @override
  String aDay(int hours) => 'hier';
  @override
  String days(int days) => '$days jours';
  @override
  String aboutAMonth(int days) => '1 mois';
  @override
  String months(int months) => '$months mois';
  @override
  String aboutAYear(int year) => '1 an';
  @override
  String years(int years) => '$years ans';
  @override
  String wordSeparator() => ' ';
}

