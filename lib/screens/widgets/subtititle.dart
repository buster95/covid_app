  import 'package:flutter/material.dart';

Padding buildSubtitle(String text) {
    return Padding(
        padding: EdgeInsets.only(left: 30, top: 10),
        child: Text(text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              fontFamily: "Nunito",
            )));
  }
