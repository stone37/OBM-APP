import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants/app_theme.dart';

class AppDataUser extends StatelessWidget {
  const AppDataUser({Key? key, required this.onPressed}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(right: 20.0, top: 12.0, bottom: 12.0),
        child: Row(
          children: [
            _wallet('3000000'),
            SizedBox(
              width: 16.0,
            ),
            PopupMenuButton(
              onSelected: (item) => _selectedItem(context, item),
              child: _prefixText('S'),
              offset: Offset(66.0, 42.0),
              padding: EdgeInsets.all(0.0),
              elevation: 30.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))
              ),
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                _popupMenuItem('Tableau de bord', 0),
                _popupMenuItem('Mes annonces', 1),
                _popupMenuItem('Mes messages', 2),
                _popupMenuItem('Mes alertes', 3),
                _popupMenuItem('Mes favoris', 4),
                _popupMenuItem('Mon profil', 5),
                _popupMenuItem('Déconnexion', 6),
              ],
            ),
          ],
        )
    );
  }


  void _selectedItem(BuildContext context, item) {
    switch (item) {
      case 0:
      //Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingPage()));
        break;
      case 1:
        print("Privacy Clicked");
        break;
      case 2:
        print("User Logged out");
        //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
        break;
    }
  }

  Widget _prefixText(String prefix) {
    return Container(
      width: 35.0,
      height: 35.0,
      child: CircleAvatar(
        backgroundColor: AppTheme.white,
        child: Text(
            prefix,
            style: TextStyle(
              color: AppTheme.primary,
              fontWeight: FontWeight.w500,
            )
        ),
      ),
    );
  }

  Widget _prefixImage() {
    return Container(
      width: 35.0,
      height: 35.0,
      child: CircleAvatar(
        backgroundImage: AssetImage("images/1.jpg"),
      ),
    );
  }

  PopupMenuItem _popupMenuItem(String title, int value) {
    return PopupMenuItem<int>(
      value: value,
      child: Text(title),
      height: 35.0,
      textStyle: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          color: AppTheme.grey.withOpacity(0.8),
          letterSpacing: 0.3
      ),
    );
  }

  Widget _wallet(String sold) {
    return InkWell(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(50.0),
          border: Border.all(width: 1, style: BorderStyle.solid, color: AppTheme.defaults),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Icon(FontAwesomeIcons.wallet, size: 13.0, color: AppTheme.defaults),
            ),
            SizedBox(
              width: 4.0,
            ),
            Container(
              padding: EdgeInsets.only(top: 1.0),
              child: Text(
                  sold,
                  style: TextStyle(
                      color: AppTheme.defaults,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w700
                  )
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 1.0),
              width: 6.0,
              height: 9.0,
              child: Image.asset('images/devise.png'),
            )
          ],
        ),
      ),
    );
  }
}


