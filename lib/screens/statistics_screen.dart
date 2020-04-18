import 'package:covid_app/api/summary_api.dart';
import 'package:covid_app/models/country.dart';
import 'package:covid_app/models/summary.dart';
import 'package:covid_app/screens/widgets/card_data.dart';
import 'package:covid_app/screens/widgets/container_chart.dart';
import 'package:covid_app/screens/widgets/inkwell_button.dart';
import 'package:covid_app/screens/widgets/subtititle.dart';
import 'package:covid_app/utils/app_colors.dart';
import 'package:covid_app/utils/format_number.dart';
import 'package:flutter/material.dart';

class StatisticsScreen extends StatefulWidget {
  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  bool myCountryActive = true;
  bool globalActive = false;
  List<bool> listSelected = [false, false, false];
  String country = "México";
  String countryCode = "MX";
  String slug = "mexico";
  final toggleCountries = ["US", "FR", "ES"];
  final slugs = ["united-states", "france", "spain"];
  //Numbers data
  String infecteds;
  String deaths;
  String recovered;
  String newCases;
  String newDeaths;
  SummaryResponse data;

  @override
  Widget build(BuildContext context) {
    final width = (MediaQuery.of(context).size.width);
    final widthToggleButton = (width - 75) * .5;
    final fontSizeCardTitle = width * .035;
    final fontSizeCardNumber = width * .05;
    return Scaffold(
      backgroundColor: purpleApp,
      body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        buildSubtitle("Estadisticas"),
        SizedBox(height: 10),
        Container(
          height: 60,
          margin: EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
              color: purpleLightToggle,
              borderRadius: BorderRadius.circular(30)),
          child: Row(children: [
            buildInkWellMyCountry(widthToggleButton),
            buildInkWellGlobal(widthToggleButton),
          ]),
        ),
        SizedBox(height: 10),
        Align(alignment: Alignment.center, child: buildToggleButtons()),
        FutureBuilder(
            future: SummaryAPI().getSummary(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                data = snapshot.data;
                if (globalActive) {
                  setGlobalData(data);
                } else if (myCountryActive) {
                  setCountryData(data, countryCode);
                } else {
                  setCountryData(data, countryCode);
                }
                return Container(
                    child: Column(children: [
                  buildFirstRowCards(
                      width, fontSizeCardNumber + 6, fontSizeCardTitle + 6),
                  buildSecondRowCards(
                      width, fontSizeCardNumber, fontSizeCardTitle)
                ]));
              } else {
                return Align(
                    alignment: Alignment.center,
                    child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 122),
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        )));
              }
            }),
        SizedBox(height: 20),
        buildContainerChart(width, fontSizeCardNumber)
      ])),
    );
  }

  ContainerChart buildContainerChart(double width, double fontSizeCardNumber) {
    return ContainerChart(
      countryCode: countryCode,
      fontSizeCardNumber: fontSizeCardNumber,
      width: width,
      slug: slug,
    );
  }

  Padding buildFirstRowCards(
      double width, double fontSizeCardNumber, double fontSizeCardTitle) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          buildClipRRectCardData(
            (width - 85) * .5,
            orangeApp,
            "Infectados",
            "$infecteds",
            fontSizeCardNumber,
            fontSizeCardTitle,
          ),
          buildClipRRectCardData(
            (width - 85) * .5,
            redApp,
            "Muertes",
            "$deaths",
            fontSizeCardNumber,
            fontSizeCardTitle,
          ),
        ]));
  }

  Padding buildSecondRowCards(
      double width, double fontSizeCardNumber, double fontSizeCardTitle) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          buildClipRRectCardData(
            (width - 85) * .32,
            greenApp,
            "Recuperados",
            "$recovered",
            fontSizeCardNumber,
            fontSizeCardTitle,
          ),
          buildClipRRectCardData(
            (width - 85) * .32,
            blueApp,
            "Nuevos Casos",
            "$newCases",
            fontSizeCardNumber,
            fontSizeCardTitle,
          ),
          buildClipRRectCardData(
            (width - 85) * .32,
            purpleLightApp,
            "Nuevas Muertes",
            "$newDeaths",
            fontSizeCardNumber,
            fontSizeCardTitle,
          ),
        ]));
  }

  CardData buildClipRRectCardData(double width, Color color, String text,
      String number, double sizeNumber, double sizeTitle) {
    return CardData(
      color: color,
      width: width,
      text: text,
      number: number,
      sizeNumber: sizeNumber,
      sizeTitle: sizeTitle,
    );
  }

  ToggleButtons buildToggleButtons() {
    return ToggleButtons(
      color: Colors.white,
      disabledColor: Colors.white54,
      borderColor: Colors.transparent,
      disabledBorderColor: Colors.transparent,
      fillColor: Colors.transparent,
      selectedBorderColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      textStyle: TextStyle(
          fontFamily: "Nunito", fontSize: 18, fontWeight: FontWeight.bold),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: toogleText("EUA", listSelected[0]),
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: toogleText("Francia", listSelected[1])),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: toogleText("España", listSelected[2]),
        ),
      ],
      isSelected: listSelected,
      onPressed: (index) {
        setState(() {
          for (var i = 0; i < listSelected.length; i++) {
            listSelected[i] = false;
          }
          listSelected[index] = true;
          globalActive = false;
          myCountryActive = false;
          countryCode = toggleCountries[index];
          slug = slugs[index];
        });
      },
    );
  }

  Text toogleText(String text, bool active) {
    return Text(text,
        style: TextStyle(color: active ? Colors.white : Colors.white38));
  }

  InkWellButton buildInkWellGlobal(double widthToggleButton) {
    return InkWellButton(
      widthToggleButton: widthToggleButton,
      edgeInsets: EdgeInsets.only(right: 0),
      isActive: globalActive,
      onTap: () {
        setState(() {
          myCountryActive = false;
          globalActive = true;
        });
      },
      text: swapText("Global", globalActive),
    );
  }

  InkWellButton buildInkWellMyCountry(double widthToggleButton) {
    return InkWellButton(
      widthToggleButton: widthToggleButton,
      edgeInsets: EdgeInsets.symmetric(horizontal: 5),
      isActive: myCountryActive,
      onTap: () {
        setState(() {
          myCountryActive = true;
          globalActive = false;
          countryCode = "MX";
          slug = "mexico";
        });
      },
      text: swapText(country, myCountryActive),
    );
  }

  Text swapText(String text, bool active) {
    var color = active ? purpleApp : Colors.white30;
    return Text(text,
        style: TextStyle(
            color: color,
            fontFamily: "Nunito",
            fontSize: 20,
            fontWeight: active ? FontWeight.bold : FontWeight.normal));
  }


  setGlobalData(SummaryResponse response) {
    infecteds = formatNumber(response.global.totalConfirmed);
    deaths = formatNumber(response.global.totalDeaths);
    recovered = formatNumber(response.global.totalRecovered);
    newCases = formatNumber(response.global.newConfirmed);
    newDeaths = formatNumber(response.global.newDeaths);
  }

  setCountryData(SummaryResponse response, String countryCode) {
    Country country;
    response.countries.forEach((element) {
      if (element.countryCode == countryCode) {
        country = element;
      }
    });
    infecteds = formatNumber(country.totalConfirmed);
    deaths = formatNumber(country.totalDeaths);
    recovered = formatNumber(country.totalRecovered);
    newCases = formatNumber(country.newConfirmed);
    newDeaths = formatNumber(country.newDeaths);
  }
}
