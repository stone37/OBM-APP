import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:obm_market/constants/app_theme.dart';
import '../../../../modules/advert/models/entities/advert.dart';
import '../../../../modules/user/advert/controllers/user_advert_controller.dart';
import '../../../widgets/advert/user_advert_view.dart';

class UserAlertScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    UserAdvertController controller = Get.find();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          elevation: 0,
          backgroundColor: AppTheme.background,
          title: Text(
            'Mes annonces inactif',
            style: TextStyle(
              color: AppTheme.darkerText
            )
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            splashRadius: 25.0,
            onPressed: () => Get.back(),
          ),
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
                      FutureBuilder<List<Advert>>(
                        future: controller.getUserAdvert(),
                        builder: (BuildContext context, AsyncSnapshot<List<Advert>> snapshot) {
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
                                        child: Image.asset('assets/images/annonce.png')
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                                        child: Text(
                                          'Aucune annonce inactif pour le moment !',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w600,
                                            color: AppTheme.darkerText
                                          ),
                                          textAlign: TextAlign.center,
                                        )
                                      ),
                                      Container(
                                          padding: EdgeInsets.only(bottom: 20.0),
                                          child: Text(
                                            'C\'est ici que vous verrez toutes vos annonces qui ne sont pas visibles par les acheteurs, telles que les annonces récemment expirées.',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: AppTheme.grey,
                                            ),
                                            textAlign: TextAlign.center,
                                          )
                                      ),
                                      SizedBox(height: 62.0)
                                    ],
                                  )
                              );
                            } else {
                              return _buildAdvertView(controller, context, snapshot.data);
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
        ),
      ),
    );
  }

  Widget _buildAdvertView(UserAdvertController controller, BuildContext context, List<Advert>? adverts) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: adverts!.length,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(left: 13.0, right: 13.0, top: 5.0),
        itemBuilder: (BuildContext context, int index) {
          return UserAdvertView(advert: adverts[index], controller: controller);
        }
    );
  }
}


