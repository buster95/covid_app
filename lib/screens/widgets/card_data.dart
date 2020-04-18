import 'package:flutter/material.dart';

class CardData extends StatelessWidget {
  double width;
  Color color;
  String text;
  double sizeTitle;
  String number;
  double sizeNumber;

  CardData({
    Key key,
    this.width,
    this.color,
    this.text,
    this.sizeTitle,
    this.number,
    this.sizeNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          height: 120,
          width: width,
          color: color,
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      text,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Nunito",
                          fontSize: sizeTitle,
                          fontWeight: FontWeight.normal),
                    ),
                    Text(
                      number,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: sizeNumber,
                          fontFamily: "Nunito",
                          wordSpacing: 0,
                          fontWeight: FontWeight.bold),
                    ),
                  ])),
        ));
  }
}
