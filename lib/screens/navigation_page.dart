import 'package:covid_app/screens/home.dart';
import 'package:covid_app/screens/statistics_screen.dart';
import 'package:covid_app/screens/widgets/app_bar.dart';
import 'package:covid_app/screens/world_summary.dart';
import 'package:flutter/material.dart';

class NavigationPage extends StatefulWidget {
  NavigationPage({Key key}) : super(key: key);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int index;
  PageController pageController;
  @override
  void initState() {
    super.initState();
    index = 0;
    pageController = PageController(initialPage: index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: PageView(
          onPageChanged: (value) {
            setState(() {
              index = value;
            });
          },
          controller: pageController,
          children: [HomePage(), StatisticsScreen(), WorldSummary()]),
      bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedItemColor: Colors.grey[400],
          showUnselectedLabels: false,
          currentIndex: index,
          onTap: (value) {
            pageController.jumpToPage(value);
            setState(() {
              index = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              
                icon: Icon(Icons.home),
                title: Text(
                  "Home",
                  style: TextStyle(
                    fontFamily: "Nunito",
                  ),
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.insert_chart),
                title: Text(
                  "Estadisticas",
                  style: TextStyle(fontFamily: "Nunito"),
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.group_work),
                title: Text(
                  "Mundo",
                  style: TextStyle(fontFamily: "Nunito"),
                )),
          ]),
    );
  }
}
