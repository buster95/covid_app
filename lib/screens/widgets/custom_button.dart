import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  VoidCallback onPressed;
  Color color;
  bool sufixIcon;
  Color textColor;
  double radius;
  IconData icon;
  String text;
  double textSize;
  double width;
  double height;
  bool onlyIcon;
  CustomRaisedButton({
    Key key,
    @required this.onPressed,
    this.color = Colors.blue,
    this.sufixIcon = false,
    this.textColor = Colors.white,
    this.radius = 10,
    this.icon,
    this.text = "",
    this.textSize = 20,
    this.width = 70,
    this.height = 20,
    this.onlyIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconButton = Padding(
        padding: sufixIcon ? EdgeInsets.only(left:10) : EdgeInsets.only(right: 10),
        child: Icon(
          icon,
          color: textColor,
          size: textSize + 8,
        ));

    final textButton = Text(
      text,
      style: TextStyle(
          color: textColor,
          fontFamily: "Nunito",
          fontSize: textSize,
          fontWeight: FontWeight.bold),
    );
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              blurRadius: 10,
              color: Color.fromRGBO(0, 0, 0, .09),
              offset: Offset(0, 2))
        ], borderRadius: BorderRadius.all(Radius.circular(radius))),
        child: RaisedButton(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius)),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              sufixIcon ? textButton : iconButton,
              sufixIcon ? iconButton : textButton,
            ]),
            color: color,
            onPressed: onPressed));
  }
}
