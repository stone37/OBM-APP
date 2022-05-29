import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:obm_market/constants/app_theme.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.background,
      ),
      width: 180,
      height: 90,
      padding: EdgeInsets.all(0),
      child: Image.asset('assets/gif/Loading.gif'),
    );
  }
}

showLoading() {
  BotToast.showCustomLoading(toastBuilder: (close) {
    return LoadingWidget();
  });
}

stopLoading() {
  BotToast.closeAllLoading();
}



