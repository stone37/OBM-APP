import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:html_character_entities/html_character_entities.dart';
import 'package:obm_market/modules/user/thread/models/entities/thread.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../constants/app_theme.dart';
import '../../../../modules/advert/models/entities/advert.dart';
import '../../../../modules/user/thread/controllers/thread_controller.dart';


class ThreadSendScreen extends StatelessWidget {
  ThreadSendScreen({required this.advert});

  final Advert advert;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ThreadController controller = Get.find();

  @override
  Widget build(BuildContext context) {

    timeago.setLocaleMessages('fr', timeago.FrMessages());

    return Scaffold(
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
                  Obx(() => Flexible(
                      child: ListView.builder(
                        itemCount: controller.messages.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          ChatMessage message = controller.messages[index];

                          return (message.content.isEmpty) ?
                            SizedBox() :
                            Container(
                              padding: EdgeInsets.only(left: 14.0, right: 14.0, top: 5.0, bottom: 5.0),
                              child: Align(
                                alignment: (message.type == 'receiver') ? Alignment.topLeft : Alignment.topRight,
                                child: Container(
                                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*.78),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: (message.type == 'receiver') ? AppTheme.grey.withOpacity(.1) : Colors.blue[100],
                                  ),
                                  padding: EdgeInsets.only(top: 8.0, bottom: 3.0, left: 15.0, right: 15.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        HtmlCharacterEntities.decode(message.content),
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: AppTheme.darkerText,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.3
                                        )
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 2.0, top: 4.0),
                                        child: Text(
                                          '${message.createdAt!.hour}:${message.createdAt!.minute}',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 11.0,
                                            color: Colors.grey.shade600,
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
                        },
                      )
                  )),
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
          Row(
            children: <Widget>[
              IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back,color: Colors.black,),
              ),
              SizedBox(width: 2.0),
              (advert.user['fileUrl'] == null) ?
              Container(
                width: 32.0,
                height: 32.0,
                child: CircleAvatar(
                    backgroundColor: AppTheme.primary,
                    maxRadius: 20.0,
                    child: Container(
                      child: Text(
                        '${advert.user['username'][0]}',
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
                backgroundImage: NetworkImage('https://oblackmarket.com/public/' + advert.user['fileUrl']),
                maxRadius: 20,
              ),
              SizedBox(width: 12,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '${advert.user['username']}',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600
                      )
                    ),
                    SizedBox(height: 3.0),
                    Text(
                      'Connecté ${timeago.format(DateTime.parse(advert.user['lastLoginAt']), locale: 'fr')}',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12.0
                      )
                    ),
                  ],
                ),
              ),
            ],
          ),
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
                      child: (advert.images.isEmpty) ?
                      Image.asset('assets/images/no_photo.png', fit: BoxFit.cover) :
                      CachedNetworkImage(
                        imageUrl: 'https://oblackmarket.com/public/' + advert.photoPrincipale(),
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
                            '${advert.title}',
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
                                '${advert.price}',
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
                  await controller.sendMessage(id: advert.id);
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
}




