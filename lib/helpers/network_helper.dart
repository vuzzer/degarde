import 'dart:convert';
import 'package:degarde/config/keys.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

var logger = Logger(printer: PrettyPrinter());

class NetworkHelper {
  NetworkHelper(
      {required this.startLng,
      required this.startLat,
      required this.endLng,
      required this.endLat});

  final String url = 'https://api.openrouteservice.org/v2/directions/';
  String apiKey = apiKeys;
  final String journeyMode =
      'driving-car'; // Change it if you want or make it variable
  final double startLng;
  final double startLat;
  final double endLng;
  final double endLat;

  Future getData() async {
    //await  dotenv.load(fileName: ".env");
    //apiKey = dotenv.get('apiKey');
    http.Response response = await http.get(Uri.parse(
        '$url$journeyMode?api_key=$apiKey&start=$startLng,$startLat&end=$endLng,$endLat'));
    logger.d(
        "$url$journeyMode?$apiKey&start=$startLng,$startLat&end=$endLng,$endLat");

    if (response.statusCode == 200) {
      String data = response.body;
      return json.decode(data);
    } else {
      logger.d(response.statusCode);
    }
  }
}
