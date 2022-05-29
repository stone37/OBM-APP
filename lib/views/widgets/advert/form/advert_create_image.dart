import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:obm_market/modules/advert/controllers/advert_create_controller.dart';
import '../../../../constants/app_theme.dart';

class AdvertCreateImage extends StatelessWidget {
  const AdvertCreateImage({
    Key? key,
    required this.image,
    required this.controller,
    required this.index
  }) : super(key: key);

  final File image;
  final AdvertCreateController controller;
  final int index;

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      alignment: Alignment.center,
      child: Stack(
        children: [
          Container(
            width: 150.0,
            height: 155.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: AppTheme.grey.withOpacity(0.4),
                  offset: const Offset(1.1, 1.1),
                  blurRadius: 3.75
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              child: Image.file(image, fit: BoxFit.cover)
            )
          ),
          Positioned(
            top: 5,
            right: 6,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  controller.deleteImage(image);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 28.0,
                  width: 28.0,
                  padding: EdgeInsets.only(left: 1.0),
                  constraints: BoxConstraints(maxWidth: 40.0),
                  decoration: BoxDecoration(
                    color: AppTheme.danger_color,
                    borderRadius: BorderRadius.circular(20.0)
                  ),
                  child: FaIcon(FontAwesomeIcons.times, color: AppTheme.white, size: 18.0),
                ),
              )
            ),
          ),

          (index == 0) ? Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              alignment: Alignment.center,
              height: 30.0,
              padding: EdgeInsets.only(left: 1.0),
              constraints: BoxConstraints(maxWidth: 40.0),
              decoration: BoxDecoration(
                color: AppTheme.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0)
                ),
              ),
              child: Text(
                'Photo principale',
                style: TextStyle(
                  color: AppTheme.white,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.3
                ),
              ),
            ),
          ) : SizedBox()
        ],
      )
    );
  }
}
