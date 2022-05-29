import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:obm_market/modules/report/controllers/report_controller.dart';
import 'package:obm_market/views/common/form_advert_data.dart';

import '../../../constants/app_theme.dart';
import '../../../modules/advert/models/entities/advert.dart';
import '../../../utils/validator.dart';
import '../../common/btn_bulk.dart';
import '../../widgets/message/successMessage.dart';
import '../../widgets/report/report_data.dart';

class ReportScreen extends StatelessWidget {
  ReportScreen({required this.advert});

  final Advert advert;
  final ReportController controller = Get.put<ReportController>(ReportController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppTheme.primary,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppTheme.primary,
        leading: IconButton(
          splashRadius: 20.0,
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Signaler un abus',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.3
          )
        )
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      ReportReasonFielData(controller: controller),
                      SizedBox(height: 20.0),

                      (!box.hasData('user_email')) ?
                        Padding(
                          padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 5.0, bottom: 5.0),
                                child: Text(
                                  'Votre email',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                    color: AppTheme.darkerText,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                              ),
                              Container(
                                child: FormDataField(
                                  prefix: Icon(Icons.email, color: AppTheme.grey),
                                  controller: controller.emailController,
                                  validator: Validator().email,
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (value) => null,
                                  onSaved: (value) => controller.emailController.text = value!,
                                ),
                              )
                            ],
                          ),
                        ) : SizedBox(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 5.0, bottom: 5.0),
                              child: Text(
                                'Votre message',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.darkerText,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ),
                            Container(
                              child: FormDataTextarea(
                                controller: controller.contentController,
                                validator: AdvertValidator().description,
                                maxLines: 8,
                                hintText: 'Merci de nous préciser les détails de l\'annonce vous amenant à signaler cette annonce.',
                                onChanged: (value) => null,
                                onSaved: (value) => controller.contentController.text = value!,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width*0.88,
                              child: PageButton(
                                text: 'Envoyer',
                                textColor: AppTheme.white,
                                backgroundColor: AppTheme.primary,
                                borderColor: AppTheme.primary,
                                iconPosition: 'right',
                                icon: FontAwesomeIcons.paperPlane,
                                callback: () async {

                                  (controller.reason.value.isEmpty) ?
                                  controller.reasonValidatorState.value = 'error' :
                                  controller.reasonValidatorState.value = '';

                                  if (_formKey.currentState!.validate() && controller.reason.value.isNotEmpty) {
                                    bool response = await controller.create(advertId: advert.id);

                                    if (response == true) {
                                      Get.back(result: advert);
                                      showSuccessMessage(message: 'Merci pour votre signalement.');
                                    }
                                  }
                                }
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}



