import 'package:flutter/material.dart';

class LinkText extends StatelessWidget {
  String fontFamily;
  Color colorText;
  double size;
  String text;
  VoidCallback onTap;
  TextDecoration textDecoration;
  LinkText(
      {Key key,
      this.fontFamily = "Nunito",
      this.colorText = Colors.white,
      this.size = 16,
      this.text = "LinkText",
      @required this.onTap,
      this.textDecoration = TextDecoration.none})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Text(
          text,
          style: TextStyle(
              color: colorText,
              fontSize: size,
              fontFamily: fontFamily,
              decoration: textDecoration),
        ));
  }
}
