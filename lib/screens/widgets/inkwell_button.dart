import 'package:flutter/material.dart';

class InkWellButton extends StatelessWidget {
  double widthToggleButton;
  Text text;
  bool isActive;
  EdgeInsets edgeInsets;
  Function onTap;

  InkWellButton({
    Key key,
    this.widthToggleButton,
    this.text,
    this.isActive,
    this.edgeInsets,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: 50,
        width: widthToggleButton,
        alignment: Alignment.center,
        margin: edgeInsets,
        child: text,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: isActive ? Colors.white : Colors.transparent),
      ),
    );
  }
}
