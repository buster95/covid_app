 import 'package:covid_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar() {
    return AppBar(
      backgroundColor: purpleApp,
      elevation: 0,
      leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.notifications_none),
          onPressed: () {},
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        )
      ],
    );
  }