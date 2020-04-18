import 'dart:convert';

import 'country.dart';
import 'global.dart';

SummaryResponse responseSummary;

Future<SummaryResponse> summaryResponseFromJson(String str) async {
  if (responseSummary == null) {
    responseSummary = SummaryResponse.fromJson(json.decode(str));
  }
  return responseSummary;
}

Future<String> summaryResponseToJson(SummaryResponse data) async {
  return json.encode(data.toJson());
}

class SummaryResponse {
  Global global;
  List<Country> countries;
  DateTime date;

  SummaryResponse({
    this.global,
    this.countries,
    this.date,
  });

  factory SummaryResponse.fromJson(Map<String, dynamic> json) {
    return SummaryResponse(
        global: Global.fromJson(json["Global"]),
        countries: List<Country>.from(
            json["Countries"].map((x) => Country.fromJson(x))),
        date: DateTime.parse(json["Date"]),
      );
  }

  Map<String, dynamic> toJson() => {
        "Global": global.toJson(),
        "Countries": List<dynamic>.from(countries.map((x) => x.toJson())),
        "Date": date.toIso8601String(),
      };
}
