import 'dart:async';

import 'package:covid_app/models/summary.dart';
import 'package:http/http.dart' as http;

class SummaryAPI {
  Future<SummaryResponse> getSummary() async {
    if (responseSummary == null) {
      print(responseSummary);
      final resp = await http.get("https://api.covid19api.com/summary");
      return summaryResponseFromJson(resp.body);
    } else {
      await Future.delayed(Duration(milliseconds: 500));
      return responseSummary;
    }
  }
}
