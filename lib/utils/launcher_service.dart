import 'package:url_launcher/url_launcher.dart';

class LauncherService {
  static void call(String phone) {
    launch("tel:$phone");
  }

  static void sendSms(String phone) {
    launch("sms:$phone");
  }

  static void openHttps(String url) async{
    if(await canLaunch("https://$url")){
    launch("https://$url");
    }else{
      throw "Error al abrir pagina";
    }
  }
}
