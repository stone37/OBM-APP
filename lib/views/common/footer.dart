import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  Footer({
    required this.text,
    required this.logo,
    required this.funFooterLogin,
    required this.textColor
  });

  final String text;
  final String logo;
  final Color textColor;
  final VoidCallback funFooterLogin;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: funFooterLogin,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(
                  this.text,
                  style: TextStyle(
                    color: this.textColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              Container(
                width: 50,
                child: Image.asset(this.logo),
              )
            ],
          ),
        ),
      )
    );
  }
}
