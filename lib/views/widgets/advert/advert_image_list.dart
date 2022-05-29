import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:obm_market/constants/app_theme.dart';
import 'package:obm_market/modules/advert/controllers/advert_view_controller.dart';

class AdvertImageList extends StatelessWidget {
  const AdvertImageList({Key? key, required this.images, required this.controller}) : super(key: key);

  final List<Map<String, dynamic>> images;
  final AdvertViewController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      color: Colors.black,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top-10, left: 20.0),
                    child: SizedBox(
                      width: AppBar().preferredSize.height - 12,
                      height: AppBar().preferredSize.height - 12,
                      child: Material(
                        color: AppTheme.white,
                        borderRadius:  BorderRadius.circular(30.0),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(AppBar().preferredSize.height),
                          child: Icon(
                            Icons.close,
                            color: AppTheme.nearlyBlack,
                          ),
                          onTap: () {
                            Get.back();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      '${controller.imageCurrent.value+1}/${images.length}',
                      style: TextStyle(
                        color: AppTheme.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3
                      ),
                    ),
                  )
                ],
              ),

              Container(
                margin: EdgeInsets.only(top: 100.0),
                child: CarouselSlider.builder(
                  itemCount: images.length,
                  options: CarouselOptions(
                      autoPlay: (images.isEmpty) ? false : true,
                      aspectRatio: 1.2,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        controller.imageCurrent.value = index;
                      }
                  ),
                  itemBuilder: (BuildContext context, int index, int pageViewIndex){
                    return (images.isEmpty) ?
                    Image.asset('assets/images/no_photo.png', fit: BoxFit.cover) :
                    CachedNetworkImage(
                      imageUrl: 'https://oblackmarket.com/public/'+images[index]['webPath'],
                      fit: BoxFit.cover,
                    );
                  },
                ),
              )
            ],
          )
        ),
      ),
    ));
  }
}

class AdvertFavoriteImageList extends StatelessWidget {
  const AdvertFavoriteImageList({Key? key, required this.images, required this.controller}) : super(key: key);

  final List<dynamic> images;
  final AdvertViewController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      color: Colors.black,
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top-10, left: 20.0),
                      child: SizedBox(
                        width: AppBar().preferredSize.height - 12,
                        height: AppBar().preferredSize.height - 12,
                        child: Material(
                          color: AppTheme.white,
                          borderRadius:  BorderRadius.circular(30.0),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(AppBar().preferredSize.height),
                            child: Icon(
                              Icons.close,
                              color: AppTheme.nearlyBlack,
                            ),
                            onTap: () {
                              Get.back();
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text(
                        '${controller.imageCurrent.value+1}/${images.length}',
                        style: TextStyle(
                            color: AppTheme.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.3
                        ),
                      ),
                    )
                  ],
                ),

                Container(
                  margin: EdgeInsets.only(top: 100.0),
                  child: CarouselSlider.builder(
                    itemCount: images.length,
                    options: CarouselOptions(
                        autoPlay: (images.isEmpty) ? false : true,
                        aspectRatio: 1.2,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          controller.imageCurrent.value = index;
                        }
                    ),
                    itemBuilder: (BuildContext context, int index, int pageViewIndex){
                      return (images.isEmpty) ?
                      Image.asset('assets/images/no_photo.png', fit: BoxFit.cover) :
                      CachedNetworkImage(
                        imageUrl: 'https://oblackmarket.com/public/'+images[index]['webPath'],
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                )
              ],
            )
        ),
      ),
    ));
  }
}
