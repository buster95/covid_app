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
    final fontTitleSize = width * .045;
    final fontSubTitleSize = width * .04;

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
                  data.sort((a, b) => b.totalDeaths.compareTo(a.totalDeaths));

                  return ListView(
                      physics: BouncingScrollPhysics(),
                      // itemExtent: 140,
                      // diameterRatio: 5,
                      children: List.generate(data.length, (i) {
                        return buildContainerCountry(
                            data[i], fontTitleSize, fontSubTitleSize);
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

  Container buildContainerCountry(Country data, titleSize, subtitleSize) {
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
          Row(children: [
            Image.network(
              "https://www.countryflags.io/${data.countryCode.toLowerCase()}/flat/32.png",
              height: 25,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              data.country,
              style: TextStyle(
                  color: Colors.grey[700],
                  fontFamily: "Nunito",
                  fontSize: titleSize,
                  fontWeight: FontWeight.bold),
            ),
          ]),
          SizedBox(height: 5),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            buildTextSpan("Infectados", subtitleSize, data.totalConfirmed,
                Colors.orangeAccent[400], "assets/img/cough.png"),
            buildTextSpan("Muertes", subtitleSize, data.totalDeaths,
                Colors.redAccent[400], "assets/img/death.png"),
            buildTextSpan("Recuperados", subtitleSize, data.totalRecovered,
                Colors.greenAccent[700], "assets/img/healthy.png"),
          ])
        ]));
  }

  RichText buildTextSpan(
      String title, double sizeText, int data, Color color, path) {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: " $title\n",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "Nunito",
                color: color,
                fontSize: sizeText),
            children: [
              TextSpan(
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey[700]),
                  text: formatNumber(data))
            ]));
  }
}
