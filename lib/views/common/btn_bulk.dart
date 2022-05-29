import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BtnBulk extends StatelessWidget {
  const BtnBulk({
    required this.text,
    required this.color,
    required this.backgroundColor,
    required this.borderColor,
    this.icon,
    this.iconPosition,
    required this.callback
  }) : super();

  final String text;
  final Color backgroundColor;
  final Color color;
  final Color borderColor;
  final IconData? icon;
  final String? iconPosition;
  final VoidCallback callback;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 43.0,
      child: ElevatedButton(
        onPressed: callback,
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(5.0),
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
          padding: MaterialStateProperty.all(EdgeInsets.only(top: 9.0, bottom: 9.0)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: BorderSide(color: borderColor),
            )
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            (icon != null && iconPosition == 'left') ?
              Container(padding: EdgeInsets.only(right: 8.0), child: Icon(icon, size: 15.0, color: color))
                : SizedBox(),
            Container(
              padding: EdgeInsets.only(top: 1.0),
              child: Text(
                text,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w500,
                  fontSize: 15.0,
                  letterSpacing: 0.3
                )
              ),
            ),
            (icon != null && iconPosition == 'right') ?
              Container(padding: EdgeInsets.only(left: 8.0), child: Icon(icon, size: 15.0))
                : SizedBox()
          ],
        ),
      ),
    );
  }
}

class BtnBulkImg extends StatelessWidget {
  const BtnBulkImg({
    required this.text,
    required this.color,
    required this.backgroundColor,
    required this.borderColor,
    this.image,
    this.imagePosition,
    required this.callback
  }) : super();

  final String text;
  final Color backgroundColor;
  final Color color;
  final Color borderColor;
  final Image? image;
  final String? imagePosition;
  final VoidCallback callback;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 43.0,
      child: ElevatedButton(
        onPressed: callback,
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(3.0),
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
          padding: MaterialStateProperty.all(EdgeInsets.only(top: 9.0, bottom: 9.0)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: BorderSide(color: borderColor)
              )
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            (image != null && imagePosition == 'left') ?
            Container(
              padding: EdgeInsets.only(right: 8.0, top: 4.5, bottom: 4.5),
              child: image
            ) : SizedBox(),
            Container(
              padding: EdgeInsets.only(top: 1.0),
              child: Text(
                text,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w500,
                  fontSize: 15.0,
                  letterSpacing: 0.3
                )
              ),
            ),
            (image != null && imagePosition == 'right') ?
            Container(padding: EdgeInsets.only(left: 8.0, bottom: 2.0), child: image)
                : SizedBox()
          ],
        ),
      ),
    );
  }
}

class PageButton extends StatelessWidget {
  const PageButton({
    required this.text,
    required this.textColor,
    required this.backgroundColor,
    required this.borderColor,
    this.icon,
    this.iconPosition,
    this.elevation = 2.0,
    this.overlay = false,
    this.callback
  }) : super();

  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final IconData? icon;
  final String? iconPosition;
  final double elevation;
  final bool overlay;
  final VoidCallback? callback;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47.0,
      child: ElevatedButton(
        onPressed: callback,
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(elevation),
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
          padding: MaterialStateProperty.all(EdgeInsets.only(top: 9.0, bottom: 9.0)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: BorderSide(color: borderColor),
            )
          ),
          overlayColor: overlay ? MaterialStateProperty.all<Color>(backgroundColor) : null
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            (icon != null && iconPosition == 'left') ?
            Container(padding: EdgeInsets.only(right: 8.0), child: Icon(icon, size: 15.0, color: textColor))
                : SizedBox(),
            Container(
              padding: EdgeInsets.only(top: 1.0),
              child: Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 15.0,
                  letterSpacing: 0.3
                )
              ),
            ),
            (icon != null && iconPosition == 'right') ?
            Container(padding: EdgeInsets.only(left: 8.0), child: Icon(icon, size: 15.0, color: textColor))
                : SizedBox()
          ],
        )
      ),
    );
  }
}

class PageButtonSm extends StatelessWidget {
  const PageButtonSm({
    required this.text,
    required this.textColor,
    required this.backgroundColor,
    required this.borderColor,
    this.icon,
    this.iconPosition,
    this.elevation = 2.0,
    this.overlay = false,
    required this.callback
  }) : super();

  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final IconData? icon;
  final String? iconPosition;
  final double elevation;
  final bool overlay;
  final VoidCallback callback;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 33.0,
      child: ElevatedButton(
          onPressed: callback,
          style: ButtonStyle(
              elevation: MaterialStateProperty.all(elevation),
              backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
              padding: MaterialStateProperty.all(EdgeInsets.only(top: 7.0, bottom: 8.0, left: 10.0, right: 10.0)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: BorderSide(color: borderColor),
                )
              ),
              overlayColor: overlay ? MaterialStateProperty.all<Color>(backgroundColor) : null
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              (icon != null && iconPosition == 'left') ?
              Container(padding: EdgeInsets.only(right: 8.0), child: Icon(icon, size: 14.0, color: textColor))
                  : SizedBox(),
              Container(
                padding: EdgeInsets.only(top: 1.0),
                child: Text(
                  text,
                  style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                      letterSpacing: 0.3
                  )
                ),
              ),
              (icon != null && iconPosition == 'right') ?
              Container(padding: EdgeInsets.only(left: 8.0), child: Icon(icon, size: 14.0, color: textColor))
                  : SizedBox()
            ],
          )
      ),
    );
  }
}

