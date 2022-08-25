import 'package:degarde/helpers/network_helper.dart';
import 'package:test/test.dart';
import 'package:logger/logger.dart';

var logger = Logger(printer: PrettyPrinter());

void main() {
  test('opensource', () async {
    final map = NetworkHelper(
        startLng: -3.9879, startLat: 5.3549, endLng: -4.0018, endLat: 5.3036);
    final data = await map.getData() as Map;
    logger.d(data['features'][0][""]);
  });
}
