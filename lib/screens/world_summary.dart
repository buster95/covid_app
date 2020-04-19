import 'package:covid_app/api/summary_api.dart';
import 'package:covid_app/models/country.dart';
import 'package:covid_app/screens/widgets/subtititle.dart';
import 'package:covid_app/utils/app_colors.dart';
import 'package:covid_app/utils/format_number.dart';
import 'package:flutter/material.dart';

class WorldSummary extends StatelessWidget {
  WorldSummary({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.white, purpleApp],
                  begin: Alignment.bottomCenter,
                  end: Alignment.center)),
        ),
        Column(children: [
          Container(
              width: width,
              padding: EdgeInsets.only(bottom: 30, right: 30),
              color: purpleApp,
              child: Row(children: [
                buildSubtitle("Resumen Global"),
                SizedBox(width: 10),
                SizedBox(
                  height: width * .07,
                  child: Image.asset("assets/img/global.png"),
                )
              ])),
          Expanded(
            child: FutureBuilder(
              future: SummaryAPI().getSummary(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  List<Country> data = snapshot.data.countries;
                  return ListView(
                      physics: BouncingScrollPhysics(),
                      // itemExtent: 140,
                      // diameterRatio: 5,
                      children: List.generate(data.length, (i) {
                        return buildContainerCountry(data[i]);
                      }));
                }
                return Center(
                    child: SizedBox(
                        height: 100,
                        width: 100,
                        child: CircularProgressIndicator(
                          strokeWidth: 10,
                        )));
              },
            ),
          ),
        ]),
      ]),
    );
  }

  Container buildContainerCountry(Country data) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 5,
                  color: Color.fromRGBO(0, 0, 0, .1),
                  offset: Offset(-3, 3))
            ],
            borderRadius: BorderRadius.circular(10)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            data.country,
            style: TextStyle(
                color: Colors.grey[700],
                fontFamily: "Nunito",
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            buildTextSpan("Infectados", data.totalConfirmed, orangeApp, "assets/img/cough.png"),
            buildTextSpan("Muertes", data.totalDeaths, redApp,"assets/img/death.png"),
            buildTextSpan("Recuperados", data.totalRecovered, greenApp, "assets/img/healthy.png"),
          ])
        ]));
  }

  RichText buildTextSpan(String title, int data, Color color, path) {
    return 
      RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: " $title\n",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "Nunito",
                  color: color,
                  fontSize: 18),
              children: [
                TextSpan(
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey[700]),
                    text: formatNumber(data))
              ]))
   ;
  }
}
