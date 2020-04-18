import 'package:flutter/material.dart';

import 'package:covid_app/models/covid_phones_states.dart';
import 'package:covid_app/utils/app_colors.dart';

class CallState extends StatelessWidget {
  IconData iconData;
  Function(String) onPressed;
  bool isForCall;

  CallState({
    Key key,
    @required this.iconData,
    @required this.onPressed,
    this.isForCall,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final list = PhonesState().getStateNumbers();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: purpleApp,
        title: Text(
          "Elige tu entidad federativa",
          style: TextStyle(fontFamily: "Nunito"),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: List.generate(list.length, (index) {
            return Column(children: [
              Padding(
                  padding: EdgeInsets.only(bottom: 10, top: 10),
                  child: buildRow(list, index)),
              Divider()
            ]);
          }),
        ),
      ),
    );
  }

  Row buildRow(List<PhonesState> list, int index) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              list[index].state,
              style: TextStyle(
                  color: Colors.grey[800],
                  fontFamily: "Nunito",
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              list[index].numberPhone,
              style: TextStyle(
                color: isForCall ? Colors.pinkAccent[700] : blueApp,
                fontFamily: "Nunito",
                fontSize: 18,
              ),
            ),
          ]),
      FloatingActionButton(
        heroTag: list[index],
        backgroundColor: isForCall ? blueApp : Colors.pinkAccent[400],
        mini: true,
        elevation: 0,
        child: Icon(
         iconData,
          size: 20,
        ),
        onPressed: () {
          onPressed(list[index].numberPhone);
        },
      )
    ]);
  }
}
