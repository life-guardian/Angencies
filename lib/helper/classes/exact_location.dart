import 'package:geocoding/geocoding.dart';

class ExactLocation {
  Future<String> locality({required double lat, required double lng}) async {
    String? locality;
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      Placemark placemark = placemarks[0];
      locality = placemark.locality;
    } catch (e) {
      //
    }
    return locality!;
  }
}
