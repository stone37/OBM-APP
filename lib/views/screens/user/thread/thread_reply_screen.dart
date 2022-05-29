import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:html_character_entities/html_character_entities.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../constants/app_theme.dart';
import '../../../../modules/user/thread/controllers/thread_controller.dart';
import '../../../../modules/user/thread/models/entities/thread.dart';


class ThreadReplyScreen extends StatelessWidget {
  ThreadReplyScreen({required this.thread});

  final Thread thread;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ThreadController controller = Get.find();
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('fr', timeago.FrMessages());

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppTheme.background,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
        toolbarHeight: 144,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppTheme.background,
        flexibleSpace: SafeArea(child: _appBar(context)),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                    child: Column(
                      children: <Widget>[
                        ListView.builder(
                          itemCount: thread.messages.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            ChatMessage message = messageFormat(thread.messages[index]);

                            return (message.content.isNotEmpty) ? messageView(message, context) : SizedBox();
                          },
                        ),

                        Obx(() => ListView.builder(
                          itemCount: controller.messages.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.only(top: 0.0, bottom: 10.0),
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            ChatMessage message = controller.messages[index];

                            return (message.content.isNotEmpty) ? messageView(message, context) : SizedBox();
                          },
                        ))
                      ],
                    )
                  ),
                  SizedBox(height: 50.0)
                ],
              ),
            ),
          ),
          _senderForm(context)
        ],
      )
    );
  }

  Widget _appBar(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(right: 16.0, top: 5.0),
      child: Column(
        children: [
          (thread.createdBy['id'] == box.read('user_id')) ?
            _userData(thread.advert.user, context) : _userData(thread.createdBy, context),
          Container(
              padding: EdgeInsets.all(5.0),
              margin: EdgeInsets.only(left: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppTheme.background,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.grey.withOpacity(0.2),
                    offset: const Offset(3, 3),
                    blurRadius: 4.0
                  ),
                ]
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 40.0,
                    height: 40.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      child: (thread.advert.images.isEmpty) ?
                      Image.asset('assets/images/no_photo.png', fit: BoxFit.cover) :
                      CachedNetworkImage(
                        imageUrl: 'https://oblackmarket.com/public/' + thread.advert.photoPrincipale(),
                        fit: BoxFit.cover
                      ),
                    )
                  ),
                  SizedBox(width: 12.0),
                  Container(
                    width: MediaQuery.of(context).size.width*.7,
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            '${thread.advert.title}',
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 14.0,
                                color: AppTheme.darkerText,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.3,
                                overflow: TextOverflow.ellipsis
                            ),
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                '${thread.advert.price}',
                                maxLines: 1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                    color: AppTheme.defaults,
                                    overflow: TextOverflow.fade
                                ),
                              ),
                              SizedBox(width: 1.0),
                              Padding(
                                padding: EdgeInsets.only(top: 2.0),
                                child: Text(
                                  'CFA',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0,
                                    color: AppTheme.defaults,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
          ),
          SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
            margin: EdgeInsets.only(left: 16.0),
            color: AppTheme.danger_color,
            child: Text(
              'Soyez vigilant, refusez les transferts d\'argent ou le versement d\'acompte',
              style: TextStyle(
                  fontSize: 10.5,
                  color: AppTheme.white,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.3
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _userData(Map<String, dynamic> user, BuildContext context) {

    return Row(
      children: <Widget>[
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.black),
          splashRadius: 20.0,
        ),
        SizedBox(width: 2.0),
        (user['fileUrl'] == null) ?
          Container(
            width: 32.0,
            height: 32.0,
            child: CircleAvatar(
              backgroundColor: AppTheme.primary,
              maxRadius: 20.0,
              child: Container(
                child: Text(
                  '${user['username'][0]}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.white
                  ),
                ),
              )
            ),
          ) : CircleAvatar(
            backgroundImage: NetworkImage('https://oblackmarket.com/public/' + user['fileUrl']),
            maxRadius: 20.0,
          ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '${user['username']}',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600
                )
              ),
              SizedBox(height: 3.0),
              Text(
                'Connecté ${timeago.format(DateTime.parse(user['lastLoginAt']), locale: 'fr')}',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12.0
                )
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _senderForm(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        padding: EdgeInsets.only(left: 10.0, bottom: 10.0, top: 10.0),
        height: 60.0,
        width: double.infinity,
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: Row(
            children: <Widget>[
              Container(
                height: 33.0,
                width: 33.0,
                decoration: BoxDecoration(
                  color: AppTheme.primary,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Icon(Icons.mail, color: Colors.white, size: 20.0),
              ),
              SizedBox(width: 15.0),
              Expanded(
                child: TextField(
                  //key: ,
                  focusNode: FocusNode(),
                  controller: controller.messageController,
                  decoration: InputDecoration(
                    hintText: "Ecrivez votre message...",
                    hintStyle: TextStyle(color: Colors.black54),
                    border: InputBorder.none
                  ),
                ),
              ),
              SizedBox(width: 15.0),
              FloatingActionButton(
                onPressed: () async {
                  await controller.replyMessage(id: thread.id);
                },
                child: Icon(Icons.send, color: Colors.white, size: 20.0),
                backgroundColor: AppTheme.primary,
                elevation: 0,
              ),
            ],
          ),
        )
      ),
    );
  }

  Widget messageView(ChatMessage message, BuildContext context) {

    return Container(
      padding: EdgeInsets.only(left: 14.0, right: 14.0, top: 5.0, bottom: 5.0),
      child: Align(
        alignment: (message.type == 'receiver') ? Alignment.topLeft : Alignment.topRight,
        child: Container(
          padding: EdgeInsets.only(top: 12.0, bottom: 5.0, left: 15.0, right: 15.0),
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*.78),
          decoration: BoxDecoration(
            color: (message.type == 'receiver') ? AppTheme.primary.withOpacity(0.9) : AppTheme.darkerText.withOpacity(0.1),
            borderRadius: (message.type == 'receiver') ?
             BorderRadius.only(
               topRight: Radius.circular(30),
               topLeft: Radius.circular(30),
               bottomRight: Radius.circular(30),
               bottomLeft: Radius.zero
             ) :
            BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
              bottomRight: Radius.zero,
              bottomLeft: Radius.circular(30),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                child: Text(
                  HtmlCharacterEntities.decode(message.content),
                  style: TextStyle(
                    fontSize: 14.5,
                    color: (message.type == 'receiver') ? AppTheme.white : AppTheme.darkerText,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.3
                  )
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: (message.type == 'receiver') ? 4.0 : 1.0, top: 0),
                child: Text(
                  '${_messageDate(message.createdAt!)}',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 10.0,
                    color: (message.type == 'receiver') ? AppTheme.white : AppTheme.darkerText.withOpacity(0.6),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.3,
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
    
  }

  String _messageDate(DateTime dateTime) {
    final today = DateTime.now();
    final yesterday = DateTime.now().subtract(Duration(days:1));

    if (today.isSameDate(dateTime)) {
      return '${_formatHour(dateTime)}:${_formatMin(dateTime)}';
    } else if(yesterday.isSameDate(dateTime)) {
      return 'Hier .${_formatHour(dateTime)}:${_formatMin(dateTime)}';
    } else {
      if (today.year == dateTime.year) {
        return '${_formatDay(dateTime)}/${_formatMonth(dateTime)} .${_formatHour(dateTime)}:${_formatMin(dateTime)}';
      } else {
        return '${_formatDay(dateTime)}/${_formatMonth(dateTime)}/${dateTime.year} .${_formatHour(dateTime)}:${_formatMin(dateTime)}';
      }
    }
  }

  String _formatHour(DateTime dateTime) {
    return (dateTime.hour < 10) ? '0${dateTime.hour}' : '${dateTime.hour}';
  }

  String _formatMin(DateTime dateTime) {
    return (dateTime.minute < 10) ? '0${dateTime.minute}' : '${dateTime.minute}';
  }

  String _formatDay(DateTime dateTime) {
    return (dateTime.day < 10) ? '0${dateTime.day}' : '${dateTime.day}';
  }

  String _formatMonth(DateTime dateTime) {
    return (dateTime.month < 10) ? '0${dateTime.month}' : '${dateTime.month}';
  }

  ChatMessage messageFormat(Map<String, dynamic> message) {
    final userId = box.read('user_id');

    return ChatMessage(
        content: message['body'],
        type: (message['sender']['id'] == userId) ? 'sender' : 'receiver',
        createdAt: DateTime.parse(message['createdAt'])
    );
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}



