import 'package:covid_app/screens/call_screen.dart';
import 'package:covid_app/screens/widgets/custom_button.dart';
import 'package:covid_app/screens/widgets/link_text.dart';
import 'package:covid_app/screens/widgets/subtititle.dart';
import 'package:covid_app/utils/app_colors.dart';
import 'package:covid_app/utils/launcher_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = (MediaQuery.of(context).size.width);
    final widthButton = (width - 75) * .5;
    final fontSizeButton = (width) * .045;
    final imageWidht = width * .2;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
              padding: EdgeInsets.only(bottom: 40),
              decoration: BoxDecoration(
                  color: purpleApp,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50))),
              alignment: Alignment.topCenter,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTopRowContainer(),
                    SizedBox(height: 30),
                    buildMessageHome(),
                    SizedBox(height: 30),
                    buildRowButtons(fontSizeButton, widthButton, context)
                  ])),
          SizedBox(height: 25),
          Container(
              width: width,
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Por prevención",
                        style: TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800])),
                    SizedBox(height: 20),
                    buildRowPreventions(imageWidht),
                    SizedBox(height: 20),
                    Stack(alignment: Alignment.bottomLeft, children: [
                      Container(
                          width: width,
                          height: 130,
                          padding: EdgeInsets.only(top: 20, right: 30),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              gradient: LinearGradient(
                                colors: [
                                  lightGradientColor,
                                  darkGradientColor,
                                ],
                              )),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Haz tu propio test",
                                  style: TextStyle(
                                      fontFamily: "Nunito",
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: fontSizeButton),
                                ),
                                Text(
                                  "Entra a la página",
                                  style: TextStyle(
                                      fontFamily: "Nunito",
                                      color: Colors.white,
                                      fontSize: fontSizeButton - 5),
                                ),
                                LinkText(
                                    text: "test.covid19.cdmx.gob.mx",
                                    size: fontSizeButton - 5,
                                    onTap: () {
                                      LauncherService.openHttps(
                                          "test.covid19.cdmx.gob.mx");
                                    })
                              ])),
                      SizedBox(
                          height: width * .37,
                          child: Image.asset("assets/img/distance.png"))
                    ])
                  ]))
        ]),
      ),
    );
  }

  Row buildRowPreventions(double imageWidht) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      buildPreventionCard(
          imageWidht, "Laváte las manos", "assets/img/washing-hands.png"),
      buildPreventionCard(
          imageWidht, "Quédate en casa", "assets/img/house.png"),
      buildPreventionCard(
          imageWidht, "Manten tu distancia", "assets/img/self-defense.png")
    ]);
  }

  Column buildPreventionCard(double imageWidht, String text, String asset) {
    return Column(children: [
      SizedBox(
          width: imageWidht, height: imageWidht, child: Image.asset(asset)),
      SizedBox(
        height: 10,
      ),
      SizedBox(
          width: imageWidht,
          child: Text(text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "Nunito",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700]))),
    ]);
  }

  Padding buildRowButtons(
      double fontSizeButton, double widthButton, BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          CustomRaisedButton(
            color: redButton,
            text: "Llama ahora",
            icon: Icons.call,
            textSize: fontSizeButton,
            radius: 30,
            height: 50,
            width: widthButton,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CallState(
                            iconData: Icons.phone,
                            onPressed: LauncherService.call,
                            isForCall: true,
                          )));
            },
          ),
          CustomRaisedButton(
            color: blueButton,
            text: "Envia SMS",
            icon: Icons.message,
            textSize: fontSizeButton,
            radius: 30,
            height: 50,
            width: widthButton,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CallState(
                            iconData: Icons.message,
                            onPressed: LauncherService.sendSms,
                            isForCall: false,
                          )));
            },
          ),
        ]));
  }

  Padding buildMessageHome() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: RichText(
          text: TextSpan(
            text: "¿Te sientes enfermo?",
            style: TextStyle(
                fontFamily: "Nunito",
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24),
            children: [
              TextSpan(
                  text:
                      '\nSi presentas algunos de los síntomas ocaciosionados por Covid-19, por favor ponte en contacto con personal calificado.',
                  style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
            ],
          ),
        ));
  }

  Row buildTopRowContainer() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      buildSubtitle("Covid 19"),
      Container(
        margin: EdgeInsets.only(right: 30),
        height: 40,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
            padding: EdgeInsets.only(left: 7, right: 15),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: SizedBox(
                          height: 30,
                          width: 30,
                          child: Image.asset(
                            "assets/img/mexico.png",
                            fit: BoxFit.cover,
                          ))),
                  Text(
                    "MXN",
                    style: TextStyle(fontFamily: "Nunito", fontSize: 16),
                  )
                ])),
      )
    ]);
  }
}
