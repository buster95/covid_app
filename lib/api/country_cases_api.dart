import 'package:covid_app/models/country_cases.dart';
import 'package:http/http.dart' as http;

class CountryCasesAPI {
  Future<List<CountryCases>> getCountryCases(String slug) async {
    switch (slug) {
      case "mexico":
        if (mexicoList != null) {
          await Future.delayed(Duration(milliseconds: 500));
          return mexicoList;
        }
        break;
      case "united-states":
        if (euaList != null) {
          await Future.delayed(Duration(milliseconds: 500));
          return euaList;
        }
        break;
      case "france":
        if (franceList != null) {
          await Future.delayed(Duration(milliseconds: 500));
          return franceList;
        }
        break;
      case "spain":
        if (spainList != null) {
          await Future.delayed(Duration(milliseconds: 500));
          return spainList;
        }
        break;
      default:
    }

    final resp = await http.get(
        "https://api.covid19api.com/dayone/country/$slug/status/confirmed");
    return countryCasesFromJson(resp.body, slug);
  }
}
