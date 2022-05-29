import 'package:flutter/material.dart';
import 'package:obm_market/constants/app_theme.dart';

class LoginBtn extends StatelessWidget {
  const LoginBtn({Key? key, required this.onPressed}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12.0, bottom: 12.0, right: 20.0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(AppTheme.white),
          padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 12.0)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))
          ),
          elevation: MaterialStateProperty.all(5.0)
        ),
        onPressed: onPressed,
        child: Text(
          'Se connecter',
          style: TextStyle(
            color: AppTheme.primary,
            fontWeight: FontWeight.w600,
            fontSize: 13,
            letterSpacing: 0.3
          )
        ),
      ),
    );
  }
}

